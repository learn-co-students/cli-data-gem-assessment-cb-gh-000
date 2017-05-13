require_relative "meta"

class Headline

  attr_accessor :title, :excerpt, :source, :meta, :url

  @@all = []

  def initialize(data)
    add_headline_attributes(data)
    @@all << self
  end

  def add_headline_attributes(hash)
    hash.each do |key, value|
      if key == :meta
        self.send(("#{key}="), Meta.new(value))
      else
        self.send(("#{key}="), value)
      end
    end
  end

  def display(index)
    puts "==================================================="
    puts "#{index+1}. #{@title.upcase}"
    puts "#{@excerpt}"
    puts "---------------------------------------------------"
    puts "#{@meta.section} - #{@meta.date}"
    puts "---------------------------------------------------"
    puts "\n"
  end

  def self.create_from_collection(headlines_array)
    headlines_array.each do |headline|
      self.new(headline)
    end
  end

  def self.all
    @@all
  end

  def self.reset
    @@all = []
  end

  def self.display_all
    self.all.each_with_index do |headline, index|
      headline.display(index)
    end
  end

  def self.display_chunk(chunk = 5)
    input = ""
    i = 0
    until input == "q" || i == self.all.count do
      chunk.times do
        break if self.all[i].nil?
        self.all[i].display(i)
        i+= 1
      end
      puts "Press ENTER to show more or q to quit.\n"
      input = gets.chomp
    end
  end

  def self.get_article_url_at_index(index)
    @@all[index].url unless index >= @@all.count
  end

end
