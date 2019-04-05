module RegionsHelper
  def region_select(resort)
    select(
      "resort", "region_id",
      resort.country.regions.collect {|r| [r.name, r.id] },
      {include_blank: "None"},
      class: "form-control"
    )
  end
end
