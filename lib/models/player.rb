require 'rest-client'
require 'JSON'

class Player < ActiveRecord::Base


  # response_string = RestClient.get('https://fantasy.premierleague.com/drf/bootstrap-static')
  # response_hash = JSON.parse(response_string)

end
response_string = RestClient.get('https://fantasy.premierleague.com/drf/bootstrap-static')
response_hash = JSON.parse(response_string)
