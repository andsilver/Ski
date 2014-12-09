# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Image.destroy_all
Page.destroy_all
HolidayType.destroy_all
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

website = Website.create!

CarouselSlide.delete_all
CarouselSlide.create!([
  { caption: '<p>Ski Holidays</p><p>A wide choice of international<br>ski resorts around the world</p>', link: '/holidays/ski-holidays', image_url: '/images/home/sh-home.png' },
  { caption: '<p>City Breaks</p><p>All year round destinations – <br>explore something new</p>', link: '/holidays/city-breaks', image_url: '/images/home/ex-slider.png' },
  { caption: '<p>Summer Villas</p><p>A great choice from the blue seas of <br>the Amalfi Coast to the Florida Keys</p>', link: '/holidays/summer-villas', image_url: '/images/home/sv-home.png' },
  { caption: '<p>Lakes & Mountains<p><p>Beautiful lakeside resorts in picture <br>postcard settings</p>', link: '/holidays/lakes-and-mountains', image_url: '/images/home/lm-home.png' }
])

Page.create!([
  { path: '/pages/about', title: 'About' }
])

ski_holidays = HolidayType.create!(name: 'Ski Holidays', slug: 'ski-holidays')
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
  select_on_signup: false
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
  email: 'bob@mychaletfider.com',
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
flip_key = User.create!(
  first_name: 'FlipKey',
  last_name: 'FlipKey',
  email: 'flipkey@mychaletfinder.com',
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
les_houches.hotel_count = 1
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
(1..30).each do |i|
  img = Image.new
  img.image = File.open("test-files/properties/chalet#{i}.jpg", 'rb')
  img.save!
  images[i] = img
end

img = Image.new
img.image = File.open("test-files/properties/hotel1.jpg", 'rb')
img.save!
images[31] = img

PropertyBasePrice.create!(number_of_months: 12, price: 150)

properties = Property.create!([
  { resort: chamonix, user: alice, name: "Alpen Lounge",      address: '123 street', sleeping_capacity: 6,   metres_from_lift: 2500, weekly_rent_price: 1750, currency: euros, image:  images[1], listing_type: Property::LISTING_TYPE_FOR_RENT, publicly_visible: true },
  { resort: chamonix, user: alice, name: "Apartment Teracce", address: '123 street', sleeping_capacity: 8,   metres_from_lift: 4700, weekly_rent_price: 2000, currency: euros, image:  images[2], listing_type: Property::LISTING_TYPE_FOR_RENT, publicly_visible: true },
  { resort: chamonix, user: alice, name: "Brigitte's Mazot",  address: '123 street', sleeping_capacity: 2,   metres_from_lift: 3100, weekly_rent_price: 1825, currency: euros, image:  images[3], listing_type: Property::LISTING_TYPE_FOR_RENT, publicly_visible: true },
  { resort: chamonix, user: alice, name: "Chalet Alaska",     address: '123 street', sleeping_capacity: 5,   metres_from_lift: 8300, weekly_rent_price: 1950, currency: euros, image:  images[4], listing_type: Property::LISTING_TYPE_FOR_RENT, publicly_visible: true },
  { resort: chamonix, user: alice, name: "Chalet Anchorage",  address: '123 street', sleeping_capacity: 10,  metres_from_lift: 5000, weekly_rent_price: 1650, currency: euros, image:  images[5], listing_type: Property::LISTING_TYPE_FOR_RENT, publicly_visible: true },
  { resort: chamonix, user: alice, name: "Chalet Arkle",      address: '123 street', sleeping_capacity: 14,  metres_from_lift: 4000, weekly_rent_price: 1725, currency: euros, image:  images[6], listing_type: Property::LISTING_TYPE_FOR_RENT, publicly_visible: true },
  { resort: chamonix, user: alice, name: "Chalet Azimuth",    address: '123 street', sleeping_capacity: 8,   metres_from_lift: 6300, weekly_rent_price: 2150, currency: euros, image:  images[7], listing_type: Property::LISTING_TYPE_FOR_RENT, publicly_visible: true },
  { resort: chamonix, user: alice, name: "Chalet Bibendum",   address: '123 street', sleeping_capacity: 8,   metres_from_lift: 5500, weekly_rent_price: 1350, currency: euros, image:  images[8], listing_type: Property::LISTING_TYPE_FOR_RENT, publicly_visible: true },
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
  { resort: chamonix, user: alice, name: "Chalet Grassonnets", address: '123 street', sleeping_capacity: 8,  metres_from_lift: 3500, weekly_rent_price: 1300, currency: euros, image: images[26], listing_type: Property::LISTING_TYPE_FOR_SALE, publicly_visible: true },
  { resort: chamonix, user: alice, name: "Chalet Guapa",      address: '123 street', sleeping_capacity: 8,   metres_from_lift: 4500, weekly_rent_price: 1800, currency: euros, image: images[27], listing_type: Property::LISTING_TYPE_FOR_SALE, publicly_visible: true },
  { resort: chamonix, user: alice, name: "Chalet Ibex",       address: '123 street', sleeping_capacity: 10,  metres_from_lift: 5600, weekly_rent_price: 1925, currency: euros, image: images[28], listing_type: Property::LISTING_TYPE_FOR_SALE, publicly_visible: true },
  { resort: chamonix, user: alice, name: "Chalet Jomain",     address: '123 street', sleeping_capacity: 18,  metres_from_lift: 10200, weekly_rent_price: 2050, currency: euros, image: images[29], listing_type: Property::LISTING_TYPE_FOR_SALE, publicly_visible: true },
  { resort: chamonix, user: alice, name: "Chalet Kushi",      address: '123 street', sleeping_capacity: 8,   metres_from_lift: 9800, weekly_rent_price: 1500, currency: euros, image: images[30], listing_type: Property::LISTING_TYPE_FOR_SALE, publicly_visible: true }
  ])

hotel = Property.create!({
  resort: les_houches,
  user: alice,
  name: 'Les Granges d’en Haut',
  address: 'Route des Chavants, 74310 Les Houches',
  sleeping_capacity: 100,
  metres_from_lift: 1000,
  weekly_rent_price: 1050,
  currency: euros,
  image: images[31],
  listing_type: Property::LISTING_TYPE_HOTEL,
  publicly_visible: true
})

31.downto(21).each {|i| hotel.images << images[i]}

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
  interhome_accommodation_id: interhome_accommodation.id
)

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

