module CountriesHelper
  def country_select(object)
    select(
      object, "country_id",
      Country.order("name").collect {|c| [c.name, c.id] },
      {prompt: t("countries.select_country")},
      class: "form-control"
    )
  end
end
