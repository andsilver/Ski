xml.instruct! :xml, :version=>"1.0" 
xml.rss(:version=>"2.0"){
  xml.channel{
    xml.title("My Chalet Finder Blog")
    xml.link("http://en.mychaletfinder.com/")
    xml.description("Ski resorts and property news")
    xml.language('en-gb')
      for post in @blog_posts
        xml.item do
          xml.title(post.headline)
          xml.description{
            xml.cdata! md(post.content)
          }
          xml.author("My Chalet Finder")
          xml.pubDate(post.created_at.strftime("%a, %d %b %Y %H:%M:%S %z"))
          url = 'http://en.mychaletfinder.com/blog_articles/show/' + post.id.to_s
          xml.link(url)
          xml.guid(url)
        end
      end
  }
}