les_citronniers = PvAccommodation.create!(
  property: Property.find_by(name: 'Les Citronniers'),
  name: 'Les Citronniers',
  code: '01L',
  iso_3166_1: 'FR',
  iso_3166_2: 'FR-06',
  onu: 'FR-NCE',
  address_1: '17, rue Partouneaux',
  address_2: '',
  town: 'MENTON',
  postcode: '06500',
  latitude: '43.77880000',
  longitude: '7.50567000',
  price_table_url: 'http://www.pv-holidays.com/gb-en/tabprice/?code=01L&season=SUMMER&currencyCode=EUR',
  permalink: '01L'
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

FlipKeyLocation.delete_all

FlipKeyLocation.create!(id: 1, rgt: nil, parent_path: '1', parent_id: nil, name: 'Earth', lft: nil, property_count: 0)
# These ones can probably be imported from the data provided by FlipKey:
FlipKeyLocation.create!(id: 2, rgt: 21787, parent_path: '1,2', parent_id: 1, name: 'Asia', lft: 2, property_count: 8459)
FlipKeyLocation.create!(id: 4, rgt: 170697, parent_path: '1,4', parent_id: 1, name: 'Europe', lft: 21788, property_count: 120983)
FlipKeyLocation.create!(id: 6, rgt: 178249, parent_path: '1,6', parent_id: 1, name: 'Africa', lft: 170698, property_count: 2894)
FlipKeyLocation.create!(id: 8, rgt: 188135, parent_path: '1,8', parent_id: 1, name: 'Australia & South Pacific', lft: 178250, property_count: 3369)
FlipKeyLocation.create!(id: 13, rgt: 204273, parent_path: '1,13', parent_id: 1, name: 'South America', lft: 188202, property_count: 5679)
FlipKeyLocation.create!(id: 21, rgt: 206263, parent_path: '1,24', parent_id: 1, name: 'Middle East', lft: 204276, property_count: 1529)
FlipKeyLocation.create!(id: 191, rgt: 272593, parent_path: '1,191', parent_id: 1, name: 'USA', lft: 206264, property_count: 123423)
