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
          <h1 class="home">Ski Chalet Rentals</h1>
          <p>Welcome to MyChaletFinder, the ultimate ski holiday rental website for mountain enthusiasts.</p>
          <br>
          <p>Book your ski chalet, cabin, condo or lodge today and enjoy the freedom,</p>
          <p>flexibility and space to do what you want, when you want - home from home.</p>
          <br>
          <br>
        </div>

      	<div id="featured-properties">
          <h2>Popular ski holiday destinations</h2>
          <div class="preview-layout">
            <a class="preview-item" href="/resorts/st-anton/properties/rent">
              <img src="/assets/home/st_anton_austria.png">
              <div class="overlay">
                <h3 class="title">ST ANTON AUSTRIA</h3>
              </div>
            </a>
            <a class="preview-item" href="/regions/ziller-valley/properties/rent">
              <img src="/assets/home/ziller_valley_austria.png">
              <div class="overlay">
                <h3 class="title">ZILLER VALLEY AUSTRIA</h3>
                <div class="description">(81 PROPERTIES)</div>
              </div>
            </a>
            <a class="preview-item" href="/resorts/ruka-kuusamo/properties/rent">
              <img src="/assets/home/ruka_kuusamo_finland.png">
              <div class="overlay">
                <h3 class="title">RUKA-KUUSAMO FINLAND</h3>
              </div>
            </a>
            <a class="preview-item" href="/resorts/chamonix/properties/rent">
              <img src="/assets/home/chamonix_france.png">
              <div class="overlay">
                <h3 class="title">CHAMONIX FRANCE</h3>
              </div>
            </a>
            <a class="preview-item" href="/resorts/verbier-st-bernard/properties/rent">
              <img src="/assets/home/verbier_switzerland.png">
              <div class="overlay">
                <h3 class="title">VERBIER Switzerland</h3>
              </div>
            </a>
            <a class="preview-item" href="/resorts/lenk/properties/rent">
              <img src="/assets/home/lenk_switzerland.png">
              <div class="overlay">
                <h3 class="title">LENK Switzerland</h3>
              </div>
            </a>
            <a class="preview-item" href="/resorts/bormio/properties/rent">
              <img src="/assets/home/bormio_italy.png">
              <div class="overlay">
                <h3 class="title">BORMIO Italy</h3>
              </div>
            </a>
            <a class="preview-item" href="/resorts/canazei/properties/rent">
              <img src="/assets/home/canazei_italy.png">
              <div class="overlay">
                <h3 class="title">CANAZEI Italy</h3>
              </div>
            </a>
            <a class="preview-item" href="/resorts/salen/properties/rent">
              <img src="/assets/home/salen_sweden.png">
              <div class="overlay">
                <h3 class="title">SALEN Sweden</h3>
              </div>
            </a>
          </div>
        </div>
        <br>
        <br>
        <div id="list-properties">
          <p>
            <img alt="" src="/assets/marker-blue-6ab58c513405cdba0d8e092cda36219911a882653a9822f9559a58ade5d375f3.svg">
          </p>
          <h2>List your Ski Chalet</h2>
          <br>
          <p>Ski holiday rentals are getting more popular with travellers from families to adventurers.</p>
          <p>List your chalet on MyChaletFinder today!</p>
          <br>
          <br>
          <a class="button action-button" href="/welcome/advertiser">List your property</a>
        </div>
        <br>
        <br>
        <br>
        <br>
        <div id="ski-holiday-experiences">
          <h2>Ski Holiday Experiences</h2>
          <div class="preview-layout">
            <a class="preview-item" href="/pages/heli-skiing">
              <img src="/assets/home/heli-skiing.png">
              <div class="overlay">
                <h3 class="title">HELI-SKIING</h3>
              </div>
            </a>
            <a class="preview-item" href="/pages/lapland-ski-holidays">
              <img src="/assets/home/northern-lights-lapland-mychaletfinder.jpg">
              <div class="overlay">
                <h3 class="title">Lapland Ski Holidays</h3>
              </div>
            </a>
            <a class="preview-item" href="/holidays/spa-resorts">
              <img src="/assets/home/spa_wellbeing.png">
              <div class="overlay">
                <h3 class="title">SPA & WELLBEING</h3>
              </div>
            </a>
            <a class="preview-item" href="/pages/best-ski-tours-alps">
              <img src="/assets/home/ski_tours.png">
              <div class="overlay">
                <h3 class="title">SKI TOURS</h3>
              </div>
            </a>
            <a class="preview-item" href="/pages/beginner-ski-resorts">
              <img src="/assets/home/beginner_resorts.png">
              <div class="overlay">
                <h3 class="title">BEGINNER RESORTS</h3>
              </div>
            </a>
            <a class="preview-item" href="/pages/best-christmas-markets-ski-resorts">
              <img src="/assets/home/eco_friendly.png">
              <div class="overlay">
                <h3 class="title">Christmas Markets</h3>
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
  {
    path: '/pages/about',
    title: 'About'
  },
  {
    path: '/resorts/chamonix/properties/rent',
    title: 'Chamonix Chalets & Apartments to Rent | Chamonix Holiday Rental Accommodation',
    description: 'Looking for a Chamonix chalet or apartment? Over 100 self catering holiday rental chalets and apartments to choose from for all budgets and tastes for your ski or summer holidays - enquire or book online',
    keywords: 'chamonix chalets, accommodation in chamonix, chalet rentals in chamonix, chamonix holiday rentals , chamonix vacation rentals, apartments for rent in chamonix, luxury chamonix chalets, hot tubs, ski-in, ski-out, mychaletfinder',
    header_snippet_name: 'intersport',
    content: <<~EOF
      <h1>Chamonix Chalets
      <span>Holiday Rentals - Ski Chalets, Apartments &amp; Holiday Homes For Rent, Chamonix</span>
      </h1>
      
      <p>Mychaletfinder has the perfect <strong>Chamonix chalet</strong> for you to rent for your 
        summer or ski holidays. Chamonix is a world famous all year round ski resort providing some of the most challenging
      off-piste terrain around whilst catering equally as well for absolute beginners. Summer is 
      even busier with hikers and mountain bikers who come to explore the high alpine trails. A wonderful town
      to visit any time of year.</p>
      
      <p>Staying in <strong>Chamonix holiday rentals</strong>, whether ski chalet or apartment, is
      ideal for families, groups and friends. Self catering holiday accommodation provides the freedom, flexibility and space to 
      do what you want, when you you want - home from home.</p>
      <br>
      <br>
      <br>
      EOF
  },
  {
    path: '/pages/heli-skiing-in-greenland',
    title: 'Greenland Heli-skiing | Ski Tours Kangaamiut, Greenland',
    content: <<~EOF
    <div class="wide clear-fix experience-details">
    <div>
        <div class="page-description">
            <img src="/assets/home/maniitsoq-heli-skiing.jpg" alt="" width="100%">
            <br>
            <br>
            <br>
            <h1>Greenland Heli-skiing and Ski Tours</h1>
            <h2>Wild & remote - Spectacular Scenery, Icebergs, Glaciers and Fjords</h2>
            <br>
            <p>Everyone has heard of heli-skiing in Canada - afterall, it is the world's heli-skiing capital with around 80% of the market for this adrenaline fuelled sport. However,as the lesser known mountainous nations have started to promote their national assets ie mountains and ice, the areas often thought as being too remote are proving to be just as good and better value than the established players - Greenland, the world's largest island, is no exception.</p>
        </div>
        <div class="flex-layout content-space-between">
            <div class="flex-2">
                <img src="/assets/home/glacier-skiing-greenland.jpg" alt="" width="100%">
            </div>
            <div class="flex-2">
                <p>Some of the best heli-skiing can be found on the many islands surrounding Greenland's huge coastline. These regions often have the deepest fjords with many permanently covered by glacial ice. On some of the decents, you can ski from the drop-off point, right the way down to the waters edge - something you won't experience when heli-skiing in the Alps.</p>
                <br>
                <h2>Greenland - facts & figures</h2>
                <div style="border-top: 1px solid #ececec; padding: 24px 0;">
                    <table style="width: 100%">
                        <tbody>
                            <tr>
                                <td class="row-divided" style="width: 50%;">Heli skiing main season</td>
                                <td class="row-divided">April to Mid May</td>
                            <tr>
                                <td class="row-divided">Northern Lights</td>
                                <td class="row-divided">Dec to March</td>
                            </tr>
                            <tr>
                                <td class="row-divided">Midnight Sun</td>
                                <td class="row-divided">Mid May to the end of July</td>
                            </tr>
                            <tr>
                                <td class="row-divided">Capital</td>
                                <td class="row-divided">Nuuk</td>
                            </tr>
                            <tr>
                                <td class="row-divided">Currency</td>
                                <td class="row-divided">Danish Kroner</td>
                            </tr>
                            <tr>
                                <td class="row-divided">Time (Nuuk)</td>
                                <td class="row-divided">GMT -3 hours</td>
                            </tr>
                            <tr>
                                <td class="row-divided">More info</td>
                                <td class="row-divided">www.greenland.com</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <br>
        <p style="text-align: center">
            When deciding on a heli-skiing adventure in Greenland, you have a choice of several areas each having its own unique characteristics. And, if you are planning on visiting several areas on your heli-skiing trip, its worth noting that the roads end where a city or town perimeter ends. After that, its snow, ice, mountains and fjords so transport is by boat, plane or helicopter.
        </p>
    </div>
    <br>
    <br>
    <br>
    <br>
    <div>
        <ul id="tabs">
            <li><a id="tab1">OVERVIEW</a></li>
            <li><a id="tab2">OPERATORS</a></li>
        </ul>
        <div class="tab-container" id="tab1C">
            <div class="flex-layout">
                <div class="flex-2">
                    <p>With fjords and glaciers everywhere, the scenery is spectacular and being north of the Arctic Circle means long days from April onwards - which coincides with the start of the heli-skiing season!</p>
                    <br>
                    <p>The north slopes offer powder whilst south facing slopes deliver spring com snow. The terrain is varied from short stepp couloirs to traversing across mighty glaciers with many runs ending up at the beach!</p>
                    <br>
                    <div>
                        <h3>GETTING THERE</h3>
                        <h4>From Denmark</h4>
                        <p>Air Greenland flies all year around from Copenhagen to Kangerlussuaq in West Greenland and to Narsarsuaq in South Greenland  (summer). The flight time to either city is just 4.5 hours.</p>
                        <h4>From Iceland</h4>
                        <p>Air Iceland (not to be confused with Icelandair) flies from Reykjavik to Kulusuk and Nerlerit Inaat on Greenland's east coast. Kulusuk is served twice a week in the winter season and every day during the summer.</p>
                        <h4>From Canada</h4>
                        <p>Air Greenland flies between Nuuk and Iqaluit in Canada. From Iqaluit, there are same-day connections to all major cities throughout Canada including Ottawa, Vancouver, St. John's and Goose Bay.</p>
                    </div>
                </div>
                <div class="flex-2" style="font-size: 14px">
                    <div class="preview-map" style="width:100%; height: 250px;"></div>
                    <br>
                    <br>
                    <iframe src="https://www.meteoblue.com/en/weather/widget/daily/nuuk_greenland_3421319?days=5&amp;tempunit=CELSIUS&amp;windunit=MILE_PER_HOUR&amp;pictoicon=0&amp;pictoicon=1&amp;maxtemperature=0&amp;maxtemperature=1&amp;mintemperature=0&amp;mintemperature=1&amp;windspeed=0&amp;windgust=0&amp;winddirection=0&amp;uv=0&amp;humidity=0&amp;precipitation=0&amp;precipitation=1&amp;precipitationprobability=0&amp;spot=0&amp;pressure=0&amp;layout=light" scrolling="NO" allowtransparency="true" style="width: 100%;height:300px"></iframe>
                    <br>
                    <div style="color: #000">GREENLAND EXPERIENCES</div>
                    <br>
                    <div>SNOWMOBILE SAFARI</div>
                    <br>
                    <div>MOUNTAIN BIKING ON THE ICE CAP</div>
                    <br>
                    <div>NORDIC SKIING</div>
                    <br>
                    <div>ICE FISHING</div>
                    <br>
                    <div>EXPLORING THE FJORDS BY KAYAK</div>
                    <br>
                    <div>DOG SLEDGING</div>
                </div>
            </div>
            <div>
                <h3>Adventures</h3>
                <div class="flex-layout">
                    <div class="flex-2">
                        <p>And when you are not heli-skiing, there are are many natural wonders everywhere from the fjords and icebergs to the amazing northern lights (from Dec to March). Also possible on down days, if the weather is too bad for the helicopter, you can try...</p>
                        <ul style="list-style: inherit; padding-left: 18px;">
                            <li><p>Snowmobile safari</p></li>
                            <li><p>Mountain biking on the ice cap</p></li>
                            <li><p>Nordic skiing</p></li>
                            <li><p>Ice fishing</p></li>
                            <li><p>Exploring the fjords by kayak</p></li>
                            <li><p>Dog sledding</p></li>
                        </ul>
                    </div>
                    <div class="flex-2">
                        <img src="/assets/home/greenland-mountain-biking-ice-cap-6.jpg" alt="src" width="100%">
                    </div>
                </div>
            </div>
        </div>
        <div class="tab-container" id="tab2C">
            <h1 style="text-align: center">Greenland heli Skiing.com</h1>
            <br>
            <br>
            <div class="flex-layout">
                <div class="flex-2">
                    <p>Come ski the wild terrain of West Greenland. With 2000m runs to the fjord''s edge, deep powder and corn snow, our heli-skiing trps give you the experience of a life time.</p>
                    <br>
                    <p>We base our tours 60km north of Maniitsoq, in the tiny village of Kangaamiut, where we stay in rented accommodation and experience life as the locals do.</p>
                    <br>
                    <p>Heli-skiing options are virtually unlimited with literally hundreds of glacier runs down to the fjords.</p>
                    <br>
                    <p>And just in case the weather is against us, we swap the helicopter for touring skis and explore the terrain on other islands via our boat.</p>
                </div>
                <div class="flex-2">
                    <div style="color: #000">PACKAGE FEATURES</div>
                    <div style="border-top: 1px solid #ececec; border-bottom: 1px solid #ececec; padding: 24px 0; margin:24px 0">
                        <table>
                            <tbody>
                                <tr >
                                    <td style="width: 167px;">BASE</td>
                                    <td><p>Kangaamuit Island</p></td>
                                <tr>
                                    <td>ACTIVITIES</td>
                                    <td><p>Heli-ski and Ski Touring</p></td>
                                </tr>
                                <tr>
                                    <td>DURATION</td>
                                    <td><p>1 week</p></td>
                                </tr>
                                <tr>
                                    <td>MEALS</td>
                                    <td><p>All inclusive</p></td>
                                </tr>
                                <tr>
                                    <td>FITNESS RATING</td>
                                    <td><p>3/5</p></td>
                                </tr>
                                <tr>
                                    <td>SKILL LEAVEL</td>
                                    <td><p>Good off-piste</p></td>
                                </tr>
                                <tr>
                                    <td>MAX VERTICLE</td>
                                    <td><p>2000m</p></td>
                                </tr>
                                <tr>
                                    <td>HELI-TIME</td>
                                    <td><p>6 hours</p></td>
                                </tr>
                                <tr>
                                    <td>TRIP SIZE</td>
                                    <td><p>12 people</p></td>
                                </tr>
                                <tr>
                                    <td>GROUPS</td>
                                    <td><p>3 groups of 4 with 3 guides</p></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <div>
                        <a class="button action-button" href="http://www.greenlandheliskiing.com/Greenland_Heli_Skiing.html" style="padding: 1rem 5rem">ENQUIRE</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <br>
    <h2 style="text-align: center">G R E E N L A N D</h2>
    <br>
    <br>
    <ul class="experience-slide">
        <li>
            <img src="/assets/home/greenland-glacier-5.jpg" alt="">
        </li>
        <li>
            <img src="/assets/home/greenland-iceberg-sunset-4jpg.jpg" alt="">
        </li>
        <li>
            <img src="/assets/home/greenland-northern-lights-1.jpg" alt="">
        </li>
    </ul>
    <br>
    <br>
    <div>
        <div>
            <h1>Maniitsoq</h1>
            <div class="flex-layout">
            <div class="flex-2">
                <p>Maniitsoq is an archipelago of islands, glaciers and fjords on the South West side of Greenland.</p>
                <br>
                <p>There is huge variety and quality of terrain with drop-offs from the top of the Ice Cap to the beach! Adam peak on the edge of Eternity Fjord is the highest mountain in the area at 2000m and together with the other heli-ski drop-off points, give vertical decents ranging from 600 to 1500m.</p>
                <h2>Getting there</h2>
                <p>Fly to Kangerlussuaq International and then take the 40 minute flight to Maniitsoq.</p>
            </div>
            <div class="flex-2">
                <img src="/assets/home/maniitsoq-heli-skiing-ledge12.jpg" alt="" width="100%">
            </div>
            </div>
        </div>
        <br>
        <div>
            <h1>Kangaamiut</h1>
            <div class="flex-layout">
            <div class="flex-2">
                <p>Kangaamiut is a tiny island off the west coast and is used as a base for the heli-skiing operators. The area is packed with literally hundreds of glacial runs with 2000m decents that end up at the edge of the 3 fjords that surround this remote island.</p>
                <br>
                <p>If you like "remote", this is probably as good as it gets without visiting the polar ice caps!</p>
                <h2>Getting there</h2>
                <p>The closest domestic airport is Maniitsoq which is just 50km away. However, there are no roads to Kangaamiut from Maniitsoq so you can either catch a boat or take a helicopter to the island. If you are travelling on a tour, the onwards transpot from Maniitsoq airport will be provided.</p>
            </div>
            <div class="flex-2">
                <img src="/assets/home/kangaamiut-heli-skiing-greenland.jpg" alt="" width="100%">
            </div>
            </div>
        </div>
        <br>
        <div>
            <h1>Kulusuk</h1>
            <div class="flex-layout">
            <div class="flex-2">
                <p>Kulusuk is the gateway to the East coast. Its a small settlement in the Ammassalik region of Greenland built on a rocky island typically surrounded by fjords and mountains! From the top of the local Isikajia Mountain at 300m, you can see the huge icebergs that normally surround the island and beyond in to the Danish Straits.</p>
                <h2>Getting there</h2>
                <p>Kulusuk airport is just 40 minutes flying time from Kangerlussuaq International. Alternatively, its about a 2 hour flight from the capital, Nuuk.</p>
            </div>
            <div class="flex-2">
                <img src="/assets/home/kusuluk-panorama-9.jpg" alt="" width="100%">
            </div>
            </div>
        </div>
        <br>
        <div>
            <h1>Uummannaq</h1>
            <div class="flex-layout">
            <div class="flex-2">
                <p>Uummannaq is a small village of nearly 1300 residents on an island 500km north of the Arctic Circle. Being so far north, daylight hours in the peak winter months are minimal. However, from mid May to mid August, its the complete opposite with the Midnight Sun from mid May to the end of July. This means heli-skiing is possible nearly 24 hours a day and there is nothing better than skiing virgin snow under an orange sky!</p>
                <br>
                <p>One of the best places for heli-skiing is on the Sernersuaq glacier on the Nuussuaqq peninsula.</p>
                <h2>Getting there</h2>
                <p>From Kangerlussuaq International airport, catch a flight to Qaarsut and from there, its a 10 minute ride in a helicopter or you can drive.</p>
            </div>
            <div class="flex-2">
                <img src="/assets/home/uummannaq-heli-skiing-11.jpg" alt="" width="100%">
            </div>
            </div>
        </div>
    </div>
    <div class="page-description">
        <br>
        <h1>Other Operators</h1>
        <br>
        <div class="preview-layout content-center">
            <a class="preview-item" href="/pages/lapland-ski-holidays">
            <img src="/assets/home/northern-lights-lapland-mychaletfinder.jpg">
            <div class="overlay">
                <h3 class="title">SKI PRO KYRGYZSTAN</h3>
            </div>
            </a>
            <a class="preview-item" href="/holidays/spa-resorts">
            <img src="/assets/home/spa_wellbeing.png">
            <div class="overlay">
                <h3 class="title">HELI-SPORT ADVENTURES</h3>
            </div>
            </a>
        </div>
    </div>
</div>
<script>
    $('.preview-map').mapify({
        zoom: 5,
        responsive: true,
        center: {
            lat: 65.825511,
            lng: -53.343690,
        },
        points: [{
            lat: 65.825511,
            lng: -53.343690,
            marker: true
        }]
    });

    $('.experience-slide').partialViewSlider({
      width: 50,
      controls: true,
      controlsPosition: 'inside',
      backdrop: true,
      dots: false
    });
</script>
    EOF
  }
])

