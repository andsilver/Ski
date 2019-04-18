# frozen_string_literal: true

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

require "./db/pages/static"
include Static

website = Website.create!(home_content: STATIC[:website])

CarouselSlide.delete_all
CarouselSlide.create!([
  {caption: "<p>Ski Holidays</p><p>A wide choice of international<br>ski resorts around the world</p>", link: "/holidays/ski-holidays", image_url: "home/sh-home.png"},
  {caption: "<p>City Breaks</p><p>All year round destinations – <br>explore something new</p>", link: "/holidays/city-breaks", image_url: "home/ex-slider.png"},
  {caption: "<p>Summer Villas</p><p>A great choice from the blue seas of <br>the Amalfi Coast to the Florida Keys</p>", link: "/holidays/summer-villas", image_url: "home/sv-home.png"},
  {caption: "<p>Lakes & Mountains<p><p>Beautiful lakeside resorts in picture <br>postcard settings</p>", link: "/holidays/lakes-and-mountains", image_url: "home/lm-home.png"},
])
Page.create!([
  {path: "/pages/about", title: "About"},
  {
    path: "/resorts/chamonix/properties/rent",
    title: "Chamonix Chalets & Apartments to Rent | Chamonix Holiday Rental Accommodation",
    description: "Looking for a Chamonix chalet or apartment? Over 100 self catering holiday rental chalets and apartments to choose from for all budgets and tastes for your ski or summer holidays - enquire or book online",
    keywords: "chamonix chalets, accommodation in chamonix, chalet rentals in chamonix, chamonix holiday rentals , chamonix vacation rentals, apartments for rent in chamonix, luxury chamonix chalets, hot tubs, ski-in, ski-out, mychaletfinder",
    header_snippet_name: "intersport",
    content: STATIC[:resorts][:chamonix][:rent],
  },
  {
    path: "/resorts/chamonix/properties/sale",
    title: "Chamonix Chalets & Apartments for Sale | Chamonix Real Estate",
    description: "Chamonix ski chalets & apartments for sale in Chamonix for all budgets - from studio apartments, holiday homes & luxury ski chalets in Chamonix  to buy - see our selection at MyChaletFinder...",
    keywords: "accommodation-in-chamonix, chamonix chalets for sale, chamonix apartments for sale, ski holiday accommodation to buy, mychaletfinder",
    header_snippet_name: "intersport",
    content: STATIC[:resorts][:chamonix][:sale],

  },
  {
    path: "/pages/heli-skiing-in-greenland",
    title: "Greenland Heli-skiing | Ski Tours Kangaamiut, Greenland",
    content: STATIC[:experiences][:heli_skiing][:greenland],
  },
  {
    path: "/pages/heli-skiing",
    title: "Heli-skiing",
    header_snippet_name: "search",
    content: STATIC[:experiences][:heli_skiing][:main],
  },
  {
    path: "/pages/property-for-sale",
    title: "Property for Sale -  Luxury Ski Chalets, Villas & Apartments for Sale",
    content: STATIC[:properties][:sale],
  },
  {
    path: "/regions/les-3-vallees/piste_map",
    title: "Les 3 Vallees Piste Map | Trois Vallees Trail & Ski Area Map",
    description: "Plan where to ski with the Trois Vallees piste map - the 3 Valleys provides over 600kms of pistes for every level of skiers and snowboarder across 8 fabulous resorts - from forest trails to glacier skiing, Les 3 Vallees is incredible....",
    keywords: "3 valleys piste map, trail map, ski area map for les 3 vallees, mychaletfinder",
    content: STATIC[:regions][:les_3_vallees][:piste_map],
  },
  {
    path: "/countries/switzerland/holidays/ski-holidays",
    title: "Switzerland Ski Chalet Holidays | Swiss Ski Resorts | Chalets",
    content: STATIC[:countries][:swiss][:ski_holidays],
    description: "Swiss ski holidays - search through our comprehensive list of Swiss ski resorts for fantastic self catering ski chalets amongst breathtaking scenery - ideal for family holidays. Book your accommodation online for great deals",
    keywords: "",
  },
  {
    path: "/regions/bernese-oberland",
    title: "Bernese Oberland Ski Holidays | Ski Resorts | Chalet Rentals",
    description: "Bernese Oberland ski holidays - with 38 ski resorts including Grindelwald & Wengen in the Jungfrau Region and glitzy Gstaad, the region is a treasure chest waiting to be explored - book ski holiday rentals online...",
    keywords: "bernese oberland, ski, holidays, resorts, chalets, mychaletfinder",
  },
  {
    path: "/resorts/verbier-st-bernard/ski-and-guiding-schools",
    title: "Verbier Ski Schools | Ski Lessons | Off-Piste Ski Tours | Mountain Guides",
    description: "Verbier ski schools cater for absolute beginners to experts with private  and group lessons for skiing, snowboarding, off-piste and guided tours including the famous Haute Route to Zermatt",
    keywords: "verbier ski schools, ski touring in verbier, verbier ski guides, haute route guides, snowboarding lessons in verbier, private ski lessons, group snowboarding lessons",
    content: STATIC[:resorts][:verbier_st_island][:ski_schools],
  },
  {
    path: "/resorts/chamonix/summer-holidays",
    title: "Chamonix Summer Holidays Guide | Chalets & Apartments to Rent",
    description: "Summer rental accommodation in Chamonix - a resort busier in summer than in winter. Great choice of chalet rentals & apartments to rent in Chamonix for your summer holiday.  Book a holiday rental in Chamonix activities for all ages...",
    keywords: "chamonix chalets, chalet rentals in chamonix, holiday rentals in chamonix, summer holidays in chamonix, accommodation in chamonix, holiday homes for rent in chamonix, mychaletfinder",
    content: STATIC[:resorts][:chamonix][:summer_holidays],
  },
  {
    path: "/resorts/chamonix/how-to-get-there",
    title: "How to get to Chamonix - transfers, car & train",
    description: "Chamonix is one of the easiest resorts to get to in the Alps with transfers taking a little over 1 hour and its motorway all the way from Geneva. Car rentals and airport transfers are available at the airport - book online",
    keywords: "airport transfers to chamonix, transfers to chamonix, directions to chamonix, cheap transfers to chamonix, geneva to chamonix transfers, mychaletfinder",
    content: STATIC[:resorts][:chamonix][:how_to_get_there],
  },
  {
    path: "/countries/france/holidays/ski-holidays",
    title: "France Ski Holidays 2015 | French Ski Chalet Holidays",
    description: "Ski holidays to the French Alps - choose from over 1000 chalets and apartments to rent in over 30 French ski resorts - ideal for family ski holidays, great value and many offering ski-in, ski-out  book online for great deals",
    keywords: "ski holiday, skiing holidays",
    content: STATIC[:countries][:france][:ski_holidays],
  },
  {
    path: "/countries/france/holidays/ski-holidays/ski-areas",
    title: "France Ski Holidays 2015 | French Ski Chalet Holidays",
    description: "Ski holidays to the French Alps - choose from over 1000 chalets and apartments to rent in over 30 French ski resorts - ideal for family ski holidays, great value and many offering ski-in, ski-out  book online for great deals",
    keywords: "ski holiday, skiing holidays",
    content: STATIC[:countries][:france][:ski_regions],
  },
  {
    path: "/countries/france/holidays/ski-holidays/ski-resorts",
    title: "France Ski Holidays 2015 | French Ski Chalet Holidays",
    description: "Ski holidays to the French Alps - choose from over 1000 chalets and apartments to rent in over 30 French ski resorts - ideal for family ski holidays, great value and many offering ski-in, ski-out  book online for great deals",
    keywords: "ski holiday, skiing holidays",
    content: STATIC[:countries][:france][:ski_resorts],
  },
  {
    path: "/countries/france/holidays/ski-holidays/transfer-times",
    title: "France Ski Holidays 2015 | French Ski Chalet Holidays",
    description: "Ski holidays to the French Alps - choose from over 1000 chalets and apartments to rent in over 30 French ski resorts - ideal for family ski holidays, great value and many offering ski-in, ski-out  book online for great deals",
    keywords: "ski holiday, skiing holidays",
    content: STATIC[:countries][:france][:transfer_times],
  },
  {
    path: "/holidays/ski-holidays",
    title: "Ski Holidays | Skiing Vacations | Ski Holiday Chalets",
    description: "Looking for a ski holiday?  From Europe, Canada, America to India and Morocco, Mychaletfinder covers over 170 ski resorts with resort reviews, features,  chalet accommodation plus suggestions for family holidays, summer ski and ski trips around the world.",
    keywords: "ski holiday, skiing holidays",
    content: STATIC[:holidays][:ski_holidays],
  },
])

