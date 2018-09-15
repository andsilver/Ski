# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Amenity.destroy_all
Image.destroy_all
Page.destroy_all
HolidayType.destroy_all
TripAdvisorProperty.destroy_all
Property.destroy_all
PropertyBasePrice.destroy_all
DirectoryAdvert.destroy_all
Region.destroy_all
Resort.destroy_all
Country.destroy_all
Category.destroy_all
User.destroy_all
Role.delete_all
Currency.destroy_all
Payment.delete_all
Enquiry.delete_all
Website.delete_all

website = Website.create!(
  home_content: <<~EOF
  <div id="col-mid" class="wide clear-fix">

      	<div id="welcome-message">
          <h1 class="home">Welcome to Mychaletfinder®</h1>
          <p>One of Europe's leading self catering holiday accommodation
          website offering <strong>ski chalets</strong>, apartments,
          <strong>villas</strong> and holiday homes for rent.</p>
          <br>
          <p>We have a large selection of <strong>holiday
          rentals</strong> in top destinations
          around the world to suit all budgets
          and tastes.</p>
          <br>

          <p>Whether a city centre apartment, a cabin in Lapland, beach villa
          in the Caribbean or ski chalet in the lakes &amp; mountains, MyChaletfinder has the perfect <strong>vacation
          rental</strong> waiting for you.
          </p>
        </div>

      	<div id="featured-properties">
          <h2>Popular Holiday Destinations</h2>

          <div class="clear-fix">

            <a href="/resorts/chamonix/properties/rent" class="size-1of3 layout-element">
              <img src="/countries/home-page/destinations/chamonix-chalets.jpg" alt="chalet rentals" title="Chamonix summer holidays">
              <p class="header-title">Chamonix</p>

              <div class="header-text-cont">
                <p class="header-text">France</p>
              </div>
            </a>

                 <a href="/regions/lake-como" class="lakes-and-mountains-theme size-1of3 layout-element">
              <img src="/countries/home-page/destinations/lake-como-villa-rentals.jpg" alt="lakes and mountains chalet holiday rentals" title="Lake Como villas">
              <p class="header-title">Lake Como</p>

              <div class="header-text-cont">
                <p class="header-text">Italy</p>
              </div>
            </a>
          </div>
          <!-- clearfix 1of 3 row -->
          <div class="clear-fix">
            <a href="/regions/puglia" class="summer-villas-theme size-1of3 layout-element">
              <img src="/countries/home-page/destinations/puglia-holiday-rentals.jpg" alt="puglia holiday rentals" title="Puglia holiday rentals">
              <p class="header-title">Puglia</p>

              <div class="header-text-cont">
                <p class="header-text">Italy</p>
              </div>
            </a>


            <a href="/resorts/madrid" class="city-breaks-theme size-1of3 layout-element">
              <img src="/countries/home-page/destinations/madrid-apartments.jpg" alt="madrid apartments" title="Madrid apartments">
              <p class="header-title">Madrid</p>

              <div class="header-text-cont">
                <p class="header-text">Spain</p>
              </div>
            </a>
          </div>
          <!-- clearfix 1of 3 row -->

               <div class="clear-fix">



            <a href="/regions/lake-tahoe" class="size-1of3 layout-element">
              <img src="/countries/home-page/destinations/lake-tahoe-cabin-rentals.jpg" alt="vacation rentals" title="Lake Tahoe cabins">
              <p class="header-title">Lake Tahoe</p>

              <div class="header-text-cont">
                <p class="header-text">America</p>
              </div>
            </a>

                 <a href="/resorts/zell-am-see-kaprun" class="lakes-and-mountains-theme size-1of3 layout-element">
              <img src="/countries/home-page/destinations/zell-am-see-chalet-rentals.jpg" alt="lakes and mountains holiday rentals" title="Zell am See chalets">
              <p class="header-title">Zell am See</p>

              <div class="header-text-cont">
                <p class="header-text">Austria</p>
              </div>
            </a>
          </div>
          <!-- clearfix 1of 3 row -->



          <div class="clear-fix">
            <a href="/pages/caribbean-holidays" class="summer-villas-theme size-1of3 layout-element">
              <img src="/countries/home-page/destinations/caribbean-vacation-rentals.jpg" alt="caribbean vacation rentals, villas to rent" title="Caribbean holiday rentals">
              <p class="header-title">British Virgin Islands</p>

              <div class="header-text-cont">
                <p class="header-text">Caribbean</p>
              </div>
            </a>


            <a href="/resorts/vancouver" class="city-breaks-theme size-1of3 layout-element">
              <img src="/countries/home-page/destinations/vancouver-vacation-rentals.jpg" alt="vancouver vacation rentals" title="Vancouver vacation rentals">
              <p class="header-title">Vancouver</p>

              <div class="header-text-cont">
                <p class="header-text">Canada</p>
              </div>
            </a>
          </div>
        </div>

      </div>
  EOF
)

CarouselSlide.delete_all
CarouselSlide.create!([
  { caption: '<p>Ski Holidays</p><p>A wide choice of international<br>ski resorts around the world</p>', link: '/holidays/ski-holidays', image_url: 'home/sh-home.png' },
  { caption: '<p>City Breaks</p><p>All year round destinations – <br>explore something new</p>', link: '/holidays/city-breaks', image_url: 'home/ex-slider.png' },
  { caption: '<p>Summer Villas</p><p>A great choice from the blue seas of <br>the Amalfi Coast to the Florida Keys</p>', link: '/holidays/summer-villas', image_url: 'home/sv-home.png' },
  { caption: '<p>Lakes & Mountains<p><p>Beautiful lakeside resorts in picture <br>postcard settings</p>', link: '/holidays/lakes-and-mountains', image_url: 'home/lm-home.png' }
])

Page.create!([
  { path: '/pages/about', title: 'About' }
])

