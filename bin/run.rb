require_relative '../config/environment'

all_spells = RestClient.get("https://www.potterapi.com/v1/spells?key=$2a$10$0ewomlY54wR7s9seLoIPseKIfjkMu6m.2EAtv52OpfgEYGAGwWlRu")
all_spells_json = JSON.parse(all_spells)

puts "HELLO WORLD"
