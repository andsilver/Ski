class Denormalize
  def self.denormalize
    Property.find_in_batches(batch_size: 250, include: [:resort]) do |properties|
      properties.each do |p|
        publicly_visible = p.currently_advertised? && p.resort.visible?
        country_id = p.resort.country_id
        if p.publicly_visible != publicly_visible || p.country_id != country_id
          p.publicly_visible = publicly_visible
          p.country_id = country_id
          p.save
        end
      end
      sleep(0.5)
    end
  end
end