Page.create!(
  path: '/pages/property-for-sale',
  title: 'Property for Sale -  Luxury Ski Chalets, Villas & Apartments for Sale',
  content: <<~EOF
  <div class="clear-fix">
  <img alt="new ski chalets for sale, real estate in the alps" src="/images/property-sale-main/header/tignes-ski-resort-kalinda-1-mychaletfinder.jpg">
  </div>


  <h1>Mychaletfinder International Property Sales<span>Chalets, Apartments, Beach Villas, Sale &amp; Leaseback</span></h1>

  <div class="clear-fix">
    <div class="size-2of3 layout-element">

  <p>Mychaletfinder showcases some of the finest alpine real estate in the Alps from the
  regions leading property developers. The ski <strong>chalets and apartments for sale</strong> are located
  in both the well known international resorts as well as in those off the beaten track but
  linked in to some of the world's largest ski carousels. </p>

  <p>Our portfolio of exquisite villas and beach property for sale includes some
    of the most sought after real estate locations around such as on the spectacular Cote d'Azur.
  </p>

  <p>If you are looking to invest in a holiday home, generate rental income or even move to the Alps,
  we have a wide selection for you to choose from. For more information on any of the
  <strong>properties for sale</strong>, simply send an email enquiry via the email form after clicking on a property.
  One of our partner sales consultants will contact you straight away and
  be happy to answer your questions, arrange a viewing of the property and offer useful
  advice and guidance as to the buying process.</p>

  <p>Together with our partners, we have compiled additional valuable information and
  services on our website to help you with your
  property purchase abroad including...</p>

  <ul>
    <li>Buying guides</li>
    <li>Foreign exchange for buying or selling your overseas property, and</li>
    <li>Raising finance to buy your holiday home, for example, specialist mortgage brokers</li>
  </ul>

  </div>

    <div class="size-1of3 layout-element">


  </div>
  </div>


  <h2>Hot Property - Ski Chalets</h2>
  <p>Some of the hottest new chalet and residence apartment developments on the market
  at the moment are in the ever popular Grand Massif ski resorts, Chamonix Valley and Three Valleys
  in the French Alps.
  </p>

  <div class="clear-fix">

   <a class="ski-holidays-theme size-1of3 layout-element" href="/properties/1585744-chalet-delys-les-houches-france">
      <img alt="chalets for sale in les houches" src="/images/chalets-for-sale/thumbnails/chalet-delys-thumbnail.JPG">
      <p class="header-title">Les Houches - Chalet Delys</p>
      <div class="header-text-cont">
        <p class="header-text">From €430,000</p>
      </div>
    </a>


          <a class="ski-holidays-theme size-1of3 layout-element" href="/properties/1586385-chalet-suzanne-chatel-france">
      <img alt="chalets for sale in chatel" src="/images/chalets-for-sale/thumbnails/chatel-ferme-suzanne-thumbnail.jpg">
      <p class="header-title">Châtel - La Ferme de Suzanne</p>
      <div class="header-text-cont">
        <p class="header-text">From €355,000</p>
      </div>
    </a>


   <a class="ski-holidays-theme size-1of3 layout-element" href="/properties/1586475-chalet-saskya-samoens-france">
      <img alt="samoens ski chalets and apartments for sale, grand massif" src="/images/chalets-for-sale/thumbnails/samoens-chalet-saskya-thumbnail.jpg">
      <p class="header-title">Samoëns - Chalet Saskya</p>
      <div class="header-text-cont">
        <p class="header-text">€270,000</p>
      </div>
    </a>

  </div>
  <br>




  <div class="clear-fix">

   <a class="ski-holidays-theme size-1of3 layout-element" href="/properties/82053-le-cristal-de-jade-chamonix-france">
      <img alt="chamonix new property developments" src="/images/chalets-for-sale/chamonix-chalets-for-sale-jade454.jpg">
      <p class="header-title">Chamonix</p>
      <div class="header-text-cont">
        <p class="header-text">From €391,667</p>
      </div>
    </a>


          <a class="ski-holidays-theme size-1of3 layout-element" href="/properties/1479052-alpen-lodge-la-rosiere-france">
      <img alt="chalets for sale in la rosiere" src="/images/chalets-for-sale/thumbnails/alpen-lodge-thumbnail.jpg">
      <p class="header-title">La Rosière - Alpen Lodge</p>
      <div class="header-text-cont">
        <p class="header-text">From €233,334</p>
      </div>
    </a>


   <a class="ski-holidays-theme size-1of3 layout-element" href="/properties/82052-les-chalets-de-layssia-samoens-france">
      <img alt="samoens ski chalets and apartments for sale, grand massif" src="/images/chalets-for-sale/thumbnails/samoens-chalet-de-laesia.jpg">
      <p class="header-title">Samoens - Les Chalets de Layssia</p>
      <div class="header-text-cont">
        <p class="header-text">From €208,333</p>
      </div>
    </a>

  </div>
  <br>

  <div class="clear-fix">
      <a class="ski-holidays-theme size-1of3 layout-element" href="/properties/82577-whistler-lodge-courchevel-france">
      <img alt="property for sale in the three valleys, courchevel 1650" src="/images/athenaadvisors/courchevel-1650/whistler-lodge/courchevel-1650-chalet-development-for-sale.JPG">
      <p class="header-title">Courchevel 1650 - Whistler Lodge</p>
      <div class="header-text-cont">
        <p class="header-text">From €685,000</p>
      </div>
    </a>


      <a class="ski-holidays-theme size-1of3 layout-element" href="/properties/82226-le-coeur-des-loges-les-menuires-france">
      <img alt="leaseback and sale new chalet property for sale in les menuires" src="/images/athenaadvisors/les-menuires/le-coeur-loges/les-menuires-new-chalet-coeur-loges.JPG">
      <p class="header-title">Les Menuires - Le Coeur des Loges </p>
      <div class="header-text-cont">
        <p class="header-text">From €173,800</p>
      </div>
    </a>

    <a class="ski-holidays-theme size-1of3 layout-element" href="/properties/1478955-anitea-valmorel-france">
      <img alt="les-carroz chalets and apartments for sale" src="/images/chalets-for-sale/valmorel/anitea/valmorel-property-sale.jpg">
      <p class="header-title">Valmorel - Chalet Anitea</p>
      <div class="header-text-cont">
        <p class="header-text">From €233,334</p>
      </div>
    </a>


  </div>
  <br>
  <div class="clear-fix">
      <a class="ski-holidays-theme size-1of3 layout-element" href="/properties/1081467-les-chalets-elena-les-houches-france">
      <img alt="chalets for sale in Les Houches" title="Chalets for sale in Les Houches" src="/images/chalets-for-sale/thumbnails/les-houches-chalet-elena-for-sale.png">
      <p class="header-title">Les Houches, Chalet Éléna</p>
      <div class="header-text-cont">
        <p class="header-text">From €225,000</p>
      </div>
    </a>

       <a class="ski-holidays-theme size-1of3 layout-element" href="/properties/1105923-les-balcons-etoiles-champagny-france">
      <img alt="apartments for sale in Champagny - la plagne" title="Champagny - La Plagne apartments for sale" src="/images/chalets-for-sale/champagny/champagny_balcons-etoiles-sales.jpg">
      <p class="header-title">Champagny en Vanoise</p>
      <div class="header-text-cont">
        <p class="header-text">From €215,000</p>
      </div>
    </a>

         <a class="ski-holidays-theme size-1of3 layout-element" href="/properties/1478013-le-lodge-des-neiges-tignes-france">
      <img alt="Tignes 1800 property for sale" title="Tignes apartments for sale" src="/images/chalets-for-sale/thumbnails/tignes1800-lodge-des-neiges-apartments.jpg">
      <p class="header-title">Tignes 1800</p>
      <div class="header-text-cont">
        <p class="header-text">From €250,000</p>
      </div>
    </a>

    </div>

  <h2>Hot Property - Villas</h2>
  <p>Some of the hottest villas, condo residences and apartments on the market are in the ever popular Cote d'Azur in
  the south of France and Florida in the United States.
  </p>
  <div class="clear-fix">

     <a class="summer-villas-theme size-1of3 layout-element" href="/properties/82692-parc-eugenie-cannes-france">
      <img alt="french riviera new apartments for sale" title="Cannes real estate" src="/images/athenaadvisors/cannes/parc-eugiene/cover/parc-eugenie-cannes-property.jpg">
    <p class="header-title">Cannes - Oxford Quarter</p>
      <div class="header-text-cont">
      <p class="header-text">From €204,000</p>
      </div>
    </a>


    <a class="summer-villas-theme size-1of3 layout-element" href="/properties/82766-cannes-pointe-croisette-sunline-cannes-france">
      <img alt="cannes, pointe croisette, new apartments for sale" title="Cannes property sales" src="/images/athenaadvisors/cannes/pointe-croisette/cannes_pointe_croisette-apartment-sale.jpg">
    <p class="header-title">Cannes - Pointe Croisette</p>
      <div class="header-text-cont">
      <p class="header-text">From €220,000</p>
      </div>
    </a>

    <a class="summer-villas-theme size-1of3 layout-element" href="/properties/82666-riviera-rahpsody-menton-france">
      <img alt="french riviera new apartments for sale" src="/images/france-villas-for-sale/cote-d-azur-property.jpg">
    <p class="header-title">Roquebrune - Cap Martin</p>
      <div class="header-text-cont">
      <p class="header-text">From €216,000</p>
      </div>
    </a>

  </div>
  <br>



  <h2>Hot Property - Lakes &amp; Mountains</h2>
  <p>Some of the hottest new apartments in the lakes and mountains of the Alps.
  </p>
  <div class="clear-fix">

           <a class="lakes-and-mountains-theme size-1of3 layout-element" href="/properties/224816-villa-elisee-annecy-le-vieux-france">
      <img alt="lake annecy apartments for sale" title="Annecy apartments for sale" src="/images/villas-for-sale/annecy-le-vieux/villa-elisee/annecy-le-vieux-villa-elisee-thumbnail.jpg">
      <p class="header-title">Annecy Le Vieux - Villa Élisée</p>
      <div class="header-text-cont">
        <p class="header-text">From €585,000</p>
      </div>
    </a>


            <a class="lakes-and-mountains-theme size-1of3 layout-element" href="/properties/1586669-jardin-cardinal-annecy-france">
      <img alt="lake annecy apartments for sale" title="Annecy apartments for sale" src="/images/villas-for-sale/annecy/jardin-cardinal/jardin-cardinal-thumbnail.jpg">
      <p class="header-title">Annecy - Jardin Cardinal</p>
      <div class="header-text-cont">
        <p class="header-text">From €205,000</p>
      </div>
    </a>

              <a class="lakes-and-mountains-theme size-1of3 layout-element" href="/properties/1586756-villa-sienna-annecy-france">
      <img alt="lake annecy apartments for sale" title="Annecy apartments for sale" src="/images/villas-for-sale/annecy/villa-sienna/annecy-villa-sienna.-thumbnail.jpg">
      <p class="header-title">Annecy - Villa Sienna</p>
      <div class="header-text-cont">
        <p class="header-text">From €500,000</p>
      </div>
    </a>

  </div>
  EOF
)

