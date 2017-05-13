require "pry"
require_relative "meta"

class Article

  attr_accessor :title, :content, :meta

  def initialize(data)
    add_article_attributes(data)
  end

  def add_article_attributes(hash)
    hash.each do |key, value|
      if key == :meta
        self.send(("#{key}="), Meta.new(value))
      else
        self.send(("#{key}="), value)
      end
    end
  end

  def display
    puts "\n\n\n"
    puts "#{@title.upcase}"
    puts "---------------------"
    puts "#{@meta.author} | #{@meta.date}"
    puts "---------------------"
    puts "#{@content}"
    puts "_."
  end

end
