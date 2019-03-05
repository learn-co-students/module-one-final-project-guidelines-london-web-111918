require_relative '../config/environment'

all_spells = RestClient.get("https://www.potterapi.com/v1/spells?key=$2a$10$0ewomlY54wR7s9seLoIPseKIfjkMu6m.2EAtv52OpfgEYGAGwWlRu")
spells_json = JSON.parse(all_spells)

if Spell.all.count == 0
  spells_json.map do |spell|
    new_spell = Spell.new
    new_spell.name = spell["spell"]
    new_spell.spell_type = spell["type"]
    new_spell.effect = spell["effect"]
    new_spell.save
  end
end