ski_holidays = HolidayType.create!(
  name: "Ski Holidays in...",
  slug: "ski-holidays",
  mega_menu_html: '
    <li><a href="/holidays/ski-holidays">Overview</a></li>
    <li><a href="/countries/france/holidays/ski-holidays">Ski holidays in France</a></li>
    <li><a href="/countries/switzerland/holidays/ski-holidays">Ski holidays in Switzerland</a></li>'
)
# <li><a href="/countries/austria/holidays/ski-holidays">Austria</a></li>
# <li><a href="/countries/united-states/holidays/ski-holidays">United States</a></li>
# <li><a href="/countries/canada/holidays/ski-holidays">Canada</a></li>
# <li><a href="/countries/united-kingdom/holidays/ski-holidays">United Kingdom</a></li>
# <li><a href="/countries/norway/holidays/ski-holidays">Norway</a></li>
# <li><a href="/countries/finland/holidays/ski-holidays">Finland</a></li>
# <li><a href="/countries/andora/holidays/ski-holidays">Andora</a></li>
# <li><a href="/countries/germany/holidays/ski-holidays">Germany</a></li>

besk_ski_resorts = HolidayType.create!(
  name: "Besk Ski Resorts for...",
  slug: "best-ski-resorts",
  mega_menu_html: '
    <li><a href="/pages/beginner-ski-resorts">Beginners</a></li>
    <li><a href="/pages/intermediate-ski-resorts">Intermediates</a></li>
    <li><a href="/pages/family-ski-resorts">Families</a></li>
    <li><a href="/pages/christmas-ski-holidays">Skiing at Christmas</a></li>'
)

# <li><a href="/pages/best-ski-tours-alps">Ski Touring</a></li>
# <li><a href="/pages/summer-skiing">Summer Skiing</a></li>
# <li><a href="/pages/ski-in-ski-out-ski-resorts-chalets">Ski-in, Ski-out Chalets</a></li>
# <li><a href="/pages/lapland-ski-holidays">Northern Lights</a></li>

experiences = HolidayType.create!(
  name: "Experiences",
  slug: "experiences",
  mega_menu_html: '
    <li><a href="/holidays/spa-resorts">Spa & Wellness</a></li>
    <li><a href="/pages/best-christmas-markets-ski-resorts">Christmas Markets</a></li>
    <li><a href="/pages/lapland-ski-holidays">Lapland & Northern Lights</a></li>
    <li><a href="/pages/best-ski-tours-alps">Ski Tours</a></li>
    <li><a href="/pages/heli-skiing">Heli-Skiing</a></li>
  '
)

services = HolidayType.create!(
  name: "Services",
  slug: "services",
  mega_menu_html: '
    <li><a href="/pages/car-hire-car-rentals">Car Hire</a></li>
    <li><a href="/pages/fc-exchange">Foreign Exchange</a></li>
  '
)

#     <li><a href="/pages/snow-reports-snow-forecasts">Snow Forecasts</a></li>
#     <li><a href="/pages/ski-rentals-ski-hire">Ski Rental</a></li>
#     <li><a href="/pages/airport-transfers">Airport Transfers</a></li>
#     <li><a href="/pages/travel-insurance">Travel Insurance</a></li>
#     <li><a href="">Newsletters</a></li>

currencies = [
  {name: "Euro", unit: "€", pre: true, code: "EUR", in_euros: 1},
  {name: "GBP",  unit: "£", pre: true, code: "GBP", in_euros: 0.89},
]
currencies.each do |c|
  Currency.create!(name: c[:name], unit: c[:unit], pre: c[:pre], code: c[:code], in_euros: c[:in_euros])
end
gbps = Currency.find_by(code: "GBP")
euros = Currency.find_by(code: "EUR")

