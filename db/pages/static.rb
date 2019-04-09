# frozen_string_literal: true

module Static
  STATIC = {
    'website': File.read("db/pages/websites/main.html"),
    experiences: {
      heli_skiing: {
        main: File.read("db/pages/experiences/heli-skiing/main.html"),
        greenland: File.read("db/pages/experiences/heli-skiing/greenland.html"),
      },
    },
    countries: {
      france: {
        ski_holidays: File.read("db/pages/countries/france/ski_holidays.html"),
        ski_regions: File.read("db/pages/countries/france/ski_regions.html"),
        ski_resorts: File.read("db/pages/countries/france/ski_resorts.html"),
        transfer_times: File.read("db/pages/countries/france/transfer_times.html"),
      },
      swiss: {
        ski_holidays: File.read("db/pages/countries/swiss/ski_holidays.html"),
      },
    },
    holidays: {
      ski_holidays: File.read("db/pages/holidays/ski-holidays.html"),

    },
    regions: {
      bernese_oberland: File.read("db/pages/regions/bernese_oberland.html"),
      valais: File.read("db/pages/regions/valais.html"),
      val_di_fassa: File.read("db/pages/regions/val_di_fassa.html"),
      les_3_vallees: {
        overview: File.read("db/pages/regions/les_3_vallees/overview.html"),
        piste_map: File.read("db/pages/regions/les_3_vallees/piste_map.html"),
      },
    },
    resorts: {
      chamonix: {
        piste_map: File.read("db/pages/resorts/chamonix/piste_map.html"),
        rent: File.read("db/pages/resorts/chamonix/rent.html"),
        sale: File.read("db/pages/resorts/chamonix/sale.html"),
        summer_holiday: File.read("db/pages/resorts/chamonix/summer-holiday.html"),
        how_to_get_there: File.read("db/pages/resorts/chamonix/how-to-get-there.html"),
      },
      verbier_st_island: {
        guide: File.read("db/pages/resorts/verbier-st-island/guide.html"),
        introduction: File.read("db/pages/resorts/verbier-st-island/introduction.html"),
        piste_map: File.read("db/pages/resorts/verbier-st-island/piste-map.html"),
        ski_schools: File.read("db/pages/resorts/verbier-st-island/ski-schools.html"),
      },
    },
    properties: {
      sale: File.read("db/pages/properties/sale.html"),
    },
  }.freeze
end
