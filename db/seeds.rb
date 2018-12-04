require_relative '../config/environment'

all_spells = RestClient.get("https://www.potterapi.com/v1/spells?key=$2a$10$0ewomlY54wR7s9seLoIPseKIfjkMu6m.2EAtv52OpfgEYGAGwWlRu")
spells_json = JSON.parse(all_spells)

spells_json.map do |spell|
  if !Spell.find_by(name: spell["name"])
    new_spell = Spell.new
    new_spell.name = spell["spell"]
    new_spell.spell_type = spell["type"]
    new_spell.effect = spell["effect"]
    new_spell.save
  end
end