countries = [
  {name: "Andorra",               iso_3166_1_alpha_2: "AD"},
  {name: "Afghanistan",           iso_3166_1_alpha_2: "AF"},
  {name: "Albania",               iso_3166_1_alpha_2: "AL"},
  {name: "Algeria",               iso_3166_1_alpha_2: "DZ"},
  {name: "Angola",                iso_3166_1_alpha_2: "AO"},
  {name: "Anguilla",              iso_3166_1_alpha_2: "AI"},
  {name: "Antarctica",            iso_3166_1_alpha_2: "AQ"},
  {name: "Antigua and Barbuda",   iso_3166_1_alpha_2: "AG"},
  {name: "Argentina",             iso_3166_1_alpha_2: "AR"},
  {name: "American Samoa",        iso_3166_1_alpha_2: "AS"},
  {name: "Åland Islands",         iso_3166_1_alpha_2: "AX"},
  {name: "Armenia",               iso_3166_1_alpha_2: "AM"},
  {name: "Aruba",                 iso_3166_1_alpha_2: "AW"},
  {name: "Australia",             iso_3166_1_alpha_2: "AU"},
  {name: "Austria",               iso_3166_1_alpha_2: "AT"},
  {name: "Azerbaijan",            iso_3166_1_alpha_2: "AZ"},
  {name: "Bahamas",               iso_3166_1_alpha_2: "BS"},
  {name: "Bahrain",               iso_3166_1_alpha_2: "BH"},
  {name: "Bangladesh",            iso_3166_1_alpha_2: "BD"},
  {name: "Barbados",              iso_3166_1_alpha_2: "BB"},
  {name: "Belarus",               iso_3166_1_alpha_2: "BY"},
  {name: "Belgium",               iso_3166_1_alpha_2: "BE"},
  {name: "Belize",                iso_3166_1_alpha_2: "BZ"},
  {name: "Benin",                 iso_3166_1_alpha_2: "BJ"},
  {name: "Bermuda",               iso_3166_1_alpha_2: "BM"},
  {name: "Bhutan",                iso_3166_1_alpha_2: "BT"},
  {name: "Bolivia",               iso_3166_1_alpha_2: "BO"},
  {name: "Bosnia and Herzegovina", iso_3166_1_alpha_2: "BA"},
  {name: "Botswana",              iso_3166_1_alpha_2: "BW"},
  {name: "Bouvet Island",         iso_3166_1_alpha_2: "BV"},
  {name: "Brazil",                iso_3166_1_alpha_2: "BR"},
  {name: "British Indian Ocean Territory", iso_3166_1_alpha_2: "IO"},
  {name: "Brunei",                iso_3166_1_alpha_2: "BN"},
  {name: "Bulgaria",              iso_3166_1_alpha_2: "BG"},
  {name: "Burkina Faso",          iso_3166_1_alpha_2: "BF"},
  {name: "Burundi",               iso_3166_1_alpha_2: "BI"},
  {name: "Cameroon",              iso_3166_1_alpha_2: "CM"},
  {name: "Canada",                iso_3166_1_alpha_2: "CA"},
  {name: "Cambodia",              iso_3166_1_alpha_2: "KH"},
  {name: "Cape Verde",            iso_3166_1_alpha_2: "CV"},
  {name: "Cayman Islands",        iso_3166_1_alpha_2: "KY"},
  {name: "Central African Republic", iso_3166_1_alpha_2: "CF"},
  {name: "Chad",                  iso_3166_1_alpha_2: "TD"},
  {name: "Chile",                 iso_3166_1_alpha_2: "CL"},
  {name: "China",                 iso_3166_1_alpha_2: "CN"},
  {name: "Christmas Island",      iso_3166_1_alpha_2: "CX"},
  {name: "Cocos (Keeling) Islands", iso_3166_1_alpha_2: "CC"},
  {name: "Colombia",              iso_3166_1_alpha_2: "CO"},
  {name: "Congo",                 iso_3166_1_alpha_2: "CG"},
  {name: "Congo, the Democratic Republic of", iso_3166_1_alpha_2: "CD"},
  {name: "Comoros",               iso_3166_1_alpha_2: "KM"},
  {name: "Cook Islands",          iso_3166_1_alpha_2: "CK"},
  {name: "Costa Rica",            iso_3166_1_alpha_2: "CR"},
  {name: "Côte d'Ivoire", iso_3166_1_alpha_2: "CI"},
  {name: "Croatia",               iso_3166_1_alpha_2: "HR"},
  {name: "Cuba",                  iso_3166_1_alpha_2: "CU"},
  {name: "Cyprus",                iso_3166_1_alpha_2: "CY"},
  {name: "Czech Republic",        iso_3166_1_alpha_2: "CZ"},
  {name: "Denmark",               iso_3166_1_alpha_2: "DK"},
  {name: "Djibouti",              iso_3166_1_alpha_2: "DJ"},
  {name: "Dominica",              iso_3166_1_alpha_2: "DM"},
  {name: "Dominican Republic",    iso_3166_1_alpha_2: "DO"},
  {name: "Ecuador",               iso_3166_1_alpha_2: "EC"},
  {name: "Egypt",                 iso_3166_1_alpha_2: "EG"},
  {name: "El Salvador",           iso_3166_1_alpha_2: "SV"},
  {name: "Equatorial Guinea",     iso_3166_1_alpha_2: "GQ"},
  {name: "Estonia",               iso_3166_1_alpha_2: "EE"},
  {name: "Eritrea",               iso_3166_1_alpha_2: "ER"},
  {name: "Ethiopia",              iso_3166_1_alpha_2: "ET"},
  {name: "Falkland Islands (Malvinas)", iso_3166_1_alpha_2: "FK"},
  {name: "Faroe Islands",         iso_3166_1_alpha_2: "FO"},
  {name: "Fiji",                  iso_3166_1_alpha_2: "FJ"},
  {name: "Finland",               iso_3166_1_alpha_2: "FI"},
  {name: "France",                iso_3166_1_alpha_2: "FR"},
  {name: "French Guiana",         iso_3166_1_alpha_2: "GF"},
  {name: "French Polynesia",      iso_3166_1_alpha_2: "PF"},
  {name: "French Southern Territories", iso_3166_1_alpha_2: "TF"},
  {name: "Gabon",                 iso_3166_1_alpha_2: "GA"},
  {name: "Gambia",                iso_3166_1_alpha_2: "GM"},
  {name: "Georgia",               iso_3166_1_alpha_2: "GE"},
  {name: "Germany",               iso_3166_1_alpha_2: "DE"},
  {name: "Ghana",                 iso_3166_1_alpha_2: "GH"},
  {name: "Gibraltar",             iso_3166_1_alpha_2: "GI"},
  {name: "Greece",                iso_3166_1_alpha_2: "GR"},
  {name: "Greenland",             iso_3166_1_alpha_2: "GL"},
  {name: "Grenada",               iso_3166_1_alpha_2: "GD"},
  {name: "Guadeloupe",            iso_3166_1_alpha_2: "GP"},
  {name: "Guam",                  iso_3166_1_alpha_2: "GU"},
  {name: "Guatemala",             iso_3166_1_alpha_2: "GT"},
  {name: "Guernsey",              iso_3166_1_alpha_2: "GG"},
  {name: "Guinea",                iso_3166_1_alpha_2: "GN"},
  {name: "Guinea-Bissau",         iso_3166_1_alpha_2: "GW"},
  {name: "Guyana",                iso_3166_1_alpha_2: "GY"},
  {name: "Haiti",                 iso_3166_1_alpha_2: "HT"},
  {name: "Heard Island and McDonald Islands", iso_3166_1_alpha_2: "HM"},
  {name: "Holy See (Vatican City State)", iso_3166_1_alpha_2: "VA"},
  {name: "Honduras",              iso_3166_1_alpha_2: "HN"},
  {name: "Hong Kong",             iso_3166_1_alpha_2: "HK"},
  {name: "Hungary",               iso_3166_1_alpha_2: "HU"},
  {name: "Iceland",               iso_3166_1_alpha_2: "IS"},
  {name: "India",                 iso_3166_1_alpha_2: "IN"},
  {name: "Indonesia",             iso_3166_1_alpha_2: "ID"},
  {name: "Iran",                  iso_3166_1_alpha_2: "IR"},
  {name: "Iraq",                  iso_3166_1_alpha_2: "IQ"},
  {name: "Ireland",               iso_3166_1_alpha_2: "IE"},
  {name: "Isle of Man",           iso_3166_1_alpha_2: "IM"},
  {name: "Israel",                iso_3166_1_alpha_2: "IL"},
  {name: "Italy",                 iso_3166_1_alpha_2: "IT"},
  {name: "Jamaica",               iso_3166_1_alpha_2: "JM"},
  {name: "Japan",                 iso_3166_1_alpha_2: "JP"},
  {name: "Jersey",                iso_3166_1_alpha_2: "JE"},
  {name: "Jordan",                iso_3166_1_alpha_2: "JO"},
  {name: "Kazakhstan",            iso_3166_1_alpha_2: "KZ"},
  {name: "Kenya",                 iso_3166_1_alpha_2: "KE"},
  {name: "Kiribati",              iso_3166_1_alpha_2: "KI"},
  {name: "Kuwait",                iso_3166_1_alpha_2: "KW"},
  {name: "Kyrgyzstan",            iso_3166_1_alpha_2: "KG"},
  {name: "Lao People's Democratic Republic", iso_3166_1_alpha_2: "LA"},
  {name: "Latvia",                iso_3166_1_alpha_2: "LV"},
  {name: "Lebanon",               iso_3166_1_alpha_2: "LB"},
  {name: "Lesotho",               iso_3166_1_alpha_2: "LS"},
  {name: "Liberia",               iso_3166_1_alpha_2: "LR"},
  {name: "Liechtenstein",         iso_3166_1_alpha_2: "LI"},
  {name: "Lithuania",             iso_3166_1_alpha_2: "LT"},
  {name: "Luxembourg",            iso_3166_1_alpha_2: "LU"},
  {name: "Libya",                 iso_3166_1_alpha_2: "LY"},
  {name: "Macao",                 iso_3166_1_alpha_2: "MO"},
  {name: "Macedonia, the former Yugoslav Republic of", iso_3166_1_alpha_2: "MK"},
  {name: "Madagascar",            iso_3166_1_alpha_2: "MG"},
  {name: "Malawi",                iso_3166_1_alpha_2: "MW"},
  {name: "Malaysia",              iso_3166_1_alpha_2: "MY"},
  {name: "Maldives",              iso_3166_1_alpha_2: "MV"},
  {name: "Mali",                  iso_3166_1_alpha_2: "ML"},
  {name: "Malta",                 iso_3166_1_alpha_2: "MT"},
  {name: "Marshall Islands",      iso_3166_1_alpha_2: "MH"},
  {name: "Martinique",            iso_3166_1_alpha_2: "MQ"},
  {name: "Mauritania",            iso_3166_1_alpha_2: "MR"},
  {name: "Mauritius",             iso_3166_1_alpha_2: "MU"},
  {name: "Mayotte",               iso_3166_1_alpha_2: "YT"},
  {name: "Mexico",                iso_3166_1_alpha_2: "MX"},
  {name: "Micronesia, Federated States of", iso_3166_1_alpha_2: "FM"},
  {name: "Moldova",               iso_3166_1_alpha_2: "MD"},
  {name: "Monaco",                iso_3166_1_alpha_2: "MC"},
  {name: "Mongolia",              iso_3166_1_alpha_2: "MN"},
  {name: "Montenegro",            iso_3166_1_alpha_2: "ME"},
  {name: "Montserrat",            iso_3166_1_alpha_2: "MS"},
  {name: "Morocco",               iso_3166_1_alpha_2: "MA"},
  {name: "Mozambique",            iso_3166_1_alpha_2: "MZ"},
  {name: "Myanmar",               iso_3166_1_alpha_2: "MM"},
  {name: "Namibia",               iso_3166_1_alpha_2: "NA"},
  {name: "Nauru",                 iso_3166_1_alpha_2: "NR"},
  {name: "Nepal",                 iso_3166_1_alpha_2: "NP"},
  {name: "Netherlands",           iso_3166_1_alpha_2: "NL"},
  {name: "New Caledonia",         iso_3166_1_alpha_2: "NC"},
  {name: "New Zealand",           iso_3166_1_alpha_2: "NZ"},
  {name: "Nicaragua",             iso_3166_1_alpha_2: "NI"},
  {name: "Niger",                 iso_3166_1_alpha_2: "NE"},
  {name: "Nigeria",               iso_3166_1_alpha_2: "NG"},
  {name: "Niue",                  iso_3166_1_alpha_2: "NU"},
  {name: "Norfolk Island",        iso_3166_1_alpha_2: "NF"},
  {name: "North Korea",           iso_3166_1_alpha_2: "KP"},
  {name: "Northern Mariana Islands", iso_3166_1_alpha_2: "MP"},
  {name: "Norway",                iso_3166_1_alpha_2: "NO"},
  {name: "Oman",                  iso_3166_1_alpha_2: "OM"},
  {name: "Pakistan",              iso_3166_1_alpha_2: "PK"},
  {name: "Palau",                 iso_3166_1_alpha_2: "PW"},
  {name: "Palestinian Territory, Occupied", iso_3166_1_alpha_2: "PS"},
  {name: "Panama",                iso_3166_1_alpha_2: "PA"},
  {name: "Papua New Guinea",      iso_3166_1_alpha_2: "PG"},
  {name: "Paraguay",              iso_3166_1_alpha_2: "PY"},
  {name: "Peru",                  iso_3166_1_alpha_2: "PE"},
  {name: "Philippines",           iso_3166_1_alpha_2: "PH"},
  {name: "Pitcairn",              iso_3166_1_alpha_2: "PN"},
  {name: "Poland",                iso_3166_1_alpha_2: "PL"},
  {name: "Portugal",              iso_3166_1_alpha_2: "PT"},
  {name: "Puerto Rico",           iso_3166_1_alpha_2: "PR"},
  {name: "Qatar",                 iso_3166_1_alpha_2: "QA"},
  {name: "Réunion",               iso_3166_1_alpha_2: "RE"},
  {name: "Romania",               iso_3166_1_alpha_2: "RO"},
  {name: "Russia",                iso_3166_1_alpha_2: "RU"},
  {name: "Rwanda",                iso_3166_1_alpha_2: "RW"},
  {name: "Saint Barthélemy",      iso_3166_1_alpha_2: "BL"},
  {name: "Saint Helena, Ascension and Tristan da Cunha", iso_3166_1_alpha_2: "SH"},
  {name: "Saint Kitts and Nevis", iso_3166_1_alpha_2: "KN"},
  {name: "Saint Lucia",           iso_3166_1_alpha_2: "LC"},
  {name: "Saint Martin (French part)", iso_3166_1_alpha_2: "MF"},
  {name: "Saint Pierre and Miquelon", iso_3166_1_alpha_2: "PM"},
  {name: "Saint Vincent and the Grenadines", iso_3166_1_alpha_2: "VC"},
  {name: "Samoa",                 iso_3166_1_alpha_2: "WS"},
  {name: "San Marino",            iso_3166_1_alpha_2: "SM"},
  {name: "Sao Tome and Principe", iso_3166_1_alpha_2: "ST"},
  {name: "Saudi Arabia",          iso_3166_1_alpha_2: "SA"},
  {name: "Senegal",               iso_3166_1_alpha_2: "SN"},
  {name: "Serbia",                iso_3166_1_alpha_2: "RS"},
  {name: "Seychelles",            iso_3166_1_alpha_2: "SC"},
  {name: "Sierra Leone",          iso_3166_1_alpha_2: "SL"},
  {name: "Singapore",             iso_3166_1_alpha_2: "SG"},
  {name: "Slovakia",              iso_3166_1_alpha_2: "SK"},
  {name: "Slovenia",              iso_3166_1_alpha_2: "SI"},
  {name: "Solomon Islands",       iso_3166_1_alpha_2: "SB"},
  {name: "Somalia",               iso_3166_1_alpha_2: "SO"},
  {name: "South Africa",          iso_3166_1_alpha_2: "ZA"},
  {name: "South Georgia and the South Sandwich Islands", iso_3166_1_alpha_2: "GS"},
  {name: "South Korea",           iso_3166_1_alpha_2: "KR"},
  {name: "Spain",                 iso_3166_1_alpha_2: "ES"},
  {name: "Sri Lanka",             iso_3166_1_alpha_2: "LK"},
  {name: "Sudan",                 iso_3166_1_alpha_2: "SD"},
  {name: "Suriname",              iso_3166_1_alpha_2: "SR"},
  {name: "Svalbard and Jan Mayen", iso_3166_1_alpha_2: "SJ"},
  {name: "Swaziland",             iso_3166_1_alpha_2: "SZ"},
  {name: "Sweden",                iso_3166_1_alpha_2: "SE"},
  {name: "Switzerland",           iso_3166_1_alpha_2: "CH"},
  {name: "Syria",                 iso_3166_1_alpha_2: "SY"},
  {name: "Taiwan, Province of China", iso_3166_1_alpha_2: "TW"},
  {name: "Tajikistan",            iso_3166_1_alpha_2: "TJ"},
  {name: "Tanzania",              iso_3166_1_alpha_2: "TZ"},
  {name: "Thailand",              iso_3166_1_alpha_2: "TH"},
  {name: "Timor-Lest",            iso_3166_1_alpha_2: "TL"},
  {name: "Togo",                  iso_3166_1_alpha_2: "TG"},
  {name: "Tokelau",               iso_3166_1_alpha_2: "TK"},
  {name: "Tonga",                 iso_3166_1_alpha_2: "TO"},
  {name: "Trinidad and Tobago",   iso_3166_1_alpha_2: "TT"},
  {name: "Tunisia",               iso_3166_1_alpha_2: "TN"},
  {name: "Turkey",                iso_3166_1_alpha_2: "TR"},
  {name: "Turkmenistan",          iso_3166_1_alpha_2: "TM"},
  {name: "Turks and Caicos Islands", iso_3166_1_alpha_2: "TC"},
  {name: "Tuvalu",                iso_3166_1_alpha_2: "TV"},
  {name: "Uganda",                iso_3166_1_alpha_2: "UG"},
  {name: "Ukraine",               iso_3166_1_alpha_2: "UA"},
  {name: "United Arab Emirates",  iso_3166_1_alpha_2: "AE"},
  {name: "United Kingdom",        iso_3166_1_alpha_2: "GB"},
  {name: "United States",         iso_3166_1_alpha_2: "US"},
  {name: "United States Minor Outlying Islands", iso_3166_1_alpha_2: "UM"},
  {name: "Uruguay",               iso_3166_1_alpha_2: "UY"},
  {name: "Uzbekistan",            iso_3166_1_alpha_2: "UZ"},
  {name: "Vanuatu",               iso_3166_1_alpha_2: "VU"},
  {name: "Venezuela",             iso_3166_1_alpha_2: "VE"},
  {name: "Vietnam",               iso_3166_1_alpha_2: "VN"},
  {name: "Virgin Islands, British", iso_3166_1_alpha_2: "VG"},
  {name: "Virgin Islands, U.S.",  iso_3166_1_alpha_2: "VI"},
  {name: "Wallis and Futuna",     iso_3166_1_alpha_2: "WF"},
  {name: "Western Sahara",        iso_3166_1_alpha_2: "EH"},
  {name: "Yemen",                 iso_3166_1_alpha_2: "YE"},
  {name: "Zambia",                iso_3166_1_alpha_2: "ZM"},
  {name: "Zimbabwe",              iso_3166_1_alpha_2: "ZW"},
]

