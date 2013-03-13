# coding: utf-8

require 'xmlsimple'

module PierreEtVacances
  class AccommodationImporter < ::AccommodationImporter
    def ftp_get
      FTP.get(xml_filename)
    end

    def import_accommodation(a)
      accommodation = PvAccommodation.new
      name = a['nom_produit'][0]['libelle'][0]
      name = name.gsub('Pierre & Vacances', '')
      name = name.gsub('Pierre&Vacances', '')
      accommodation.name = name.strip
      code = a['informations_generiques'][0]['references'][0]['interne_to'][0]['libelle'][0]
      accommodation.code = code.strip
      iso_3166_1 = location(a)['iso_3166-1'][0]['value']
      accommodation.iso_3166_1 = iso_3166_1.strip
      iso_3166_2 = location(a)['region'][0]['iso_3166-2'][0]['value']
      accommodation.iso_3166_2 = iso_3166_2.strip
      onu = location(a)['region'][0]['ville'][0]['onu'][0]['value']
      accommodation.onu = onu.strip
      accroche_liste = a['informations_commerciales'][0]['presentation_commerciale'][0]['accroche_liste'][0]['libelle'][0]
      accommodation.accroche_liste = accroche_liste.kind_of?(String) ? accroche_liste : ''
      accroche_fiche = a['informations_commerciales'][0]['presentation_commerciale'][0]['accroche_fiche'][0]['libelle'][0]
      accommodation.accroche_fiche = accroche_fiche.kind_of?(String) ? accroche_fiche : ''

      description = ''
      a['informations_commerciales'][0]['presentation_commerciale'][0]['descriptif'][0]['paragraphe'].each do |p|
        description += '<h2>' + p['titre'][0] + "</h2>\n"
        description += '<p>' + p['texte'][0].gsub("\n", "<br>\n") + "</p>\n" if p['texte'][0].kind_of?(String)
      end
      accommodation.description = description

      accommodation.longitude = address_part('longitude', a)
      accommodation.latitude = address_part('latitude', a)
      accommodation.address_1 = address_part('adresse 1', a)
      accommodation.address_2 = address_part('adresse 2', a)
      accommodation.postcode = address_part('code postal', a)
      accommodation.town = address_part('ville', a)

      sports = []
      begin
        a['informations_formule'][0]['location'][0]['sports'][0]['sport'].each do |s|
          sports << s['type_sport'][0]['value']
        end
      rescue
      end
      accommodation.sports = sports.join(',')

      services = []
      begin
        a['informations_formule'][0]['location'][0]['services'][0]['service'].each do |s|
          services << s['type_service'][0]['value']
        end
      rescue
      end
      accommodation.services = services.join(',')

      accommodation.price_table_url = a['lesprix'][0]['tableau_prix'][0]['objet'][0]['petit'][0]['content']
      accommodation.permalink = accommodation.code.downcase

      accommodation.photos = photos(a)

      accommodation.save

      if ppr = PvPlaceResort.find_by_pv_place_code(accommodation.place_code)
        create_property(accommodation, ppr.resort_id, accommodation.address_1)
      end
    end

    def address_part(title, a)
      (0..5).each do |i|
        para = a['informations_formule'][0]['location'][0]['station'][0]['domaine'][0]['paragraphe'][i]
        if para && para['titre'][0].strip == title
          return para['texte'][0].strip
        end
      end
      ''
    end

    def location(a)
      a['informations_generiques'][0]['destinations'][0]['destination'][0]['arrivee'][0]['pays'][0]
    end

    def photos(a)
      list = []
      begin
        a['informations_formule'][0]['location'][0]['hebergement_location'][0]['descriptif'][0]['paragraphe'][0]['objet'].each do |o|
          list << o['grand'][0]['content']
        end
      rescue
      end
      list.join(',')
    end

    def create_property(accommodation, resort_id, address)
      property = Property.find_by_pv_accommodation_id(accommodation.id)
      if property
        # delete the advert; we'll create a new one shortly
        property.current_advert.delete if property.current_advert
      else
        property = Property.new
      end

      property.pv_accommodation_id = accommodation.id
      property.user_id = @user.id
      property.resort_id = resort_id
      property.name = accommodation.name.blank? ? accommodation.code : accommodation.name
      property.strapline = accommodation.accroche_liste[0..254]
      property.address = address
      property.latitude = accommodation.latitude
      property.longitude = accommodation.longitude
      property.weekly_rent_price = 0 # TODO
    
      return if property.weekly_rent_price.nil?
      property.currency_id = @euro.id
      property.sleeping_capacity = 0 # TODO
      property.number_of_bedrooms = 0 # TODO

      property.description = accommodation.description
      property.publicly_visible = 1

      #if accommodation.features.include? 'parking'
      #  property.parking = Property::PARKING_OFF_STREET
      #else
      #  property.parking = Property::PARKING_ON_STREET
      #end

      #property.pets = accommodation.features.include? 'petsallowed'
      #property.smoking = !(accommodation.features.include? 'nonsmoking')
      #property.tv = Property::TV_YES if accommodation.features.include? 'tv'
      #property.wifi = accommodation.features.include? 'wlan'

      unless property.save
        Rails.logger.info(property.errors.to_s)
        accommodation.destroy
        return
      end

      #accommodation.interhome_pictures.each do |picture|
      #  image = Image.find_by_property_id_and_source_url(property.id, picture.url)

      #  if image.nil?
      #    image = Image.new
      #    image.user_id = @user.id
      #    image.source_url = picture.url
      #    image.property_id = property.id
      #    image.save
      #  end

      #  if picture.picture_type == 'm'
      #    property.image_id = image.id
      #    property.save
      #  end
      #end

      create_advert(property)
    end

    def xml_filename
      @xml_filename ||= FTP.property_filename(:summer)
    end

    def user_email
      'pierreetvacances@mychaletfinder.com'
    end

    def model_class
      PvAccommodation
    end

    def accommodations(xml)
      xml['catalogue'][0]['produits'][0]['produit']
    end
  end
end
