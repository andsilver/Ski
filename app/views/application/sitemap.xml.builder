xml.instruct! :xml, version: "1.0"
xml.urlset(:xmlns => "http://www.sitemaps.org/schemas/sitemap/0.9",
           "xmlns:xsi" => "http://www.w3.org/2001/XMLSchema-instance",
           "xsi:schemaLocation" => "http://www.sitemaps.org/schemas/sitemap/0.9 http://www.sitemaps.org/schemas/sitemap/0.9/sitemap.xsd") {
  @urls.each do |url|
    xml.url do
      xml.loc(url)
      xml.lastmod(Time.now.strftime("%Y-%m-%d"))
    end
  end
}