countries.each do |c|
  Country.create!(name: c[:name], iso_3166_1_alpha_2: c[:iso_3166_1_alpha_2], slug: c[:name].parameterize)
end

austria = Country.find_by(name: "Austria")
france = Country.find_by(name: "France")
italy = Country.find_by(name: "Italy")
united_kingdom = Country.find_by(name: "United Kingdom")
switzerland = Country.find_by(name: "Switzerland")

france.holiday_type_brochures.build(holiday_type: ski_holidays)
france.save!

switzerland.holiday_type_brochures.build(holiday_type: ski_holidays)
switzerland.save!

admin = Role.create!(
  name: "Administrator",
  admin: true,
  select_on_signup: false,
  flag_new_development: true,
  has_a_website: true
)

property_owner = Role.create!(
  name: "Property owner",
  admin: false,
  select_on_signup: true,
  advertises_generally: false,
  advertises_properties_for_rent: true,
  advertises_properties_for_sale: true,
  flag_new_development: false,
  has_a_website: false
)

estate_agent = Role.create!(
  name: "Estate agent",
  admin: false,
  select_on_signup: true,
  advertises_properties_for_rent: true,
  advertises_properties_for_sale: true,
  flag_new_development: true,
  has_a_website: true
)

letting_agent = Role.create!(
  name: "Letting agent",
  admin: false,
  select_on_signup: true,
  flag_new_development: false,
  has_a_website: true
)