ski_holidays = HolidayType.create!(
  name: 'Ski Holidays', slug: 'ski-holidays',
  mega_menu_html: '<ul><li><a href="/airport_transfers/find">Airport Transfers</a></li></ul>'
)
lakes_and_mountains = HolidayType.create!(name: 'Lakes & Mountains', slug: 'lakes-and-mountains')
summer_villas = HolidayType.create!(name: 'Summer Villas', slug: 'summer-villas')
city_breaks = HolidayType.create!(name: 'City Breaks', slug: 'city-breaks')

euros = Currency.create!(
  name: 'Euro',
  unit: '€',
  pre: true,
  code: 'EUR',
  in_euros: 1
)

countries = [
  { name: 'Andorra',               iso_3166_1_alpha_2: 'AD' },
  { name: 'Afghanistan',           iso_3166_1_alpha_2: 'AF' },
  { name: 'Albania',               iso_3166_1_alpha_2: 'AL' },
  { name: 'Algeria',               iso_3166_1_alpha_2: 'DZ' },
  { name: 'Angola',                iso_3166_1_alpha_2: 'AO' },
  { name: 'Anguilla',              iso_3166_1_alpha_2: 'AI' },
  { name: 'Antarctica',            iso_3166_1_alpha_2: 'AQ' },
  { name: 'Antigua and Barbuda',   iso_3166_1_alpha_2: 'AG' },
  { name: 'Argentina',             iso_3166_1_alpha_2: 'AR' },
  { name: 'American Samoa',        iso_3166_1_alpha_2: 'AS' },
  { name: 'Åland Islands',         iso_3166_1_alpha_2: 'AX' },
  { name: 'Armenia',               iso_3166_1_alpha_2: 'AM' },
  { name: 'Aruba',                 iso_3166_1_alpha_2: 'AW' },
  { name: 'Australia',             iso_3166_1_alpha_2: 'AU' },
  { name: 'Austria',               iso_3166_1_alpha_2: 'AT' },
  { name: 'Azerbaijan',            iso_3166_1_alpha_2: 'AZ' },
  { name: 'Bahamas',               iso_3166_1_alpha_2: 'BS' },
  { name: 'Bahrain',               iso_3166_1_alpha_2: 'BH' },
  { name: 'Bangladesh',            iso_3166_1_alpha_2: 'BD' },
  { name: 'Barbados',              iso_3166_1_alpha_2: 'BB' },
  { name: 'Belarus',               iso_3166_1_alpha_2: 'BY' },
  { name: 'Belgium',               iso_3166_1_alpha_2: 'BE' },
  { name: 'Belize',                iso_3166_1_alpha_2: 'BZ' },
  { name: 'Benin',                 iso_3166_1_alpha_2: 'BJ' },
  { name: 'Bermuda',               iso_3166_1_alpha_2: 'BM' },
  { name: 'Bhutan',                iso_3166_1_alpha_2: 'BT' },
  { name: 'Bolivia',               iso_3166_1_alpha_2: 'BO' },
  { name: 'Bosnia and Herzegovina', iso_3166_1_alpha_2: 'BA' },
  { name: 'Botswana',              iso_3166_1_alpha_2: 'BW' },
  { name: 'Bouvet Island',         iso_3166_1_alpha_2: 'BV' },
  { name: 'Brazil',                iso_3166_1_alpha_2: 'BR' },
  { name: 'British Indian Ocean Territory', iso_3166_1_alpha_2: 'IO' },
  { name: 'Brunei',                iso_3166_1_alpha_2: 'BN' },
  { name: 'Bulgaria',              iso_3166_1_alpha_2: 'BG' },
  { name: 'Burkina Faso',          iso_3166_1_alpha_2: 'BF' },
  { name: 'Burundi',               iso_3166_1_alpha_2: 'BI' },
  { name: 'Cameroon',              iso_3166_1_alpha_2: 'CM' },
  { name: 'Canada',                iso_3166_1_alpha_2: 'CA' },
  { name: 'Cambodia',              iso_3166_1_alpha_2: 'KH' },
  { name: 'Cape Verde',            iso_3166_1_alpha_2: 'CV' },
  { name: 'Cayman Islands',        iso_3166_1_alpha_2: 'KY' },
  { name: 'Central African Republic', iso_3166_1_alpha_2: 'CF' },
  { name: 'Chad',                  iso_3166_1_alpha_2: 'TD' },
  { name: 'Chile',                 iso_3166_1_alpha_2: 'CL' },
  { name: 'China',                 iso_3166_1_alpha_2: 'CN' },
  { name: 'Christmas Island',      iso_3166_1_alpha_2: 'CX' },
  { name: 'Cocos (Keeling) Islands', iso_3166_1_alpha_2: 'CC' },
  { name: 'Colombia',              iso_3166_1_alpha_2: 'CO' },
  { name: 'Congo',                 iso_3166_1_alpha_2: 'CG' },
  { name: 'Congo, the Democratic Republic of', iso_3166_1_alpha_2: 'CD' },
  { name: 'Comoros',               iso_3166_1_alpha_2: 'KM' },
  { name: 'Cook Islands',          iso_3166_1_alpha_2: 'CK' },
  { name: 'Costa Rica',            iso_3166_1_alpha_2: 'CR' },
  { name: 'Côte d\'Ivoire',        iso_3166_1_alpha_2: 'CI' },
  { name: 'Croatia',               iso_3166_1_alpha_2: 'HR' },
  { name: 'Cuba',                  iso_3166_1_alpha_2: 'CU' },
  { name: 'Cyprus',                iso_3166_1_alpha_2: 'CY' },
  { name: 'Czech Republic',        iso_3166_1_alpha_2: 'CZ' },
  { name: 'Denmark',               iso_3166_1_alpha_2: 'DK' },
  { name: 'Djibouti',              iso_3166_1_alpha_2: 'DJ' },
  { name: 'Dominica',              iso_3166_1_alpha_2: 'DM' },
  { name: 'Dominican Republic',    iso_3166_1_alpha_2: 'DO' },
  { name: 'Ecuador',               iso_3166_1_alpha_2: 'EC' },
  { name: 'Egypt',                 iso_3166_1_alpha_2: 'EG' },
  { name: 'El Salvador',           iso_3166_1_alpha_2: 'SV' },
  { name: 'Equatorial Guinea',     iso_3166_1_alpha_2: 'GQ' },
  { name: 'Estonia',               iso_3166_1_alpha_2: 'EE' },
  { name: 'Eritrea',               iso_3166_1_alpha_2: 'ER' },
  { name: 'Ethiopia',              iso_3166_1_alpha_2: 'ET' },
  { name: 'Falkland Islands (Malvinas)', iso_3166_1_alpha_2: 'FK' },
  { name: 'Faroe Islands',         iso_3166_1_alpha_2: 'FO' },
  { name: 'Fiji',                  iso_3166_1_alpha_2: 'FJ' },
  { name: 'Finland',               iso_3166_1_alpha_2: 'FI' },
  { name: 'France',                iso_3166_1_alpha_2: 'FR' },
  { name: 'French Guiana',         iso_3166_1_alpha_2: 'GF' },
  { name: 'French Polynesia',      iso_3166_1_alpha_2: 'PF' },
  { name: 'French Southern Territories', iso_3166_1_alpha_2: 'TF' },
  { name: 'Gabon',                 iso_3166_1_alpha_2: 'GA' },
  { name: 'Gambia',                iso_3166_1_alpha_2: 'GM' },
  { name: 'Georgia',               iso_3166_1_alpha_2: 'GE' },
  { name: 'Germany',               iso_3166_1_alpha_2: 'DE' },
  { name: 'Ghana',                 iso_3166_1_alpha_2: 'GH' },
  { name: 'Gibraltar',             iso_3166_1_alpha_2: 'GI' },
  { name: 'Greece',                iso_3166_1_alpha_2: 'GR' },
  { name: 'Greenland',             iso_3166_1_alpha_2: 'GL' },
  { name: 'Grenada',               iso_3166_1_alpha_2: 'GD' },
  { name: 'Guadeloupe',            iso_3166_1_alpha_2: 'GP' },
  { name: 'Guam',                  iso_3166_1_alpha_2: 'GU' },
  { name: 'Guatemala',             iso_3166_1_alpha_2: 'GT' },
  { name: 'Guernsey',              iso_3166_1_alpha_2: 'GG' },
  { name: 'Guinea',                iso_3166_1_alpha_2: 'GN' },
  { name: 'Guinea-Bissau',         iso_3166_1_alpha_2: 'GW' },
  { name: 'Guyana',                iso_3166_1_alpha_2: 'GY' },
  { name: 'Haiti',                 iso_3166_1_alpha_2: 'HT' },
  { name: 'Heard Island and McDonald Islands', iso_3166_1_alpha_2: 'HM' },
  { name: 'Holy See (Vatican City State)', iso_3166_1_alpha_2: 'VA' },
  { name: 'Honduras',              iso_3166_1_alpha_2: 'HN' },
  { name: 'Hong Kong',             iso_3166_1_alpha_2: 'HK' },
  { name: 'Hungary',               iso_3166_1_alpha_2: 'HU' },
  { name: 'Iceland',               iso_3166_1_alpha_2: 'IS' },
  { name: 'India',                 iso_3166_1_alpha_2: 'IN' },
  { name: 'Indonesia',             iso_3166_1_alpha_2: 'ID' },
  { name: 'Iran',                  iso_3166_1_alpha_2: 'IR' },
  { name: 'Iraq',                  iso_3166_1_alpha_2: 'IQ' },
  { name: 'Ireland',               iso_3166_1_alpha_2: 'IE' },
  { name: 'Isle of Man',           iso_3166_1_alpha_2: 'IM' },
  { name: 'Israel',                iso_3166_1_alpha_2: 'IL' },
  { name: 'Italy',                 iso_3166_1_alpha_2: 'IT' },
  { name: 'Jamaica',               iso_3166_1_alpha_2: 'JM' },
  { name: 'Japan',                 iso_3166_1_alpha_2: 'JP' },
  { name: 'Jersey',                iso_3166_1_alpha_2: 'JE' },
  { name: 'Jordan',                iso_3166_1_alpha_2: 'JO' },
  { name: 'Kazakhstan',            iso_3166_1_alpha_2: 'KZ' },
  { name: 'Kenya',                 iso_3166_1_alpha_2: 'KE' },
  { name: 'Kiribati',              iso_3166_1_alpha_2: 'KI' },
  { name: 'Kuwait',                iso_3166_1_alpha_2: 'KW' },
  { name: 'Kyrgyzstan',            iso_3166_1_alpha_2: 'KG' },
  { name: 'Lao People\'s Democratic Republic', iso_3166_1_alpha_2: 'LA' },
  { name: 'Latvia',                iso_3166_1_alpha_2: 'LV' },
  { name: 'Lebanon',               iso_3166_1_alpha_2: 'LB' },
  { name: 'Lesotho',               iso_3166_1_alpha_2: 'LS' },
  { name: 'Liberia',               iso_3166_1_alpha_2: 'LR' },
  { name: 'Liechtenstein',         iso_3166_1_alpha_2: 'LI' },
  { name: 'Lithuania',             iso_3166_1_alpha_2: 'LT' },
  { name: 'Luxembourg',            iso_3166_1_alpha_2: 'LU' },
  { name: 'Libya',                 iso_3166_1_alpha_2: 'LY' },
  { name: 'Macao',                 iso_3166_1_alpha_2: 'MO' },
  { name: 'Macedonia, the former Yugoslav Republic of', iso_3166_1_alpha_2: 'MK' },
  { name: 'Madagascar',            iso_3166_1_alpha_2: 'MG' },
  { name: 'Malawi',                iso_3166_1_alpha_2: 'MW' },
  { name: 'Malaysia',              iso_3166_1_alpha_2: 'MY' },
  { name: 'Maldives',              iso_3166_1_alpha_2: 'MV' },
  { name: 'Mali',                  iso_3166_1_alpha_2: 'ML' },
  { name: 'Malta',                 iso_3166_1_alpha_2: 'MT' },
  { name: 'Marshall Islands',      iso_3166_1_alpha_2: 'MH' },
  { name: 'Martinique',            iso_3166_1_alpha_2: 'MQ' },
  { name: 'Mauritania',            iso_3166_1_alpha_2: 'MR' },
  { name: 'Mauritius',             iso_3166_1_alpha_2: 'MU' },
  { name: 'Mayotte',               iso_3166_1_alpha_2: 'YT' },
  { name: 'Mexico',                iso_3166_1_alpha_2: 'MX' },
  { name: 'Micronesia, Federated States of', iso_3166_1_alpha_2: 'FM' },
  { name: 'Moldova',               iso_3166_1_alpha_2: 'MD' },
  { name: 'Monaco',                iso_3166_1_alpha_2: 'MC' },
  { name: 'Mongolia',              iso_3166_1_alpha_2: 'MN' },
  { name: 'Montenegro',            iso_3166_1_alpha_2: 'ME' },
  { name: 'Montserrat',            iso_3166_1_alpha_2: 'MS' },
  { name: 'Morocco',               iso_3166_1_alpha_2: 'MA' },
  { name: 'Mozambique',            iso_3166_1_alpha_2: 'MZ' },
  { name: 'Myanmar',               iso_3166_1_alpha_2: 'MM' },
  { name: 'Namibia',               iso_3166_1_alpha_2: 'NA' },
  { name: 'Nauru',                 iso_3166_1_alpha_2: 'NR' },
  { name: 'Nepal',                 iso_3166_1_alpha_2: 'NP' },
  { name: 'Netherlands',           iso_3166_1_alpha_2: 'NL' },
  { name: 'New Caledonia',         iso_3166_1_alpha_2: 'NC' },
  { name: 'New Zealand',           iso_3166_1_alpha_2: 'NZ' },
  { name: 'Nicaragua',             iso_3166_1_alpha_2: 'NI' },
  { name: 'Niger',                 iso_3166_1_alpha_2: 'NE' },
  { name: 'Nigeria',               iso_3166_1_alpha_2: 'NG' },
  { name: 'Niue',                  iso_3166_1_alpha_2: 'NU' },
  { name: 'Norfolk Island',        iso_3166_1_alpha_2: 'NF' },
  { name: 'North Korea',           iso_3166_1_alpha_2: 'KP' },
  { name: 'Northern Mariana Islands', iso_3166_1_alpha_2: 'MP' },
  { name: 'Norway',                iso_3166_1_alpha_2: 'NO' },
  { name: 'Oman',                  iso_3166_1_alpha_2: 'OM' },
  { name: 'Pakistan',              iso_3166_1_alpha_2: 'PK' },
  { name: 'Palau',                 iso_3166_1_alpha_2: 'PW' },
  { name: 'Palestinian Territory, Occupied', iso_3166_1_alpha_2: 'PS' },
  { name: 'Panama',                iso_3166_1_alpha_2: 'PA' },
  { name: 'Papua New Guinea',      iso_3166_1_alpha_2: 'PG' },
  { name: 'Paraguay',              iso_3166_1_alpha_2: 'PY' },
  { name: 'Peru',                  iso_3166_1_alpha_2: 'PE' },
  { name: 'Philippines',           iso_3166_1_alpha_2: 'PH' },
  { name: 'Pitcairn',              iso_3166_1_alpha_2: 'PN' },
  { name: 'Poland',                iso_3166_1_alpha_2: 'PL' },
  { name: 'Portugal',              iso_3166_1_alpha_2: 'PT' },
  { name: 'Puerto Rico',           iso_3166_1_alpha_2: 'PR' },
  { name: 'Qatar',                 iso_3166_1_alpha_2: 'QA' },
  { name: 'Réunion',               iso_3166_1_alpha_2: 'RE' },
  { name: 'Romania',               iso_3166_1_alpha_2: 'RO' },
  { name: 'Russia',                iso_3166_1_alpha_2: 'RU' },
  { name: 'Rwanda',                iso_3166_1_alpha_2: 'RW' },
  { name: 'Saint Barthélemy',      iso_3166_1_alpha_2: 'BL' },
  { name: 'Saint Helena, Ascension and Tristan da Cunha', iso_3166_1_alpha_2: 'SH' },
  { name: 'Saint Kitts and Nevis', iso_3166_1_alpha_2: 'KN' },
  { name: 'Saint Lucia',           iso_3166_1_alpha_2: 'LC' },
  { name: 'Saint Martin (French part)', iso_3166_1_alpha_2: 'MF' },
  { name: 'Saint Pierre and Miquelon', iso_3166_1_alpha_2: 'PM' },
  { name: 'Saint Vincent and the Grenadines', iso_3166_1_alpha_2: 'VC' },
  { name: 'Samoa',                 iso_3166_1_alpha_2: 'WS' },
  { name: 'San Marino',            iso_3166_1_alpha_2: 'SM' },
  { name: 'Sao Tome and Principe', iso_3166_1_alpha_2: 'ST' },
  { name: 'Saudi Arabia',          iso_3166_1_alpha_2: 'SA' },
  { name: 'Senegal',               iso_3166_1_alpha_2: 'SN' },
  { name: 'Serbia',                iso_3166_1_alpha_2: 'RS' },
  { name: 'Seychelles',            iso_3166_1_alpha_2: 'SC' },
  { name: 'Sierra Leone',          iso_3166_1_alpha_2: 'SL' },
  { name: 'Singapore',             iso_3166_1_alpha_2: 'SG' },
  { name: 'Slovakia',              iso_3166_1_alpha_2: 'SK' },
  { name: 'Slovenia',              iso_3166_1_alpha_2: 'SI' },
  { name: 'Solomon Islands',       iso_3166_1_alpha_2: 'SB' },
  { name: 'Somalia',               iso_3166_1_alpha_2: 'SO' },
  { name: 'South Africa',          iso_3166_1_alpha_2: 'ZA' },
  { name: 'South Georgia and the South Sandwich Islands', iso_3166_1_alpha_2: 'GS' },
  { name: 'South Korea',           iso_3166_1_alpha_2: 'KR' },
  { name: 'Spain',                 iso_3166_1_alpha_2: 'ES' },
  { name: 'Sri Lanka',             iso_3166_1_alpha_2: 'LK' },
  { name: 'Sudan',                 iso_3166_1_alpha_2: 'SD' },
  { name: 'Suriname',              iso_3166_1_alpha_2: 'SR' },
  { name: 'Svalbard and Jan Mayen', iso_3166_1_alpha_2: 'SJ' },
  { name: 'Swaziland',             iso_3166_1_alpha_2: 'SZ' },
  { name: 'Sweden',                iso_3166_1_alpha_2: 'SE' },
  { name: 'Switzerland',           iso_3166_1_alpha_2: 'CH' },
  { name: 'Syria',                 iso_3166_1_alpha_2: 'SY' },
  { name: 'Taiwan, Province of China', iso_3166_1_alpha_2: 'TW' },
  { name: 'Tajikistan',            iso_3166_1_alpha_2: 'TJ' },
  { name: 'Tanzania',              iso_3166_1_alpha_2: 'TZ' },
  { name: 'Thailand',              iso_3166_1_alpha_2: 'TH' },
  { name: 'Timor-Lest',            iso_3166_1_alpha_2: 'TL' },
  { name: 'Togo',                  iso_3166_1_alpha_2: 'TG' },
  { name: 'Tokelau',               iso_3166_1_alpha_2: 'TK' },
  { name: 'Tonga',                 iso_3166_1_alpha_2: 'TO' },
  { name: 'Trinidad and Tobago',   iso_3166_1_alpha_2: 'TT' },
  { name: 'Tunisia',               iso_3166_1_alpha_2: 'TN' },
  { name: 'Turkey',                iso_3166_1_alpha_2: 'TR' },
  { name: 'Turkmenistan',          iso_3166_1_alpha_2: 'TM' },
  { name: 'Turks and Caicos Islands', iso_3166_1_alpha_2: 'TC' },
  { name: 'Tuvalu',                iso_3166_1_alpha_2: 'TV' },
  { name: 'Uganda',                iso_3166_1_alpha_2: 'UG' },
  { name: 'Ukraine',               iso_3166_1_alpha_2: 'UA' },
  { name: 'United Arab Emirates',  iso_3166_1_alpha_2: 'AE' },
  { name: 'United Kingdom',        iso_3166_1_alpha_2: 'GB' },
  { name: 'United States',         iso_3166_1_alpha_2: 'US' },
  { name: 'United States Minor Outlying Islands', iso_3166_1_alpha_2: 'UM' },
  { name: 'Uruguay',               iso_3166_1_alpha_2: 'UY' },
  { name: 'Uzbekistan',            iso_3166_1_alpha_2: 'UZ' },
  { name: 'Vanuatu',               iso_3166_1_alpha_2: 'VU' },
  { name: 'Venezuela',             iso_3166_1_alpha_2: 'VE' },
  { name: 'Vietnam',               iso_3166_1_alpha_2: 'VN' },
  { name: 'Virgin Islands, British', iso_3166_1_alpha_2: 'VG' },
  { name: 'Virgin Islands, U.S.',  iso_3166_1_alpha_2: 'VI' },
  { name: 'Wallis and Futuna',     iso_3166_1_alpha_2: 'WF' },
  { name: 'Western Sahara',        iso_3166_1_alpha_2: 'EH' },
  { name: 'Yemen',                 iso_3166_1_alpha_2: 'YE' },
  { name: 'Zambia',                iso_3166_1_alpha_2: 'ZM' },
  { name: 'Zimbabwe',              iso_3166_1_alpha_2: 'ZW' }
]

