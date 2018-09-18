namespace :temp do
  task test: :environment do
    agent = Mechanize.new
    agent.set_proxy "proxy.crawlera.com", 8010, '3b4921d4a6184afba4fa9064f0d21d79', ''

    (2..50).each do |index|
      url = "http://www.vzmz.com/vod-type-id-24-pg-#{index}.html"
      page = agent.get(url)
      puts 'grabbing list page...'
      puts url

      page_links = []
      page.parser.css("a.bk").each do |link|
        page_links << link['href'] if !page_links.include? link["href"]
      end

      page_links.each do |link|
        url = "http://www.vzmz.com" + link
        page = agent.get(url)
        puts 'grabbing detail page...'
        puts url

        name    = page.search('.infobox h1 span')[0].text
        publish = page.search('.infobox li').last.text.gsub('更新时间：', '')
        rate    = page.search('.poster span')[0].text.gsub('分', '')
        image   = page.search('.poster img')[0]['src']

        movie = Movie.where(name: name).first
        movie = Movie.create(name: name, publish: publish, rate: rate, cover: image) if !movie

        (1..10).each do |i|
          vlink = page.search("#vlink_#{i}")
          if vlink.count > 0
            download_link = 'http://www.vzmz.com/' + vlink[0].search("a")[0]["href"]
            Download.create(url: download_link, movie: movie) if Download.where(url: download_link).count == 0
          end
        end
      end
    end
  end

end