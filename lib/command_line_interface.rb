require_relative '../config/environment'

class CommandLineInterface

  def run
    welcome
    menu
  end

  def welcome
    puts <<-TITLE
    ,--.   ,--.              ,--.   ,--.            ,---.     ,---.                ,--.,--.
    |  |   |  | ,---. ,--.--.|  | ,-|  |     ,---. /  .-'    '   .-'  ,---.  ,---. |  ||  | ,---.
    |  |.'.|  || .-. ||  .--'|  |' .-. |    | .-. ||  `-,    `.  `-. | .-. || .-. :|  ||  |(  .-'
    |   ,'.   |' '-' '|  |   |  || `-' |    ' '-' '|  .-'    .-'    || '-' '|   --.|  ||  |.-'  `)
    '--'   '--' `---' `--'   `--' `---'      `---' `--'      `-----' |  |-'  `----'`--'`--'`----'
                                                                     `--'
    TITLE
    puts "Wizard / Witches name:"
    @users_name = get_user_input
    check_user
  end

  def check_user
    user = find_user
    if user
      puts "Welcome back, #{user.name}!"
    else
      user = create_profile
      puts "Welcome, #{user.name}! You have been sorted to #{user.house}"
    end
  end

  def create_profile
    user = User.create(name: @users_name, house: sorting_hat)
    book = Spellbook.create(name: "#{@users_name}'s Spellbook")
    user.spellbook = book
    user
  end

  def sorting_hat
    houses = ["Gryffindor", "Ravenclaw", "Slytherin", "Hufflepuff"]
    houses.sample
  end

  def find_user
    User.find_by(name: @users_name)
  end

  def find_spellbook
    Spellbook.find_by(user_id: find_user.id)
  end

  def find_bind_spell(spell, spellbook)
    BindSpell.find_by(spellbook_id: spellbook.id, spell_id: spell.id)
  end

  def find_spell
    spell = Spell.find_by(name: get_user_input)
    if !spell
      puts "Spell not found. Please try again:"
      find_spell
    else
      spell
    end
  end

  def get_user_input
    gets.chomp.split.map(&:capitalize).join(" ")
  end

  def menu
    puts "Please select one of the following options:"
    puts <<-MENU1
      1. List all spells
      2. Find spell by name
      3. Find spells by type
      4. View Spellbook
      5. Add spell to Spellbook
      6. Remove spell from Spellbook
      7. Quit
    MENU1
    case get_user_input
    when "1"
      show_all_spells
      menu
    when "2"
      spell_search
      menu
    when "3"
      spell_search_by_type
      menu
    when "4"
      view_spellbook
      menu
    when "5"
      add_to_spellbook
      menu
    when "6"
      remove_from_spellbook
      menu
    when "7"
      puts "Mischief Managed"
    end
  end

  def print_spell(spell)
    "name: #{spell.name}, type: #{spell.spell_type}, effect: #{spell.effect}"
  end

  def show_all_spells
    Spell.all.each do |spell|
      puts "#{spell.id}. #{print_spell(spell)}"
    end
  end

  def spell_search
    puts "Please enter a spell name:"
    spell = find_spell
    puts print_spell(spell)
  end

  def spell_search_by_type
    puts "Please enter a spell type:"
    types = Spell.where(spell_type: get_user_input)
    if types.empty?
      puts "No spells found of that type."
      spell_search_by_type
    else
      types.each {|spell| puts print_spell(spell)}
    end
  end

  def view_spellbook
    user = find_user
    puts "#{find_user.name}'s Spellbook"
    puts "*****************"
    if user.spellbook.spells.empty?
      puts "Your Spellbook has no spells."
    else
      user.spellbook.spells.each do |spell|
        puts print_spell(spell)
      end
    end
  end

  def add_to_spellbook
    puts "Enter a Spell to add:"
    spell = find_spell
    spellbook = find_spellbook
    bind_spell = find_bind_spell(spell, spellbook)
    if bind_spell
      puts "#{spell.name} is already in your Spellbook."
    else
      BindSpell.create(spellbook_id: spellbook.id, spell_id: spell.id)
      puts "#{spell.name} has been added to your Spellbook."
    end
  end

  def remove_from_spellbook
    puts "Enter a Spell to remove:"
    spell = find_spell
    spellbook = find_spellbook
    find_bind_spell(spell, spellbook).destroy
    puts "#{spell.name} has been removed from your Spellbook."
  end

end