Page.create!(
  path: '/pages/heli-skiing',
  title: 'Heli-skiing',
  header_snippet_name: 'search',
  content: <<~EOF
    <div class="wide clear-fix">
      <div class="page-description">
        <h1>Heli-skiing, the ultimate adrenaline rush</h1>
        <br>
        <p>Heli-skiing - the ultimate ride, with untracked pristine powder snow, no lift queues,</p>
        <p>spectacular vistas and the adrenaline rush of a lifetime.</p>
        <br>
        <p>Bored of the pistes? not enough challenge? weel, if you get the opportunity, try heli-skiing,</p>
        <p>it's an experience you'll never forget. There are some very interesting places around</p>
        <p>the world to try out heli-skiing such as the , Greeland and even the high glacial basin of the</p>
        <p>Annapurna Sanctuary in Nepal.</p>
        <br>
        <p>However, these areas tend to be for the die hard heli-skiers and boarders as</p>
        <p>there are very few with ski resorts to return back to!</p>
        <br>
        <p>In this article, we feature some of the best places outside of Europe to go heli-skiing including</p>
        <p>those remote areas where there is not a ski resort in sight! From the Atlas mountains of Morocco, </p>
        <p>Tien Shan mountains in Central Asia and Kashmir in India to the frozen lands of Alaska and </p>
        <p>Greenland, heli-skiing takes you on an adrenalin trip you wont forget!</p>
        <br>
        <p>The resorts feaured below are just examples of what you can expect when heli-skiing in a particular region.<p>
        <p>For further information on the best locations for heli-skiing and the operators who organise the package holidays,</p>
        <p>please click on the "more information" buttons.</p>
      </div>

      <div class="page-description">
        <h2>Popular heli-skiing destinations</h2>
        <div class="preview-layout">
          <a class="preview-item" href="/pages/heli-skiing-in-greenland">
            <img src="/assets/home/st_anton_austria.png">
            <div class="overlay">
              <h3 class="title">KANNGAAMUIT GREENLAND</h3>
            </div>
          </a>
          <a class="preview-item" href="/regions/ziller-valley/properties/rent">
            <img src="/assets/home/ziller_valley_austria.png">
            <div class="overlay">
              <h3 class="title">TIEN SHAN MOUNTAINS KYRGYZSTAN</h3>
            </div>
          </a>
          <a class="preview-item" href="/resorts/ruka-kuusamo/properties/rent">
            <img src="/assets/home/ruka_kuusamo_finland.png">
            <div class="overlay">
              <h3 class="title">WHISTLER, BLACKCOMB CANADA</h3>
            </div>
          </a>
          <a class="preview-item" href="/resorts/chamonix/properties/rent">
            <img src="/assets/home/chamonix_france.png">
            <div class="overlay">
              <h3 class="title">OUKAIMEDEN MOROCCO</h3>
            </div>
          </a>
          <a class="preview-item" href="/resorts/verbier-st-bernard/properties/rent">
            <img src="/assets/home/verbier_switzerland.png">
            <div class="overlay">
              <h3 class="title">GULMARG, KASHMIR INDIA</h3>
            </div>
          </a>
          <a class="preview-item" href="/resorts/lenk/properties/rent">
            <img src="/assets/home/lenk_switzerland.png">
            <div class="overlay">
              <h3 class="title">AOSTA VALLEY ITALY</h3>
            </div>
          </a>
        </div>
      </div>
      <br>
      <br>
      <div class="page-description">
        <p>
          <img alt="" src="/assets/marker-blue-6ab58c513405cdba0d8e092cda36219911a882653a9822f9559a58ade5d375f3.svg">
        </p>
        <h2>List your Ski Chalet</h2>
        <br>
        <p>Ski holiday rentals are getting more popular with travellers from families to adventurers.</p>
        <p>List your chalet on MyChaletFinder today!</p>
        <br>
        <br>
        <a class="button action-button" href="/welcome/advertiser">List your property</a>
      </div>
      <br>
      <br>
      <br>
      <br>
      <div class="page-description">
        <h2>Other Ski Holiday Experiences</h2>
        <div class="preview-layout">
          <a class="preview-item" href="/pages/heli-skiing">
            <img src="/assets/home/heli-skiing.png">
            <div class="overlay">
              <h3 class="title">HELI-SKIING</h3>
            </div>
          </a>
          <a class="preview-item" href="/pages/lapland-ski-holidays">
            <img src="/assets/home/northern-lights-lapland-mychaletfinder.jpg">
            <div class="overlay">
              <h3 class="title">Lapland Ski Holidays</h3>
            </div>
          </a>
          <a class="preview-item" href="/holidays/spa-resorts">
            <img src="/assets/home/spa_wellbeing.png">
            <div class="overlay">
              <h3 class="title">SPA & WELLBEING</h3>
            </div>
          </a>
          <a class="preview-item" href="/pages/best-ski-tours-alps">
            <img src="/assets/home/ski_tours.png">
            <div class="overlay">
              <h3 class="title">SKI TOURS</h3>
            </div>
          </a>
          <a class="preview-item" href="/pages/beginner-ski-resorts">
            <img src="/assets/home/beginner_resorts.png">
            <div class="overlay">
              <h3 class="title">BEGINNER RESORTS</h3>
            </div>
          </a>
          <a class="preview-item" href="/pages/best-christmas-markets-ski-resorts">
            <img src="/assets/home/eco_friendly.png">
            <div class="overlay">
              <h3 class="title">Christmas Markets</h3>
            </div>
          </a>
        </div>
      </div>
    </div>
  EOF
)

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
  <p>Some of the hottest villas, condo residences and apartments on the market are in the ever popular Cote dAzur in
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
  name: 'Ski Holidays in...',
  slug: 'ski-holidays',
  mega_menu_html: '
    <li><a href="/countries/france/holidays/ski-holidays">France</a></li>
    <li><a href="/countries/switzerland/holidays/ski-holidays">Switzerland</a></li>
    <li><a href="/countries/austria/holidays/ski-holidays">Austria</a></li>
    <li><a href="/countries/united-states/holidays/ski-holidays">United States</a></li>
    <li><a href="/countries/canada/holidays/ski-holidays">Canada</a></li>
    <li><a href="/countries/united-kingdom/holidays/ski-holidays">United Kingdom</a></li>
    <li><a href="/countries/norway/holidays/ski-holidays">Norway</a></li>
    <li><a href="/countries/finland/holidays/ski-holidays">Finland</a></li>
    <li><a href="/countries/andora/holidays/ski-holidays">Andora</a></li>
    <li><a href="/countries/germany/holidays/ski-holidays">Germany</a></li>'
)
besk_ski_resorts = HolidayType.create!(
  name: 'Besk Ski Resorts for...',
  slug: 'best-ski-resorts',
  mega_menu_html: '
    <li><a href="/pages/best-christmas-markets-ski-resorts">Christmas Markets</a></li>
    <li><a href="/pages/christmas-ski-holidays">Skiing at Christmas</a></li>
    <li><a href="/pages/best-ski-tours-alps">Ski Touring</a></li>
    <li><a href="/pages/heli-skiing">Heli-Skiing</a></li>
    <li><a href="/pages/beginner-ski-resorts">Beginners</a></li>
    <li><a href="/pages/intermediate-ski-resorts">Intermediates</a></li>
    <li><a href="/pages/summer-skiing">Summer Skiing</a></li>
    <li><a href="/pages/ski-in-ski-out-ski-resorts-chalets">Ski-in, Ski-out Chalets</a></li>
    <li><a href="/pages/lapland-ski-holidays">Northern Lights</a></li>
    <li><a href="">Families</a></li>
    '
)
experiences = HolidayType.create!(
  name: 'Experiences',
  slug: 'experiences',
  mega_menu_html: '
    <li><a href="">Lapland Ski Resorts</a></li>
    <li><a href="">Ski Tours</a></li>
    <li><a href="">Eco Friendly</a></li>
    <li><a href="">Spa and Wellbeing</a></li>
    <li><a href="">Beginner Resorts</a></li>
    <li><a href="">Gastronomic Delights</a></li>
  ')
services = HolidayType.create!(
  name: 'Services',
  slug: 'services',
  mega_menu_html: '
    <li><a href="/pages/snow-reports-snow-forecasts">Snow Forecasts</a></li>
    <li><a href="/pages/ski-rentals-ski-hire">Ski Rental</a></li>
    <li><a href="/pages/airport-transfers">Airport Transfers</a></li>
    <li><a href="/pages/travel-insurance">Travel Insurance</a></li>
    <li><a href="/pages/car-hire-car-rentals">Car Hire</a></li>
    <li><a href="">Newsletters</a></li>
    <li><a href="/pages/fc-exchange">Foreign Exchange</a></li>
  '
)


currencies = [
  { name: 'Euro', unit: '€', pre: true, code: 'EUR', in_euros: 1    },
  { name: 'GBP',  unit: '£', pre: true, code: 'GBP', in_euros: 0.89 }
]
currencies.each do |c|
  Currency.create!(name: c[:name], unit: c[:unit], pre: c[:pre], code: c[:code], in_euros: c[:in_euros])
end
gbps = Currency.find_by(code: 'GBP')
euros = Currency.find_by(code: 'EUR')

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

def random_image
  Image.new.tap do |img|
    n = 1 + rand(30)
    img.image = File.open("test-files/properties/chalet#{n}.jpg", 'rb')
    img.save!
  end
end

def assign_property_images(property)
  num = 5 + rand(10)
  num.times { property.images << random_image }
  property.image = property.images.first
  property.save
end

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

chalet_bibendum = Property.create!(
  address: '123 street',
  balcony: true,
  currency: euros,
  description: 'Stylish and sophisticated, Radisson Blu Edinburgh is located ' \
    'on the historic Royal Mile in the heart of the city. Popular ' \
    'attractions such as Edinburgh Castle, Holyrood Palace and Edinburgh ' \
    'Vaults are within walking distance. Each of the 238 elegant bedrooms ' \
    'and suites offer modern...',
  disabled: true,
  latitude: 51.509865, longitude: -0.118092,
  listing_type: Property::LISTING_TYPE_FOR_RENT,
  metres_from_lift: 5500,
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
  address: '45 Rue',
  balcony: true,
  currency: euros,
  description: 'Imagine the stunning location, in the heart of the authentic ' \
    'village of Les Houches, just 7kms from the centre of Chamonix and all ' \
    'under the gaze of the snow capped Mont Blanc. It is in this exceptional ' \
    'setting, that our love affair with the Chamonix Valley continues with ' \
    'the creation of "Chalets Delys" our new outright purchase development.',
  latitude: 51.509865, longitude: -0.118092,
  listing_type: Property::LISTING_TYPE_FOR_SALE,
  metres_from_lift: 5500,
  name: 'Chalet Delys',
  new_development: true,
  number_of_bathrooms: 1,
  number_of_bedrooms: 3,
  publicly_visible: true,
  resort: chamonix,
  sleeping_capacity: 8,
  user: alice,
)

assign_property_images(new_development)

properties = Property.create!([
  { resort: chamonix, user: alice, name: "Alpen Lounge",      address: '123 street', sleeping_capacity: 6,   metres_from_lift: 2500, weekly_rent_price: 1750, currency: euros, image:  images[1], listing_type: Property::LISTING_TYPE_FOR_RENT, publicly_visible: true, layout: 'Showcase', latitude: 51.509865, longitude: -0.018092},
  { resort: chamonix, user: alice, name: "Apartment Teracce", address: '123 street', sleeping_capacity: 8,   metres_from_lift: 4700, weekly_rent_price: 2000, currency: euros, image:  images[2], listing_type: Property::LISTING_TYPE_FOR_RENT, publicly_visible: true, latitude: 51.619865, longitude: -0.118092 },
  { resort: chamonix, user: alice, name: "Brigitte's Mazot",  address: '123 street', sleeping_capacity: 2,   metres_from_lift: 3100, weekly_rent_price: 1825, currency: euros, image:  images[3], listing_type: Property::LISTING_TYPE_FOR_RENT, publicly_visible: true, latitude: 51.72865, longitude: -0.218092 },
  { resort: chamonix, user: alice, name: "Chalet Alaska",     address: '123 street', sleeping_capacity: 5,   metres_from_lift: 8300, weekly_rent_price: 1950, currency: euros, image:  images[4], listing_type: Property::LISTING_TYPE_FOR_RENT, publicly_visible: true, latitude: 51.839865, longitude: -0.318092 },
  { resort: chamonix, user: alice, name: "Chalet Anchorage",  address: '123 street', sleeping_capacity: 10,  metres_from_lift: 5000, weekly_rent_price: 1650, currency: euros, image:  images[5], listing_type: Property::LISTING_TYPE_FOR_RENT, publicly_visible: true, latitude: 51.949865, longitude: -0.448092 },
  { resort: chamonix, user: alice, name: "Chalet Arkle",      address: '123 street', sleeping_capacity: 14,  metres_from_lift: 4000, weekly_rent_price: 1725, currency: euros, image:  images[6], listing_type: Property::LISTING_TYPE_FOR_RENT, publicly_visible: true, latitude: 51.159865, longitude: -0.518092 },
  { resort: chamonix, user: alice, name: "Chalet Azimuth",    address: '123 street', sleeping_capacity: 8,   metres_from_lift: 6300, weekly_rent_price: 2150, currency: euros, image:  images[7], listing_type: Property::LISTING_TYPE_FOR_RENT, publicly_visible: true, latitude: 51.269865, longitude: -0.618092 },
  { resort: chamonix, user: alice, name: "Chalet Bornian",    address: '123 street', sleeping_capacity: 8,   metres_from_lift: 4400, weekly_rent_price: 1400, currency: euros, image:  images[9], listing_type: Property::LISTING_TYPE_FOR_RENT, publicly_visible: true, latitude: 51.379865, longitude: -0.718092 },
  { resort: chamonix, user: alice, name: "Chalet Chachat",    address: '123 street', sleeping_capacity: 14,  metres_from_lift: 3500, weekly_rent_price: 1500, currency: euros, image: images[10], listing_type: Property::LISTING_TYPE_FOR_RENT, publicly_visible: true, latitude: 51.489865, longitude: -0.818092 },
  { resort: chamonix, user: alice, name: "Chalet Cachemire",  address: '123 street', sleeping_capacity: 20,  metres_from_lift: 1400, weekly_rent_price: 1375, currency: euros, image: images[11], listing_type: Property::LISTING_TYPE_FOR_RENT, publicly_visible: true, latitude: 51.599865, longitude: -0.918092 },
  { resort: chamonix, user: alice, name: "Chalet Chardonnet", address: '123 street', sleeping_capacity: 8,   metres_from_lift: 9300, weekly_rent_price: 2000, currency: euros, image: images[12], listing_type: Property::LISTING_TYPE_FOR_RENT, publicly_visible: true, latitude: 52.009865, longitude: -1.018092 },
  { resort: chamonix, user: alice, name: "Chalet Chintalaya", address: '123 street', sleeping_capacity: 10,  metres_from_lift: 6500, weekly_rent_price: 1475, currency: euros, image: images[13], listing_type: Property::LISTING_TYPE_FOR_RENT, publicly_visible: true, latitude: 52.119865, longitude: -1.118092 },
  { resort: chamonix, user: alice, name: "Chalet Chosalet",   address: '123 street', sleeping_capacity: 8,   metres_from_lift: 5900, weekly_rent_price: 2025, currency: euros, image: images[14], listing_type: Property::LISTING_TYPE_FOR_RENT, publicly_visible: true, latitude: 52.229865, longitude: -1.218092 },
  { resort: chamonix, user: alice, name: "Chalet D'Or",       address: '123 street', sleeping_capacity: 8,   metres_from_lift: 6000, weekly_rent_price: 1550, currency: euros, image: images[15], listing_type: Property::LISTING_TYPE_FOR_RENT, publicly_visible: true, latitude: 52.339865, longitude: -1.318092 },
  { resort: chamonix, user: alice, name: "Chalet des Sapins", address: '123 street', sleeping_capacity: 10,  metres_from_lift: 4300, weekly_rent_price: 1650, currency: euros, image: images[16], listing_type: Property::LISTING_TYPE_FOR_RENT, publicly_visible: true, latitude: 52.449865, longitude: -1.418092 },
  { resort: chamonix, user: alice, name: "Chalet des Isles",  address: '123 street', sleeping_capacity: 12,  metres_from_lift: 2600, weekly_rent_price: 1850, currency: euros, image: images[17], listing_type: Property::LISTING_TYPE_FOR_RENT, publicly_visible: true, latitude: 52.559865, longitude: -1.518092 },
  { resort: chamonix, user: alice, name: "Chalet des Islouts", address: '123 street', sleeping_capacity: 8,  metres_from_lift: 8500, weekly_rent_price: 1550, currency: euros, image: images[18], listing_type: Property::LISTING_TYPE_FOR_RENT, publicly_visible: true, latitude: 52.669865, longitude: -1.618092 },
  { resort: chamonix, user: alice, name: "Chalet Dubrulle",   address: '123 street', sleeping_capacity: 11,  metres_from_lift: 5000, weekly_rent_price: 1575, currency: euros, image: images[19], listing_type: Property::LISTING_TYPE_FOR_RENT, publicly_visible: true, latitude: 52.779865, longitude: -1.718092 },
  { resort: chamonix, user: alice, name: "Chalet Eco-Farm",   address: '123 street', sleeping_capacity: 10,  metres_from_lift: 7200, weekly_rent_price: 2100, currency: euros, image: images[20], listing_type: Property::LISTING_TYPE_FOR_RENT, publicly_visible: true, latitude: 52.889865, longitude: -1.818092 },
  { resort: chamonix, user: alice, name: "Chalet Edelweiss",  address: '123 street', sleeping_capacity: 12,  metres_from_lift: 4200, weekly_rent_price: 1900, currency: euros, image: images[21], listing_type: Property::LISTING_TYPE_FOR_RENT, publicly_visible: true, latitude: 52.999865, longitude: -1.918092 },
  { resort: chamonix, user: alice, name: "Chalet Eftikhia" ,  address: '123 street', sleeping_capacity: 10,  metres_from_lift: 5900, weekly_rent_price: 1600, currency: euros, image: images[22], listing_type: Property::LISTING_TYPE_FOR_RENT, publicly_visible: true, latitude: 53.709865, longitude: -2.118092 },
  { resort: chamonix, user: alice, name: "Chalet Flegere",    address: '123 street', sleeping_capacity: 10,  metres_from_lift: 3400, weekly_rent_price: 1700, currency: euros, image: images[23], listing_type: Property::LISTING_TYPE_FOR_RENT, publicly_visible: true, latitude: 53.819865, longitude: -2.218092 },
  { resort: chamonix, user: alice, name: "Chalet Gauthier",   address: '123 street', sleeping_capacity: 16,  metres_from_lift: 4300, weekly_rent_price: 1600, currency: euros, image: images[24], listing_type: Property::LISTING_TYPE_FOR_RENT, publicly_visible: true, latitude: 53.929865, longitude: -2.318092 },
  { resort: chamonix, user: alice, name: "Les Citronniers",   address: '123 street', sleeping_capacity: 8,   metres_from_lift: 6800, weekly_rent_price: 1450, currency: euros, image: images[25], listing_type: Property::LISTING_TYPE_FOR_RENT, publicly_visible: true, latitude: 53.339865, longitude: -2.418092 },
  { resort: chamonix, user: alice, name: "Chalet Grassonnets", address: '123 street', sleeping_capacity: 8,  metres_from_lift: 3500, weekly_rent_price: 1300, currency: euros, image: images[26], listing_type: Property::LISTING_TYPE_FOR_SALE, publicly_visible: true, layout: 'Showcase', latitude: 53.049865, longitude: -2.518092 },
  { resort: chamonix, user: alice, name: "Chalet Guapa",      address: '123 street', sleeping_capacity: 8,   metres_from_lift: 4500, weekly_rent_price: 1800, currency: euros, image: images[27], listing_type: Property::LISTING_TYPE_FOR_SALE, publicly_visible: true, latitude: 54.159865, longitude: -3.118092 },
  { resort: chamonix, user: alice, name: "Chalet Ibex",       address: '123 street', sleeping_capacity: 10,  metres_from_lift: 5600, weekly_rent_price: 1925, currency: euros, image: images[28], listing_type: Property::LISTING_TYPE_FOR_SALE, publicly_visible: true, latitude: 54.369865, longitude: -3.218092 },
  { resort: chamonix, user: alice, name: "Chalet Jomain",     address: '123 street', sleeping_capacity: 18,  metres_from_lift: 10200, weekly_rent_price: 2050, currency: euros, image: images[29], listing_type: Property::LISTING_TYPE_FOR_SALE, publicly_visible: true, latitude: 55.779865, longitude: -4.118092 },
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

properties << a_trip_advisor_chalet

properties.each_with_index do |property, index|
  images[index + 1].property = property
  images[index + 1].save!
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
  total: 50,
  currency: gbps
)

Payment.create!(
  order: order,
  service_provider: 'WorldPay',
  amount: '50'
)

Enquiry.create!(user: bob, name: 'Carol', email: 'carol@example.org', phone: '01234 567890')
