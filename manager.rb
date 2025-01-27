# Manager class to manage all the operations

#use built-in URI and NET HTTP modules to get response of a service call
require 'uri'
require 'net/http'
require 'json'
require './coin'

class Manager
  # coin symbols = keys, coin objects = values
  @@repo = {}

  def initialize
    initialize_repo
  end

  #method to parse and create coin objects
  def initialize_repo
    response = web_scrap
    json = JSON.parse(response)
    # for loop to go through json response
    for symbol, values in json
      # each symbol will be the key of the json data and the values will be the value of the key 
      coin = Coin.new(symbol, values['USD'], values['EUR'], values['BRL'])
      #add the coin obj to the repo hash 
      @@repo[symbol] = coin
    end
  end

  #get values from API and parse them --> web scraping operation
  def web_scrap 
    url = 'https://min-api.cryptocompare.com/data/pricemulti?fsyms=BTC,ETH,XRP,DASH,LTC&tsyms=USD,EUR,BRL'
    uri = URI(url)
    Net::HTTP.get(uri) #gets the uri obj and returns a string response
  end
  
  #method to return a coin list
  def coin_list
    @@repo.keys    
  end

  def calculate(amount, symbol, to)
    coin = @@repo[symbol]
    amount*coin.send(to.to_sym)
  end
end