property_developer = Role.create!(
  name: "Property developer",
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
  name: "Other business",
  admin: false,
  select_on_signup: true,
  advertises_generally: true,
  advertises_properties_for_rent: false,
  advertises_properties_for_sale: false,
  flag_new_development: false,
  has_a_website: true
)

advertiser = Role.create!(
  name: "Advertiser",
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
  first_name: "Alice",
  last_name: "Adams",
  email: "alice@mychaletfinder.com",
  password: "secret",
  billing_street: "1, High St",
  billing_city: "Portsmouth",
  billing_country: united_kingdom,
  terms_and_conditions: true,
  description: "",
  role: admin,
  phone: "+441234567890"
)
bob = User.create!(
  first_name: "Bob",
  last_name: "Brown",
  email: "bob@mychaletfinder.com",
  password: "secret",
  billing_street: "2, Main Rd",
  billing_city: "Newcastle",
  billing_country: united_kingdom,
  terms_and_conditions: true,
  description: "",
  role: property_developer,
  phone: "+441234567890"
)
interhome = User.create!(
  first_name: "Interhome",
  last_name: "Interhome",
  email: "interhome@mychaletfinder.com",
  password: "secret",
  billing_street: "1, High St",
  billing_city: "Portsmouth",
  billing_country: united_kingdom,
  terms_and_conditions: true,
  description: "",
  role: estate_agent,
  phone: "+441234567890"
)
trip_advisor = User.create!(
  first_name: "TripAdvisor",
  last_name: "TripAdvisor",
  email: "tripadvisor@mychaletfinder.com",
  password: "secret",
  billing_street: "1, High St",
  billing_city: "Portsmouth",
  billing_country: united_kingdom,
  terms_and_conditions: true,
  description: "",
  role: estate_agent,
  phone: "+441234567890"
)

# Regions

rhone_alpes = Region.create!(country: france, name: "Rhône Alpes", slug: "rhone-alpes")
rhone_alpes.holiday_type_brochures.build(holiday_type: ski_holidays)
rhone_alpes.save!

les_3_vallees = Region.create!(
  country: france,
  name: "Les 3 Vallees",
  slug: "les-3-vallees",
  featured: true,
  image_url: "/ski-regions/les-3-vallees/saint-martin-de-belleville.jpg",
  logo_url: "/ski-regions/les-3-vallees/logo.png",
  logo_title: "Les 3 Vallees",
  logo_alt: "Les 3 Vallees",
  info: STATIC[:regions][:les_3_vallees][:overview]
)
les_3_vallees.holiday_type_brochures.build(holiday_type: ski_holidays)
les_3_vallees.save!

portes_du_soleil = Region.create!(
  country: france,
  name: "Portes du Soleil",
  slug: "portes-du-soleil",
  featured: true,
  image_url: "/ski-regions/portes-du-soleil/champery-portes-du-soleil.jpg"
)
portes_du_soleil.holiday_type_brochures.build(holiday_type: ski_holidays)
portes_du_soleil.save!

paradiski = Region.create!(
  country: france,
  name: "Paradiski",
  slug: "paradiski",
  featured: true,
  image_url: "/ski-regions/paradiski/paradiski-les-arcs-2000-mychaletfinder.jpg"
)
paradiski.holiday_type_brochures.build(holiday_type: ski_holidays)
paradiski.save!

french_pyrenees = Region.create!(
  country: france,
  name: "French Pyrenees",
  slug: "french-pyrenees",
  featured: true,
  image_url: "/ski-regions/french-pyrenees/saint-lary-ski-area.jpg"
)
french_pyrenees.holiday_type_brochures.build(holiday_type: ski_holidays)
french_pyrenees.save!

espace_diamant = Region.create!(
  country: france,
  name: "Espace Diamant",
  slug: "espace-diamant",
  featured: true,
  image_url: "/ski-regions/espace-diamant/espace-diamant-ski-in-ski-out-chalet.jpg"
)
espace_diamant.holiday_type_brochures.build(holiday_type: ski_holidays)
espace_diamant.save!

evasion_mont_blanc = Region.create!(
  country: france,
  name: "Evasion Mont Blanc",
  slug: "evasion-mont-blanc",
  featured: true,
  image_url: "/ski-regions/evasion-mont-blanc/evasion-mont-blanc-megeve.jpg"
)
evasion_mont_blanc.holiday_type_brochures.build(holiday_type: ski_holidays)
evasion_mont_blanc.save!

bernese_oberland = Region.create!(
  country: switzerland,
  name: "Bernese Oberland",
  slug: "bernese-oberland",
  info: STATIC[:regions][:bernese_oberland]
)
bernese_oberland.holiday_type_brochures.build(holiday_type: ski_holidays)
bernese_oberland.save!

