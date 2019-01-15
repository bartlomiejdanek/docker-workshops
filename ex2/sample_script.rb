require 'rubygems'
require 'bundler'
require 'open-uri'
Bundler.setup(:default)

require 'nokogiri'

class App
  def self.scrape(url)
    content = open(url).read
    Nokogiri::HTML(content).enum_for(:traverse).count
  end
end

puts App.scrape(ENV.fetch('SCRAPE_URL'))
