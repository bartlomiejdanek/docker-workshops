require 'rubygems'
require 'bundler'
Bundler.setup(:default)

require 'open-uri'
require 'sinatra'

class Scraper
  def self.call(url)
    open(url).read
  end
end

get '/' do
  env_string = JSON.pretty_generate(ENV.to_a).gsub!("\n",'</br>')
  "Environment: </br> #{env_string} </br>"
end

get '/selleo' do
  Scraper.call('https://selleo.com/')
end