countries.each do |c|
  Country.create!(name: c[:name], iso_3166_1_alpha_2: c[:iso_3166_1_alpha_2], slug: c[:name].parameterize)
end

austria = Country.find_by(name: 'Austria')
france = Country.find_by(name: 'France')
italy = Country.find_by(name: 'Italy')
united_kingdom = Country.find_by(name: 'United Kingdom')

france.holiday_type_brochures.build(holiday_type: ski_holidays)
france.save!

admin = Role.create!(
  name: 'Administrator',
  admin: true,
  select_on_signup: false,
  flag_new_development: true,
  has_a_website: true
)

property_owner = Role.create!(
  name: 'Property owner',
  admin: false,
  select_on_signup: true,
  advertises_generally: false,
  advertises_properties_for_rent: true,
  advertises_properties_for_sale: true,
  flag_new_development: false,
  has_a_website: false
)

estate_agent = Role.create!(
  name: 'Estate agent',
  admin: false,
  select_on_signup: true,
  advertises_properties_for_rent: true,
  advertises_properties_for_sale: true,
  flag_new_development: true,
  has_a_website: true
)

letting_agent = Role.create!(
  name: 'Letting agent',
  admin: false,
  select_on_signup: true,
  flag_new_development: false,
  has_a_website: true
)

