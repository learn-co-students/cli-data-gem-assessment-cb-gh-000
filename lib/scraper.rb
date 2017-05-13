require 'open-uri'
require 'nokogiri'

class Scraper

  private
  def self.get_page_html(url)
    Nokogiri::HTML(open(url))
  end

  def self.scrap_headlines(url)
    headlines_array = []

    page_html = self.get_page_html(url)
    headlines_html = page_html.css('.headline-collection .headline-page li a:not([href*=videos])')

    headlines_html.each do |headline|
      headlines_array << {
        title: headline.css('[itemprop=headline]:first').text,
        excerpt: headline.css('[itemprop=headline] + span').text,
        meta: {
          section: headline.css('[itemprop=articleSection]').text,
          date: headline.css('[itemprop=datePublished]').text.gsub("\u00C2\u00A0", " ")
        },
        url: headline.attr('href')
      }
    end
    headlines_array
  end

  def self.scrap_article(url)
    page_html = self.get_page_html(url)

    content = page_html.css("[itemprop=articleBody] > p").inject("") do |all, paragraph|
      all = all +"\n\n"+paragraph
    end

    {
      title: page_html.css("[itemprop=headline]").text,
      content: content,
      meta: {
        author: page_html.css("[rel=author]").text,
        date: page_html.css(".asset-metabar-time").text
      }
    }
  end

end




# Scraper.scrap_headlines("https://www.usatoday.com/news/")
# article = Scraper.scrap_article("https://www.usatoday.com/story/news/nation-now/2017/05/13/creation-museum-researcher-sues-feds-over-grand-canyon-permit/320900001/")
# puts article[:content]