valais = Region.create!(
  country: switzerland,
  name: "Valais",
  slug: "valais",
  info: STATIC[:regions][:valais]
)
valais.holiday_type_brochures.build(holiday_type: ski_holidays)
valais.save!

val_di_fassa = Region.create!(
  country: italy,
  name: "Val di Fassa",
  slug: "val-di-fassa",
  info: STATIC[:regions][:val_di_fassa]
)

val_di_fassa.holiday_type_brochures.build(holiday_type: ski_holidays)
val_di_fassa.save!

htgt = rhone_alpes.create_page("how-to-get-there")
htgt.content = "<p>How to get to Rhône Alpes...</p>"
htgt.save

# Resorts
Resort.create!([
  {country: austria, name: "Alpbach", slug: "alphach"},
  {country: austria, name: "Bad Gastein",  slug: "bad-gastein"},
  {country: austria, name: "St Anton",     slug: "st-anton"},
  {country: austria, name: "Tyrol",        slug: "tyrol"},
  {country: austria, name: "Westendorf",   slug: "westendorf"},
  {country: france,  name: "Avoriaz",      slug: "avoriaz"},
  {country: france,  name: "Bernex",       slug: "bernex"},
  {country: france,  name: "La Tania",     slug: "la-tania"},
  {country: france,  name: "Les Houches",  slug: "les-houches", visible: true},
  {country: france,  name: "Morzine",      slug: "morzine"},
  {country: italy,   name: "Cervinia",     slug: "cervinia"},
  {country: italy,   name: "Dolomites",    slug: "dolomites"},
  {country: italy,   name: "Italian Alps", slug: "italian-alps"},
])

verbier_st_bernard = Resort.create!(country: switzerland, name: "Verbier St-Bernard", info: "", altitude_m: 1500, top_lift_m: 3300, piste_length_km: 410, visible: true, black: 10, red: 55, blue: 35, green: 2, longest_run_km: 15, drags: 46, chair: 24, gondola: 10, cable_car: 5, funicular: 0, railways: 0, slope_direction: "N,S,E,W", snowboard_parks: 3, mountain_restaurants: 14, glacier_skiing: true, creche: true, babysitting_services: true, featured: false, introduction: STATIC[:resorts][:verbier_st_island][:introduction], season: "Winter & Summer", beginner: 4, intermediate: 5, off_piste: 5, expert: 5, heli_skiing: true, summer_skiing: false, family: 4, visiting: STATIC[:resorts][:verbier_st_island][:guide], apres_ski: "Sophisticated, lively", gallery_content: "<h1>Seasonal Photos of Verbier<span></span></h1>", piste_map_content: STATIC[:resorts][:verbier_st_island][:piste_map], region: valais, slug: "verbier-st-bernard")
verbier_st_bernard.holiday_type_brochures.build(holiday_type: ski_holidays)
verbier_st_bernard.save!

chamonix = Resort.create!(country: france, name: "Chamonix",
                          slug: "chamonix",
                          piste_map_content: STATIC[:resorts][:chamonix][:piste_map],
                          altitude_m: 1035,
                          top_lift_m: 3842,
                          piste_length_km: 550,
                          visible: true,
                          info: "Chamonix, with a population of approximately 10,000, is a world famous resort and was the location of the first winter Olympics in 1924.",
                          for_rent_count: 25,
                          for_sale_count: 5,
                          region: rhone_alpes,
                          image_url: "/resorts/chamonix/ski-holidays-chamonix-r1-mychaletfinder.jpg")

chamonix.holiday_type_brochures.build(holiday_type: ski_holidays)
chamonix.save!

chamonix.create_page("how-to-get-there")

les_houches = Resort.find_by(slug: "les-houches")
les_houches.holiday_type_brochures.build(holiday_type: ski_holidays)
les_houches.save!

Airport.destroy_all
geneva = Airport.create!(name: "Geneva", code: "GVA", country: france)
grenoble = Airport.create!(name: "Grenoble", code: "GNB", country: france)
AirportDistance.create!([
  {airport: geneva, resort: chamonix, distance_km: 90},
  {airport: grenoble, resort: chamonix, distance_km: 255},
])

bars = Category.create!(name: "Bars")

Category.create!([
  {name: "Restaurants"},
  {name: "Nightclubs"},
  {name: "Babysitters"},
  {name: "Child Clubs"},
  {name: "Car Hire"},
  {name: "Mountain Guides"},
  {name: "Estate Agents"},
  {name: "Lawyers"},
])

def random_image
  Image.new.tap do |img|
    n = rand(1..30)
    img.image = File.open("test-files/properties/chalet#{n}.jpg", "rb")
    img.save!
  end
end

def assign_property_images(property)
  num = rand(5..14)
  num.times { property.images << random_image }
  property.image = property.images.first
  property.save
end

images = []
(1..50).each do |i|
  img = Image.new
  n = ((i - 1) % 30) + 1
  img.image = File.open("test-files/properties/chalet#{n}.jpg", "rb")
  img.save!
  images[i] = img
end

PropertyBasePrice.create!(number_of_months: 12, price: 150)

TripAdvisorLocation.delete_all

TripAdvisorLocation.create!([
  {id: 6, name: "Africa", location_type: "continent"},
  {id: 293_808, name: "Madagascar", location_type: "country", parent_id: 6},
])

trip_advisor_chamonix = TripAdvisorLocation.create!(
  name: "Chamonix",
  resort: chamonix,
  location_type: "town"
)

trip_advisor_property = TripAdvisorProperty.create!(
  review_average: 4.5,
  trip_advisor_location: trip_advisor_chamonix,
  starting_price: 1400,
  currency: euros,
  min_stay_low: 2,
  min_stay_high: 7,
  sleeps: 9,
  title: "TA Prop"
)

chalet_bibendum = Property.create!(
  address: "123 street",
  balcony: true,
  currency: euros,
  description: "Stylish and sophisticated, Radisson Blu Edinburgh is located " \
    "on the historic Royal Mile in the heart of the city. Popular " \
    "attractions such as Edinburgh Castle, Holyrood Palace and Edinburgh " \
    "Vaults are within walking distance. Each of the 238 elegant bedrooms " \
    "and suites offer modern...",
  disabled: true,
  latitude: 51.509865, longitude: -0.118092,
  listing_type: Property::LISTING_TYPE_FOR_RENT,
  name: "Chalet Bibendum",
  number_of_bathrooms: 1,
  number_of_bedrooms: 3,
  publicly_visible: true,
  resort: chamonix,
  sauna: true,
  sleeping_capacity: 8,
  tv: Property::TV_FREEVIEW,
  user: alice,
  weekly_rent_price: 1350,
  wifi: true
)

assign_property_images(chalet_bibendum)

new_development = Property.create!(
  address: "45 Rue",
  balcony: true,
  currency: euros,
  description: "Imagine the stunning location, in the heart of the authentic " \
    "village of Les Houches, just 7kms from the centre of Chamonix and all " \
    "under the gaze of the snow capped Mont Blanc. It is in this exceptional " \
    "setting, that our love affair with the Chamonix Valley continues with " \
    'the creation of "Chalets Delys" our new outright purchase development.',
  latitude: 51.509865, longitude: -0.118092,
  listing_type: Property::LISTING_TYPE_FOR_SALE,
  name: "Chalet Delys",
  new_development: true,
  number_of_bathrooms: 1,
  number_of_bedrooms: 3,
  publicly_visible: true,
  resort: chamonix,
  sleeping_capacity: 8,
  user: alice
)

assign_property_images(new_development)