property_developer = Role.create!(
  name: 'Property developer',
  admin: false,
  select_on_signup: true,
  advertises_properties_for_rent: false,
  advertises_properties_for_sale: true,
  advertises_through_windows: true,
  flag_new_development: true,
  new_development_by_default: true,
  has_a_website: true
)

other_business = Role.create!(
  name: 'Other business',
  admin: false,
  select_on_signup: true,
  advertises_generally: true,
  advertises_properties_for_rent: false,
  advertises_properties_for_sale: false,
  flag_new_development: false,
  has_a_website: true
)

advertiser = Role.create!(
  name: 'Advertiser',
  admin: false,
  select_on_signup: false,
  sales_pitch: <<~HEREDOC
  <div class="column">
    <div class="advertiser_type" id="property_owners">
      <h3>Property Owners</h3>
      <p>If you own a chalet or apartment
      and are looking to rent it out or
      even sell it</p>
      <a class="learn_more" href="/welcome/property-owner">Learn More</a>
    </div>

    <div class="advertiser_type" id="estate_agents">
      <h3>Estate Agents</h3>
      <p>Access key features designed specifically
      for estate agents</p>
      <a class="learn_more" href="/welcome/estate-agent">Learn More</a>
    </div>

    <div class="advertiser_type" id="property_developers">
      <h3>Property Developers</h3>
      <p>MyChaletFinder.com can help you
      market your new developments to a
      wider audience</p>
      <a class="learn_more" href="/welcome/property-developer">Learn More</a>
    </div>
  </div><!--.column-->

  <div class="column">
    <div class="advertiser_type" id="letting_agents">
      <h3>Letting Agents</h3>
      <p>MyChaletFinder.com complements your existing
      letting marketing strategy</p>
      <a class="learn_more" href="/welcome/letting-agent">Learn More</a>
    </div>

    <div class="advertiser_type" id="other_businesses">
      <h3>Banner &amp; Directory Ads</h3>
      <p>Cafés, bars and restaurants are among other
      businesses that will benefit from our site</p>
      <a class="learn_more" href="/welcome/other-business">Learn More</a>
    </div>
  </div><!--.column-->
  HEREDOC
)

