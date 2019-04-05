class PericlesProperty
  APARTMENT_FOR_SALE = 1
  HOUSE_FOR_SALE = 2
  APARTMENT_FOR_RENT = 11
  HOUSE_FOR_RENT = 12
  VALID_OFFER_TYPES = [APARTMENT_FOR_SALE, HOUSE_FOR_SALE, APARTMENT_FOR_RENT, HOUSE_FOR_RENT]

  attr_accessor :company_code         # CODE_SOCIETE
  attr_accessor :offer_type           # TYPE_OFFRE
  attr_accessor :site_code            # CODE_SITE
  attr_accessor :pericles_id          # NO_ASP
  attr_accessor :price                # PRIX
  attr_accessor :fees                 # HONORAIRES
  attr_accessor :local_rates          # TAXE_HABITATION
  attr_accessor :address_1            # ADRESSE1_OFFRE
  attr_accessor :address_2            # ADRESSE2_OFFRE
  attr_accessor :postcode             # CP_OFFRE
  attr_accessor :town                 # VILLE_OFFRE
  attr_accessor :category             # CATEGORIE
  attr_accessor :number_of_rooms      # NB_PIECES
  attr_accessor :number_of_bedrooms   # NB_CHAMBRES
  attr_accessor :living_area          # SURF_HAB
  attr_accessor :plot_size            # SURF_TERRAIN
  attr_accessor :floor                # ETAGE
  attr_accessor :number_of_floors     # NB_ETAGES
  attr_accessor :year_of_construction # ANNEE_CONS
  attr_accessor :kitchen              # CUISINE
  attr_accessor :number_of_toilets    # NB_WC
  attr_accessor :number_of_bathrooms  # NB_SDB
  attr_accessor :number_of_shower_rooms # NB_SE
  attr_accessor :number_of_garages    # GARAGE_BOX
  attr_accessor :lift                 # ASCENSEUR
  attr_accessor :balconies            # BALCON
  attr_accessor :terraces             # TERRASSE
  attr_accessor :swimming_pool        # PISCINE
  attr_accessor :disabled_access      # ACCES_HANDI
  attr_accessor :caves                # CAVES
  attr_accessor :text_de              # TEXTE_GER
  attr_accessor :text_en              # TEXTE_UK
  attr_accessor :text_es              # TEXTE_SP
  attr_accessor :text_fr              # TEXTE_FR
  attr_accessor :text_it              # TEXTE_IT

  def initialize(xml)
    @company_code = @site_code = @address_1 = @address_2 = @postcode =
                                                             @town = @category = @kitchen = ""
    @text_de = @text_en = @text_es = @text_fr = @text_it = ""
    @offer_type = @pericles_id = @price = @fees = @local_rates = @number_of_rooms =
                                                                   @number_of_bedrooms = @living_area = @floor = @number_of_floors =
                                                                                                                   @year_of_construction = @number_of_toilets = @number_of_bathrooms =
                                                                                                                                                                  @number_of_shower_rooms = @balconies = @terraces = @caves = 0
    @lift = @swimming_pool = @disabled_access = false

    @company_code         = val(xml["CODE_SOCIETE"])
    @offer_type           = val(xml["TYPE_OFFRE"]).to_i
    @site_code            = val(xml["CODE_SITE"])
    @pericles_id          = val(xml["NO_ASP"]).to_i
    @price                = val(xml["PRIX"]).to_i
    @fees                 = val(xml["HONORAIRES"]).to_i
    @local_rates          = val(xml["TAXE_HABITATION"]).to_i
    @address_1            = val(xml["ADRESSE1_OFFRE"])
    @address_2            = val(xml["ADRESSE2_OFFRE"])
    @postcode             = val(xml["CP_OFFRE"])
    @town                 = val(xml["TOWN"])
    @category             = val(xml["CATEGORIE"])
    @number_of_rooms      = val(xml["NB_PIECES"]).to_i
    @number_of_bedrooms   = val(xml["NB_CHAMBRES"]).to_i
    @living_area          = val(xml["SURF_HAB"]).to_i
    @plot_size            = val(xml["SURF_TERRAIN"]).to_i
    @floor                = val(xml["ETAGE"]).to_i
    @number_of_floors     = val(xml["NB_ETAGES"]).to_i
    @year_of_construction = val(xml["ANNEE_CONS"]).to_i
    @kitchen              = val(xml["KITCHEN"])
    @number_of_toilets    = val(xml["NB_WC"]).to_i
    @number_of_bathrooms  = val(xml["NB_SDB"]).to_i
    @number_of_shower_rooms = val(xml["NB_SE"]).to_i
    @number_of_garages    = val(xml["GARAGE_BOX"]).to_i
    @lift                 = val(xml["ASCENSEUR"]) == "Oui"
    @balconies            = val(xml["BALCON"]).to_i
    @terraces             = val(xml["TERRASSE"]).to_i
    @swimming_pool        = val(xml["PISCINE"]) == "Oui"
    @disabled_access      = val(xml["ACCES_HANDI"]) == "Oui"
    @text_de              = val(xml["TEXTE_GER"])
    @text_en              = val(xml["TEXTE_UK"])
    @text_es              = val(xml["TEXTE_SP"])
    @text_fr              = val(xml["TEXTE_FR"])
    @text_it              = val(xml["TEXTE_IT"])

    unless VALID_OFFER_TYPES.include? @offer_type
      raise "Unsupported offer type (TYPE_OFFRE)"
    end
  end

  def val(xml_element)
    if xml_element.is_a?(Array) && xml_element[0].is_a?(String)
      xml_element[0]
    else
      ""
    end
  end

  def prepare_property property
    property.pericles_id = @pericles_id
    property.name = @address_1
    if for_sale?
      property.sale_price = @price.to_i
      property.for_sale = true
    else
      property.weekly_rent_price = @price
    end
    property.address = "#{@address_1}\n#{@address_2}\n#{@town}"
    property.postcode = @postcode
    property.strapline = @text_en
    property.number_of_bathrooms = @number_of_bathrooms + @number_of_shower_rooms
    property.number_of_bedrooms = @number_of_bedrooms
    property.floor_area_metres_2 = @living_area
    property.plot_size_metres_2 = @plot_size
    property.parking = @number_of_garages > 0 ? Property::PARKING_GARAGE : Property::PARKING_ON_STREET
    property.balcony = @balconies > 0
    property.terrace = @terraces > 0
    property.disabled = @disabled_access
    describe property
  end

  def describe property
    property.description = ""
    unless @text_en.blank?
      property.description += "<h2>English</h2>" + @text_en + "\n\n"
    end
    unless @text_fr.blank?
      property.description += "<h2>Français</h2>" + @text_fr + "\n\n"
    end
    unless @text_de.blank?
      property.description += "<h2>Deutsch</h2>" + @text_de + "\n\n"
    end
    unless @text_it.blank?
      property.description += "<h2>Italiano</h2>" + @text_it + "\n\n"
    end
    unless @text_es.blank?
      property.description += "<h2>Español</h2>" + @text_es + "\n\n"
    end

    property.description += "<table>"
    property.description += "<tr><td>Price</td><td>#{@price} EUR</td></tr>\n"
    property.description += "<tr><td>Fees</td><td>#{@fees} EUR</td></tr>\n"
    property.description += "<tr><td>Local rates</td><td>#{@local_rates} EUR</td></tr>\n"
    property.description += "<tr><td>Number of rooms</td><td>#{@number_of_rooms}</td></tr>\n"
    property.description += "<tr><td>Living area</td><td>#{@living_area} m²</td></tr>\n" unless @living_area == 0
    property.description += "<tr><td>Plot size</td><td>#{@plot_size} m²</td></tr>\n" unless @plot_size == 0
    property.description += "<tr><td>Floor</td><td>#{@floor}</td></tr>\n" unless @floor == 0
    property.description += "<tr><td>Number of floors</td><td>#{@number_of_floors}</td></tr>\n" unless @number_of_floors == 0
    property.description += "<tr><td>Year of construction</td><td>#{@year_of_construction}</td></tr>\n" unless @year_of_construction == 0
    property.description += "<tr><td>Number of toilets</td><td>#{@number_of_toilets}</td></tr>\n" unless @number_of_toilets == 0
    property.description += "<tr><td>Number of bathrooms</td><td>#{@number_of_bathrooms}</td></tr>\n" unless @number_of_bathrooms == 0
    property.description += "<tr><td>Number of shower rooms</td><td>#{@number_of_shower_rooms}</td></tr>\n" unless @number_of_shower_rooms == 0
    property.description += "<tr><td>Kitchen</td><td>#{@kitchen}</td></tr>\n" unless @kichen.blank?
    property.description += "<tr><td>Garages</td><td>#{@number_of_garages}</td></tr>\n" unless @number_of_garages == 0
    property.description += "<tr><td>Lift</td><td>Yes</td></tr>\n" if @lift
    property.description += "<tr><td>Balconies</td><td>#{@balconies}</td></tr>\n" unless @balconies == 0
    property.description += "<tr><td>Terraces</td><td>#{@terraces}</td></tr>\n" unless @terraces == 0
    property.description += "<tr><td>Caves</td><td>#{@caves}</td></tr>\n" unless @caves == 0
    property.description += "<tr><td>Swimming pool</td><td>Yes</td></tr>\n" if @swimming_pool
    property.description += "</table>"
  end

  def for_sale?
    offer_type == APARTMENT_FOR_SALE || offer_type == HOUSE_FOR_SALE
  end

  def to_s
    "Company code:        #{@company_code}\n" /
      "Offer type:          #{@offer_type}\n" /
      "Site code:           #{@site_code}\n" /
      "Pericles ID          #{@pericles_id}\n" /
      "Price:               #{@price}\n" /
      "Fees:                #{@fees}\n" /
      "Local rates          #{@local_rates}\n" /
      "Address 1            #{@address_1}\n" /
      "Address 2            #{@address_2}\n" /
      "Postcode             #{@postcode}\n" /
      "Town                 #{@town}\n" /
      "Category             #{@category}\n" /
      "Number of rooms      #{@number_of_rooms}\n" /
      "Number of bedrooms   #{@number_of_bedrooms}\n" /
      "Living area          #{@living_area}\n" /
      "Plot size            #{@plot_size}\n" /
      "Floor                #{@floor}\n" /
      "Number of garages    #{@number_of_garages}\n"
  end
end