properties = Property.create!([
  {resort: chamonix, user: alice, name: "Alpen Lounge", address: "123 street", sleeping_capacity: 6, weekly_rent_price: 1750, currency: euros, image: images[1], listing_type: Property::LISTING_TYPE_FOR_RENT, publicly_visible: true, layout: "Showcase", latitude: 51.509865, longitude: -0.018092},
  {resort: chamonix, user: alice, name: "Apartment Teracce", address: "123 street", sleeping_capacity: 8, weekly_rent_price: 2000, currency: euros, image:  images[2], listing_type: Property::LISTING_TYPE_FOR_RENT, publicly_visible: true, latitude: 51.619865, longitude: -0.118092},
  {resort: chamonix, user: alice, name: "Brigitte's Mazot",  address: "123 street", sleeping_capacity: 2, weekly_rent_price: 1825, currency: euros, image:  images[3], listing_type: Property::LISTING_TYPE_FOR_RENT, publicly_visible: true, latitude: 51.72865, longitude: -0.218092},
  {resort: chamonix, user: alice, name: "Chalet Alaska",     address: "123 street", sleeping_capacity: 5, weekly_rent_price: 1950, currency: euros, image:  images[4], listing_type: Property::LISTING_TYPE_FOR_RENT, publicly_visible: true, latitude: 51.839865, longitude: -0.318092},
  {resort: chamonix, user: alice, name: "Chalet Anchorage",  address: "123 street", sleeping_capacity: 10, weekly_rent_price: 1650, currency: euros, image:  images[5], listing_type: Property::LISTING_TYPE_FOR_RENT, publicly_visible: true, latitude: 51.949865, longitude: -0.448092},
  {resort: chamonix, user: alice, name: "Chalet Arkle",      address: "123 street", sleeping_capacity: 14, weekly_rent_price: 1725, currency: euros, image:  images[6], listing_type: Property::LISTING_TYPE_FOR_RENT, publicly_visible: true, latitude: 51.159865, longitude: -0.518092},
  {resort: chamonix, user: alice, name: "Chalet Azimuth",    address: "123 street", sleeping_capacity: 8, weekly_rent_price: 2150, currency: euros, image:  images[7], listing_type: Property::LISTING_TYPE_FOR_RENT, publicly_visible: true, latitude: 51.269865, longitude: -0.618092},
  {resort: chamonix, user: alice, name: "Chalet Bornian",    address: "123 street", sleeping_capacity: 8, weekly_rent_price: 1400, currency: euros, image:  images[9], listing_type: Property::LISTING_TYPE_FOR_RENT, publicly_visible: true, latitude: 51.379865, longitude: -0.718092},
  {resort: chamonix, user: alice, name: "Chalet Chachat",    address: "123 street", sleeping_capacity: 14, weekly_rent_price: 1500, currency: euros, image: images[10], listing_type: Property::LISTING_TYPE_FOR_RENT, publicly_visible: true, latitude: 51.489865, longitude: -0.818092},
  {resort: chamonix, user: alice, name: "Chalet Cachemire",  address: "123 street", sleeping_capacity: 20, weekly_rent_price: 1375, currency: euros, image: images[11], listing_type: Property::LISTING_TYPE_FOR_RENT, publicly_visible: true, latitude: 51.599865, longitude: -0.918092},
  {resort: chamonix, user: alice, name: "Chalet Chardonnet", address: "123 street", sleeping_capacity: 8, weekly_rent_price: 2000, currency: euros, image: images[12], listing_type: Property::LISTING_TYPE_FOR_RENT, publicly_visible: true, latitude: 52.009865, longitude: -1.018092},
  {resort: chamonix, user: alice, name: "Chalet Chintalaya", address: "123 street", sleeping_capacity: 10, weekly_rent_price: 1475, currency: euros, image: images[13], listing_type: Property::LISTING_TYPE_FOR_RENT, publicly_visible: true, latitude: 52.119865, longitude: -1.118092},
  {resort: chamonix, user: alice, name: "Chalet Chosalet",   address: "123 street", sleeping_capacity: 8, weekly_rent_price: 2025, currency: euros, image: images[14], listing_type: Property::LISTING_TYPE_FOR_RENT, publicly_visible: true, latitude: 52.229865, longitude: -1.218092},
  {resort: chamonix, user: alice, name: "Chalet D'Or",       address: "123 street", sleeping_capacity: 8, weekly_rent_price: 1550, currency: euros, image: images[15], listing_type: Property::LISTING_TYPE_FOR_RENT, publicly_visible: true, latitude: 52.339865, longitude: -1.318092},
  {resort: chamonix, user: alice, name: "Chalet des Sapins", address: "123 street", sleeping_capacity: 10, weekly_rent_price: 1650, currency: euros, image: images[16], listing_type: Property::LISTING_TYPE_FOR_RENT, publicly_visible: true, latitude: 52.449865, longitude: -1.418092},
  {resort: chamonix, user: alice, name: "Chalet des Isles",  address: "123 street", sleeping_capacity: 12, weekly_rent_price: 1850, currency: euros, image: images[17], listing_type: Property::LISTING_TYPE_FOR_RENT, publicly_visible: true, latitude: 52.559865, longitude: -1.518092},
  {resort: chamonix, user: alice, name: "Chalet des Islouts", address: "123 street", sleeping_capacity: 8, weekly_rent_price: 1550, currency: euros, image: images[18], listing_type: Property::LISTING_TYPE_FOR_RENT, publicly_visible: true, latitude: 52.669865, longitude: -1.618092},
  {resort: chamonix, user: alice, name: "Chalet Dubrulle",   address: "123 street", sleeping_capacity: 11, weekly_rent_price: 1575, currency: euros, image: images[19], listing_type: Property::LISTING_TYPE_FOR_RENT, publicly_visible: true, latitude: 52.779865, longitude: -1.718092},
  {resort: chamonix, user: alice, name: "Chalet Eco-Farm",   address: "123 street", sleeping_capacity: 10, weekly_rent_price: 2100, currency: euros, image: images[20], listing_type: Property::LISTING_TYPE_FOR_RENT, publicly_visible: true, latitude: 52.889865, longitude: -1.818092},
  {resort: chamonix, user: alice, name: "Chalet Edelweiss",  address: "123 street", sleeping_capacity: 12, weekly_rent_price: 1900, currency: euros, image: images[21], listing_type: Property::LISTING_TYPE_FOR_RENT, publicly_visible: true, latitude: 52.999865, longitude: -1.918092},
  {resort: chamonix, user: alice, name: "Chalet Eftikhia", address: "123 street", sleeping_capacity: 10, weekly_rent_price: 1600, currency: euros, image: images[22], listing_type: Property::LISTING_TYPE_FOR_RENT, publicly_visible: true, latitude: 53.709865, longitude: -2.118092},
  {resort: chamonix, user: alice, name: "Chalet Flegere",    address: "123 street", sleeping_capacity: 10, weekly_rent_price: 1700, currency: euros, image: images[23], listing_type: Property::LISTING_TYPE_FOR_RENT, publicly_visible: true, latitude: 53.819865, longitude: -2.218092},
  {resort: chamonix, user: alice, name: "Chalet Gauthier",   address: "123 street", sleeping_capacity: 16, weekly_rent_price: 1600, currency: euros, image: images[24], listing_type: Property::LISTING_TYPE_FOR_RENT, publicly_visible: true, latitude: 53.929865, longitude: -2.318092},
  {resort: chamonix, user: alice, name: "Les Citronniers",   address: "123 street", sleeping_capacity: 8, weekly_rent_price: 1450, currency: euros, image: images[25], listing_type: Property::LISTING_TYPE_FOR_RENT, publicly_visible: true, latitude: 53.339865, longitude: -2.418092},
  {resort: chamonix, user: alice, name: "Chalet Grassonnets", address: "123 street", sleeping_capacity: 8, weekly_rent_price: 1300, currency: euros, image: images[26], listing_type: Property::LISTING_TYPE_FOR_SALE, publicly_visible: true, layout: "Showcase", latitude: 53.049865, longitude: -2.518092},
  {resort: chamonix, user: alice, name: "Chalet Guapa",      address: "123 street", sleeping_capacity: 8, weekly_rent_price: 1800, currency: euros, image: images[27], listing_type: Property::LISTING_TYPE_FOR_SALE, publicly_visible: true, latitude: 54.159865, longitude: -3.118092},
  {resort: chamonix, user: alice, name: "Chalet Ibex",       address: "123 street", sleeping_capacity: 10, weekly_rent_price: 1925, currency: euros, image: images[28], listing_type: Property::LISTING_TYPE_FOR_SALE, publicly_visible: true, latitude: 54.369865, longitude: -3.218092},
  {resort: chamonix, user: alice, name: "Chalet Jomain",     address: "123 street", sleeping_capacity: 18, weekly_rent_price: 2050, currency: euros, image: images[29], listing_type: Property::LISTING_TYPE_FOR_SALE, publicly_visible: true, latitude: 55.779865, longitude: -4.118092},
])