alice = User.create!(
  first_name: 'Alice',
  last_name: 'Adams',
  email: 'alice@mychaletfinder.com',
  password: 'secret',
  billing_street: '1, High St',
  billing_city: 'Portsmouth',
  billing_country: united_kingdom,
  terms_and_conditions: true,
  description: '',
  role: admin,
  phone: '+441234567890'
)
bob = User.create!(
  first_name: 'Bob',
  last_name: 'Brown',
  email: 'bob@mychaletfinder.com',
  password: 'secret',
  billing_street: '2, Main Rd',
  billing_city: 'Newcastle',
  billing_country: united_kingdom,
  terms_and_conditions: true,
  description: '',
  role: property_developer,
  phone: '+441234567890'
)
interhome = User.create!(
  first_name: 'Interhome',
  last_name: 'Interhome',
  email: 'interhome@mychaletfinder.com',
  password: 'secret',
  billing_street: '1, High St',
  billing_city: 'Portsmouth',
  billing_country: united_kingdom,
  terms_and_conditions: true,
  description: '',
  role: estate_agent,
  phone: '+441234567890'
)
trip_advisor = User.create!(
  first_name: 'TripAdvisor',
  last_name: 'TripAdvisor',
  email: 'tripadvisor@mychaletfinder.com',
  password: 'secret',
  billing_street: '1, High St',
  billing_city: 'Portsmouth',
  billing_country: united_kingdom,
  terms_and_conditions: true,
  description: '',
  role: estate_agent,
  phone: '+441234567890'
)

Resort.create!([
  { country: austria, name: 'Alpbach',      slug: 'alphach' },
  { country: austria, name: 'Bad Gastein',  slug: 'bad-gastein' },
  { country: austria, name: 'St Anton',     slug: 'st-anton' },
  { country: austria, name: 'Tyrol',        slug: 'tyrol' },
  { country: austria, name: 'Westendorf',   slug: 'westendorf' },
  { country: france,  name: 'Avoriaz',      slug: 'avoriaz' },
  { country: france,  name: 'Bernex',       slug: 'bernex' },
  { country: france,  name: 'La Tania',     slug: 'la-tania' },
  { country: france,  name: 'Les Houches',  slug: 'les-houches', visible: true },
  { country: france,  name: 'Morzine',      slug: 'morzine' },
  { country: italy,   name: 'Cervinia',     slug: 'cervinia' },
  { country: italy,   name: 'Dolomites',    slug: 'dolomites' },
  { country: italy,   name: 'Italian Alps', slug: 'italian-alps' },
])

rhone_alpes = Region.create!(
  country: france, name: 'Rhône Alpes', slug: 'rhone-alpes'
)

rhone_alpes.holiday_type_brochures.build(holiday_type: ski_holidays)
rhone_alpes.save!

htgt = rhone_alpes.create_page('how-to-get-there')
htgt.content = '<p>How to get to Rhône Alpes...</p>'
htgt.save

chamonix = Resort.create!(country: france, name: 'Chamonix',
  slug: 'chamonix',
  piste_map_content: '{{ piste_table }}',
  altitude_m: 1035,
  top_lift_m: 3842,
  piste_length_km: 550,
  visible: true,
  info: 'Chamonix, with a population of approximately 10,000, is a world famous resort and was the location of the first winter Olympics in 1924.',
  for_rent_count: 25,
  for_sale_count: 5,
  region: rhone_alpes
)

chamonix.holiday_type_brochures.build(holiday_type: ski_holidays)
chamonix.save!

chamonix.create_page('how-to-get-there')

les_houches = Resort.find_by(slug: 'les-houches')
les_houches.holiday_type_brochures.build(holiday_type: ski_holidays)
les_houches.save!

Airport.destroy_all
geneva = Airport.create!(name: 'Geneva', code: 'GVA', country: france)
grenoble = Airport.create!(name: 'Grenoble', code: 'GNB', country: france)
AirportDistance.create!([
  {airport: geneva, resort: chamonix, distance_km: 90},
  {airport: grenoble, resort: chamonix, distance_km: 255}
])

bars = Category.create!(name: 'Bars')

Category.create!([
  { name: 'Restaurants' },
  { name: 'Nightclubs' },
  { name: 'Babysitters' },
  { name: 'Child Clubs' },
  { name: 'Car Hire' },
  { name: 'Mountain Guides' },
  { name: 'Estate Agents' },
  { name: 'Lawyers' },
])

images = []
(1..50).each do |i|
  img = Image.new
  n = ((i - 1) % 30) + 1
  img.image = File.open("test-files/properties/chalet#{n}.jpg", 'rb')
  img.save!
  images[i] = img
end

PropertyBasePrice.create!(number_of_months: 12, price: 150)

TripAdvisorLocation.delete_all

TripAdvisorLocation.create!([
  { id: 6, name: 'Africa', location_type: 'continent' },
  { id: 293808, name: 'Madagascar', location_type: 'country', parent_id: 6 }
])

trip_advisor_chamonix = TripAdvisorLocation.create!(
  name: 'Chamonix',
  resort: chamonix,
  location_type: 'town'
)

trip_advisor_property = TripAdvisorProperty.create!(
  review_average: 4.5,
  trip_advisor_location: trip_advisor_chamonix,
  starting_price: 1400,
  currency: euros,
  min_stay_low: 2,
  min_stay_high: 7,
  sleeps: 9,
  title: 'TA Prop'
)

