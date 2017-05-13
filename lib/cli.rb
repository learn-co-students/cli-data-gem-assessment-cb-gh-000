require_relative "scraper"
require_relative "headline"
require_relative "article"

class Cli

  HEADLINES_URL = "https://www.usatoday.com/news/"
  ARTICLES_URL = "https://www.usatoday.com"

  def self.run
    puts "USA Today"
    show_and_read
  end

  def self.refresh_headlines
    headlines_array = Scraper.scrap_headlines(HEADLINES_URL)
    Headline.create_from_collection(headlines_array)
  end

  def self.display_headlines
    Headline.display_chunk
  end

  def self.display_article(index)
    article_url = Headline.get_article_url_at_index(index)
    article_data = Scraper.scrap_article(ARTICLES_URL+article_url)
    Article.new(article_data).display
  end

  def self.refresh(reset = false)
    Headline.reset if reset
    refresh_headlines
    display_headlines
  end

  def self.show_and_read
    input = ""
    refresh

    until input == "q" do
      puts "\nType an article number to read more, s to show headlines, r to refresh, and q to quit.\n"
      input = gets.chomp
      if input.to_i.to_s == input
        display_article(input.to_i)
      elsif input == 'r' || input == 's'
        refresh(input == 'r')
      end
    end
  end
end