a_trip_advisor_chalet = Property.create!(
  resort: chamonix, user: trip_advisor, name: "A TripAdvisor Chalet",
  address: "On a mountain", sleeping_capacity: 9, number_of_bedrooms: 6,
  number_of_bathrooms: 2, weekly_rent_price: 1400, currency: euros,
  image: images[30], listing_type: Property::LISTING_TYPE_FOR_RENT,
  publicly_visible: true, trip_advisor_property: trip_advisor_property,
  description: "This amazing chalet..."
)

a_trip_advisor_chalet.amenities << Amenity.create(name: "BBQ")
a_trip_advisor_chalet.amenities << Amenity.create(name: "IRON")
a_trip_advisor_chalet.amenities << Amenity.create(name: "FRIDGE")
a_trip_advisor_chalet.amenities << Amenity.create(name: "AIR_CONDITIONING")
a_trip_advisor_chalet.amenities << Amenity.create(name: "DRYER")
a_trip_advisor_chalet.amenities << Amenity.create(name: "DVD")
a_trip_advisor_chalet.amenities << Amenity.create(name: "INTERNET_ACCESS")
a_trip_advisor_chalet.amenities << Amenity.create(name: "MICROWAVE")
a_trip_advisor_chalet.amenities << Amenity.create(name: "PARKING")
a_trip_advisor_chalet.amenities << Amenity.create(name: "SATELLITE_TV")
a_trip_advisor_chalet.amenities << Amenity.create(name: "TV")
a_trip_advisor_chalet.amenities << Amenity.create(name: "WASHING_MACHINE")
a_trip_advisor_chalet.amenities << Amenity.create(name: "STOVE")
a_trip_advisor_chalet.amenities << Amenity.create(name: "DECK")
a_trip_advisor_chalet.amenities << Amenity.create(name: "WATERFRONT")

a_trip_advisor_chalet.reviews << Review.create!(
  author_location: "Bergheim, France",
  author_name: "Laetitia P",
  content: "Connu sous le nom de Chalet des Ayes, nous y avons trouvé notre bonheur. Nous sommes la même bande d'ami(e)s qui partons quasiment tous les ans à Pâques, pour le WE, bande qui s'est agrandie avec les conjoints et les enfants au fil des années. Nous avons loué le chalet 26 (18 personnes) et 21 (7 personnes) à un prix correct. Les chalets sont beaux et bien agencés (draps fournis) et équipés  (juste un problème avec le lave vaisselle et le four que nous avons signalé). Sur place, une grande aire de jeux, une salle d'accueil avec un bar en libre service  (bière, café, sirop et pâte à crêpes!), magazines, table de ping-pong, baby-foot et quelques tables ou s'installer. Terrain de tennis, de pétanque. Piscine et jacuzzi intérieur. Piste de bowling. Piscine extérieure en saison  (tout est gratuit mais sur réservation pour les locataires). Haras tout près  (le Closel) pour faire une balade à cheval  (18€/personne). Boulangerie et Intermarche à 5 minutes en voiture. Bref, un paradis pour les enfants et les parents ! Je recommande vivement. ",
  property: a_trip_advisor_chalet,
  rating: 5,
  title: "Super!",
  visited_on: Date.new(2017, 4, 1)
)

properties << a_trip_advisor_chalet

properties.each_with_index do |property, index|
  images[index + 1].property = property
  images[index + 1].save!
end

InterhomeAccommodation.destroy_all
interhome_accommodation = InterhomeAccommodation.create!(
  accommodation_type: "T",
  bathrooms: 0,
  bedrooms: 2,
  brand: 0,
  code: "CH1912.712.1",
  country: "FR",
  details: "",
  features: "shower,hikingmountains,bbq",
  floor: 0,
  geodata_lat: "66.073845",
  geodata_lng: "28.929323",
  name: "Holiday House Voltaire",
  pax: 10,
  permalink: "ch1912-712-1",
  place: "1234",
  quality: 3,
  region: "1",
  rooms: 3,
  sqm: 10,
  themes: "FAMILY,IN A LAKESIDE TOWN,LAKES AND MOUNTAINS",
  toilets: 1,
  zip: "ZIP"
)
interhome_property = Property.create!(
  resort: chamonix,
  user: alice,
  name: "Holiday House Voltaire",
  address: "123 street",
  sleeping_capacity: 8,
  weekly_rent_price: 1500,
  currency: euros,
  image_id: 30,
  listing_type: Property::LISTING_TYPE_FOR_RENT,
  publicly_visible: true,
  interhome_accommodation_id: interhome_accommodation.id,
  image: images[31]
)
40.downto(31).each { |i| interhome_property.images << images[i] }

InterhomeVacancy.destroy_all
InterhomeVacancy.create!(
  accommodation_code: "CH1912.712.1",
  availability: "YYYYYYYYYNNNNNNNNNNNNNNYYNNNNNNNYYYYYYYYYYYYNNNNNNNYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYNNNNNNNYYYYYYYNNNNNNNYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYY",
  changeover: "CCCCCCCOOOXXXXXXXXXXXXXXOOXXXXXXICCCCCOOOOOOOXXXXXXICCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCXXXXXXOXXXXXXIOOOOOOOXXXXXXICCCCCCCCCCCCCCCCCCCCCXXXXXXCXXXXXXCXXXXXXCXXXXXXCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCXXXXXXCXXXXXXCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCXXXXXXCXXXXXXCXXXXXXCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCOOOOOOO",
  flexbooking: "YYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYNNNNNNNNNNNNNNYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYNNNNNNNNNNNNNNNNNNNNNNNNNNNNYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYNNNNNNNNNNNNNNYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYNNNNNNNNNNNNNNNNNNNNNNYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYY",
  interhome_accommodation_id: interhome_accommodation.id,
  minstay: "CCCCCCCCCCCCCCCGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGG",
  startday: Date.today
)

DirectoryAdvert.destroy_all

directory_advert = DirectoryAdvert.new(
  category_id: bars.id,
  resort_id: chamonix.id,
  business_name: "My Business",
  business_address: "123 Street",
  strapline: "Awesome"
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
  phone: "+44.1234567890",
  status: Order::PAYMENT_RECEIVED,
  total: 50,
  currency: gbps
)

Payment.create!(
  order: order,
  service_provider: "WorldPay",
  amount: "50"
)

Enquiry.create!(user: bob, name: "Carol", email: "carol@example.org", phone: "01234 567890")