properties = Property.create!([
  { resort: chamonix, user: alice, name: "Alpen Lounge",      address: '123 street', sleeping_capacity: 6,   metres_from_lift: 2500, weekly_rent_price: 1750, currency: euros, image:  images[1], listing_type: Property::LISTING_TYPE_FOR_RENT, publicly_visible: true, layout: 'Showcase' },
  { resort: chamonix, user: alice, name: "Apartment Teracce", address: '123 street', sleeping_capacity: 8,   metres_from_lift: 4700, weekly_rent_price: 2000, currency: euros, image:  images[2], listing_type: Property::LISTING_TYPE_FOR_RENT, publicly_visible: true },
  { resort: chamonix, user: alice, name: "Brigitte's Mazot",  address: '123 street', sleeping_capacity: 2,   metres_from_lift: 3100, weekly_rent_price: 1825, currency: euros, image:  images[3], listing_type: Property::LISTING_TYPE_FOR_RENT, publicly_visible: true },
  { resort: chamonix, user: alice, name: "Chalet Alaska",     address: '123 street', sleeping_capacity: 5,   metres_from_lift: 8300, weekly_rent_price: 1950, currency: euros, image:  images[4], listing_type: Property::LISTING_TYPE_FOR_RENT, publicly_visible: true },
  { resort: chamonix, user: alice, name: "Chalet Anchorage",  address: '123 street', sleeping_capacity: 10,  metres_from_lift: 5000, weekly_rent_price: 1650, currency: euros, image:  images[5], listing_type: Property::LISTING_TYPE_FOR_RENT, publicly_visible: true },
  { resort: chamonix, user: alice, name: "Chalet Arkle",      address: '123 street', sleeping_capacity: 14,  metres_from_lift: 4000, weekly_rent_price: 1725, currency: euros, image:  images[6], listing_type: Property::LISTING_TYPE_FOR_RENT, publicly_visible: true },
  { resort: chamonix, user: alice, name: "Chalet Azimuth",    address: '123 street', sleeping_capacity: 8,   metres_from_lift: 6300, weekly_rent_price: 2150, currency: euros, image:  images[7], listing_type: Property::LISTING_TYPE_FOR_RENT, publicly_visible: true },
  { resort: chamonix, user: alice, name: "Chalet Bibendum",   address: '123 street', sleeping_capacity: 8,   metres_from_lift: 5500, weekly_rent_price: 1350, currency: euros, image:  images[8], listing_type: Property::LISTING_TYPE_FOR_RENT, publicly_visible: true,
    description: 'Stylish and sophisticated, Radisson Blu Edinburgh is located on the historic Royal Mile in the heart of the city. Popular attractions such as Edinburgh Castle, Holyrood Palace and Edinburgh Vaults are within walking distance. Each of the 238 elegant bedrooms and suites offer modern...',
    latitude: 51.509865, longitude: -0.118092 },
  { resort: chamonix, user: alice, name: "Chalet Bornian",    address: '123 street', sleeping_capacity: 8,   metres_from_lift: 4400, weekly_rent_price: 1400, currency: euros, image:  images[9], listing_type: Property::LISTING_TYPE_FOR_RENT, publicly_visible: true },
  { resort: chamonix, user: alice, name: "Chalet Chachat",    address: '123 street', sleeping_capacity: 14,  metres_from_lift: 3500, weekly_rent_price: 1500, currency: euros, image: images[10], listing_type: Property::LISTING_TYPE_FOR_RENT, publicly_visible: true },
  { resort: chamonix, user: alice, name: "Chalet Cachemire",  address: '123 street', sleeping_capacity: 20,  metres_from_lift: 1400, weekly_rent_price: 1375, currency: euros, image: images[11], listing_type: Property::LISTING_TYPE_FOR_RENT, publicly_visible: true },
  { resort: chamonix, user: alice, name: "Chalet Chardonnet", address: '123 street', sleeping_capacity: 8,   metres_from_lift: 9300, weekly_rent_price: 2000, currency: euros, image: images[12], listing_type: Property::LISTING_TYPE_FOR_RENT, publicly_visible: true },
  { resort: chamonix, user: alice, name: "Chalet Chintalaya", address: '123 street', sleeping_capacity: 10,  metres_from_lift: 6500, weekly_rent_price: 1475, currency: euros, image: images[13], listing_type: Property::LISTING_TYPE_FOR_RENT, publicly_visible: true },
  { resort: chamonix, user: alice, name: "Chalet Chosalet",   address: '123 street', sleeping_capacity: 8,   metres_from_lift: 5900, weekly_rent_price: 2025, currency: euros, image: images[14], listing_type: Property::LISTING_TYPE_FOR_RENT, publicly_visible: true },
  { resort: chamonix, user: alice, name: "Chalet D'Or",       address: '123 street', sleeping_capacity: 8,   metres_from_lift: 6000, weekly_rent_price: 1550, currency: euros, image: images[15], listing_type: Property::LISTING_TYPE_FOR_RENT, publicly_visible: true },
  { resort: chamonix, user: alice, name: "Chalet des Sapins", address: '123 street', sleeping_capacity: 10,  metres_from_lift: 4300, weekly_rent_price: 1650, currency: euros, image: images[16], listing_type: Property::LISTING_TYPE_FOR_RENT, publicly_visible: true },
  { resort: chamonix, user: alice, name: "Chalet des Isles",  address: '123 street', sleeping_capacity: 12,  metres_from_lift: 2600, weekly_rent_price: 1850, currency: euros, image: images[17], listing_type: Property::LISTING_TYPE_FOR_RENT, publicly_visible: true },
  { resort: chamonix, user: alice, name: "Chalet des Islouts", address: '123 street', sleeping_capacity: 8,  metres_from_lift: 8500, weekly_rent_price: 1550, currency: euros, image: images[18], listing_type: Property::LISTING_TYPE_FOR_RENT, publicly_visible: true },
  { resort: chamonix, user: alice, name: "Chalet Dubrulle",   address: '123 street', sleeping_capacity: 11,  metres_from_lift: 5000, weekly_rent_price: 1575, currency: euros, image: images[19], listing_type: Property::LISTING_TYPE_FOR_RENT, publicly_visible: true },
  { resort: chamonix, user: alice, name: "Chalet Eco-Farm",   address: '123 street', sleeping_capacity: 10,  metres_from_lift: 7200, weekly_rent_price: 2100, currency: euros, image: images[20], listing_type: Property::LISTING_TYPE_FOR_RENT, publicly_visible: true },
  { resort: chamonix, user: alice, name: "Chalet Edelweiss",  address: '123 street', sleeping_capacity: 12,  metres_from_lift: 4200, weekly_rent_price: 1900, currency: euros, image: images[21], listing_type: Property::LISTING_TYPE_FOR_RENT, publicly_visible: true },
  { resort: chamonix, user: alice, name: "Chalet Eftikhia" ,  address: '123 street', sleeping_capacity: 10,  metres_from_lift: 5900, weekly_rent_price: 1600, currency: euros, image: images[22], listing_type: Property::LISTING_TYPE_FOR_RENT, publicly_visible: true },
  { resort: chamonix, user: alice, name: "Chalet Flegere",    address: '123 street', sleeping_capacity: 10,  metres_from_lift: 3400, weekly_rent_price: 1700, currency: euros, image: images[23], listing_type: Property::LISTING_TYPE_FOR_RENT, publicly_visible: true },
  { resort: chamonix, user: alice, name: "Chalet Gauthier",   address: '123 street', sleeping_capacity: 16,  metres_from_lift: 4300, weekly_rent_price: 1600, currency: euros, image: images[24], listing_type: Property::LISTING_TYPE_FOR_RENT, publicly_visible: true },
  { resort: chamonix, user: alice, name: "Les Citronniers",   address: '123 street', sleeping_capacity: 8,   metres_from_lift: 6800, weekly_rent_price: 1450, currency: euros, image: images[25], listing_type: Property::LISTING_TYPE_FOR_RENT, publicly_visible: true },
  { resort: chamonix, user: alice, name: "Chalet Grassonnets", address: '123 street', sleeping_capacity: 8,  metres_from_lift: 3500, weekly_rent_price: 1300, currency: euros, image: images[26], listing_type: Property::LISTING_TYPE_FOR_SALE, publicly_visible: true, layout: 'Showcase' },
  { resort: chamonix, user: alice, name: "Chalet Guapa",      address: '123 street', sleeping_capacity: 8,   metres_from_lift: 4500, weekly_rent_price: 1800, currency: euros, image: images[27], listing_type: Property::LISTING_TYPE_FOR_SALE, publicly_visible: true },
  { resort: chamonix, user: alice, name: "Chalet Ibex",       address: '123 street', sleeping_capacity: 10,  metres_from_lift: 5600, weekly_rent_price: 1925, currency: euros, image: images[28], listing_type: Property::LISTING_TYPE_FOR_SALE, publicly_visible: true },
  { resort: chamonix, user: alice, name: "Chalet Jomain",     address: '123 street', sleeping_capacity: 18,  metres_from_lift: 10200, weekly_rent_price: 2050, currency: euros, image: images[29], listing_type: Property::LISTING_TYPE_FOR_SALE, publicly_visible: true },
  ])

a_trip_advisor_chalet = Property.create!(
  resort: chamonix, user: trip_advisor, name: 'A TripAdvisor Chalet',
  address: 'On a mountain', sleeping_capacity: 9, number_of_bedrooms: 6,
  number_of_bathrooms: 2, weekly_rent_price: 1400, currency: euros,
  image: images[30], listing_type: Property::LISTING_TYPE_FOR_RENT,
  publicly_visible: true, trip_advisor_property: trip_advisor_property,
  description: 'This amazing chalet...'
)

a_trip_advisor_chalet.amenities << Amenity.create(name: 'BBQ')
a_trip_advisor_chalet.amenities << Amenity.create(name: 'IRON')
a_trip_advisor_chalet.amenities << Amenity.create(name: 'FRIDGE')
a_trip_advisor_chalet.amenities << Amenity.create(name: 'AIR_CONDITIONING')
a_trip_advisor_chalet.amenities << Amenity.create(name: 'DRYER')
a_trip_advisor_chalet.amenities << Amenity.create(name: 'DVD')
a_trip_advisor_chalet.amenities << Amenity.create(name: 'INTERNET_ACCESS')
a_trip_advisor_chalet.amenities << Amenity.create(name: 'MICROWAVE')
a_trip_advisor_chalet.amenities << Amenity.create(name: 'PARKING')
a_trip_advisor_chalet.amenities << Amenity.create(name: 'SATELLITE_TV')
a_trip_advisor_chalet.amenities << Amenity.create(name: 'TV')
a_trip_advisor_chalet.amenities << Amenity.create(name: 'WASHING_MACHINE')
a_trip_advisor_chalet.amenities << Amenity.create(name: 'STOVE')
a_trip_advisor_chalet.amenities << Amenity.create(name: 'DECK')
a_trip_advisor_chalet.amenities << Amenity.create(name: 'WATERFRONT')

a_trip_advisor_chalet.reviews << Review.create!(
  author_location: 'Bergheim, France',
  author_name: 'Laetitia P',
  content: "Connu sous le nom de Chalet des Ayes, nous y avons trouvé notre bonheur. Nous sommes la même bande d'ami(e)s qui partons quasiment tous les ans à Pâques, pour le WE, bande qui s'est agrandie avec les conjoints et les enfants au fil des années. Nous avons loué le chalet 26 (18 personnes) et 21 (7 personnes) à un prix correct. Les chalets sont beaux et bien agencés (draps fournis) et équipés  (juste un problème avec le lave vaisselle et le four que nous avons signalé). Sur place, une grande aire de jeux, une salle d'accueil avec un bar en libre service  (bière, café, sirop et pâte à crêpes!), magazines, table de ping-pong, baby-foot et quelques tables ou s'installer. Terrain de tennis, de pétanque. Piscine et jacuzzi intérieur. Piste de bowling. Piscine extérieure en saison  (tout est gratuit mais sur réservation pour les locataires). Haras tout près  (le Closel) pour faire une balade à cheval  (18€/personne). Boulangerie et Intermarche à 5 minutes en voiture. Bref, un paradis pour les enfants et les parents ! Je recommande vivement. ",
  property: a_trip_advisor_chalet,
  rating: 5,
  title: 'Super!',
  visited_on: Date.new(2017, 4, 1)
)

n = 0
properties.each do |property|
  n += 1
  images[n].property = property
  images[n].save!
end

InterhomeAccommodation.destroy_all
interhome_accommodation = InterhomeAccommodation.create!(
  accommodation_type: 'T',
  bathrooms: 0,
  bedrooms: 2,
  brand: 0,
  code: 'CH1912.712.1',
  country: 'FR',
  details: '',
  features: 'shower,hikingmountains,bbq',
  floor: 0,
  geodata_lat: '66.073845',
  geodata_lng: '28.929323',
  name: 'Holiday House Voltaire',
  pax: 10,
  permalink: 'ch1912-712-1',
  place: '1234',
  quality: 3,
  region: '1',
  rooms: 3,
  sqm: 10,
  themes: 'FAMILY,IN A LAKESIDE TOWN,LAKES AND MOUNTAINS',
  toilets: 1,
  zip: 'ZIP'
)
interhome_property = Property.create!(
  resort: chamonix,
  user: alice,
  name: 'Holiday House Voltaire',
  address: '123 street',
  sleeping_capacity: 8,
  metres_from_lift: 9800, weekly_rent_price: 1500,
  currency: euros,
  image_id: 30,
  listing_type: Property::LISTING_TYPE_FOR_RENT,
  publicly_visible: true,
  interhome_accommodation_id: interhome_accommodation.id,
  image: images[31]
)
40.downto(31).each {|i| interhome_property.images << images[i]}

InterhomeVacancy.destroy_all
InterhomeVacancy.create!(
  accommodation_code: 'CH1912.712.1',
  availability: 'YYYYYYYYYNNNNNNNNNNNNNNYYNNNNNNNYYYYYYYYYYYYNNNNNNNYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYNNNNNNNYYYYYYYNNNNNNNYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYY',
  changeover: 'CCCCCCCOOOXXXXXXXXXXXXXXOOXXXXXXICCCCCOOOOOOOXXXXXXICCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCXXXXXXOXXXXXXIOOOOOOOXXXXXXICCCCCCCCCCCCCCCCCCCCCXXXXXXCXXXXXXCXXXXXXCXXXXXXCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCXXXXXXCXXXXXXCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCXXXXXXCXXXXXXCXXXXXXCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCOOOOOOO',
  flexbooking: 'YYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYNNNNNNNNNNNNNNYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYNNNNNNNNNNNNNNNNNNNNNNNNNNNNYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYNNNNNNNNNNNNNNYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYNNNNNNNNNNNNNNNNNNNNNNYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYY',
  interhome_accommodation_id: interhome_accommodation.id,
  minstay: 'CCCCCCCCCCCCCCCGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGG',
  startday: Date.today
)

DirectoryAdvert.destroy_all

directory_advert = DirectoryAdvert.new(
  category_id: bars.id,
  resort_id: chamonix.id,
  business_name: 'My Business',
  business_address: '123 Street',
  strapline: 'Awesome'
)
directory_advert.user_id = alice.id
directory_advert.save!

Order.destroy_all
order = Order.create!(
  user_id: alice.id,
  email: alice.email,
  name: alice.first_name,
  address: alice.billing_street,
  country: alice.billing_country,
  phone: '+44.1234567890',
  status: Order::PAYMENT_RECEIVED,
  total: 50
)

Payment.create!(
  order: order,
  service_provider: 'WorldPay',
  amount: '50'
)

Enquiry.create!(user: bob, name: 'Carol', email: 'carol@example.org', phone: '01234 567890')
