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
    puts "Welcome #{@users_name}!"
    create_profile
  end

  def create_profile
    user = User.create(name: @users_name)
    book = Spellbook.create(name: "#{@users_name}'s Spellbook")
    user.spellbook = book
  end

  def get_user_input
    gets.chomp.capitalize
  end

  def menu
    puts "Please select one of the following options:"
    puts <<-MENU1
      1. List all spells
      2. Find spell by name
      3. Find spells by type
      4. View Spellbook
    MENU1
    case get_user_input
    when "1"
      show_all_spells
    when "2"
      find_spell
    when "3"
      find_by_type
    when "4"
      view_spellbook
    end

  end

  def show_all_spells
    Spell.all.each do |spell|
      puts "#{spell.id}. name: #{spell.name}, type: #{spell.spell_type}, effect: #{spell.effect}"
    end
  end

  def find_spell
    puts "Please enter a spell name:"
    spell = Spell.find_by(name: get_user_input)
    if !spell
      puts "Spell not found."
      find_spell
    else
      puts "name: #{spell.name}, type: #{spell.spell_type}, effect: #{spell.effect}"
    end
  end

  def find_by_type
    puts "Please enter a spell type:"
    types = Spell.where(spell_type: get_user_input)
    if types.empty?
      puts "No spells found of that type."
      find_by_type
    else
      types.each {|spell| puts "name: #{spell.name}, type: #{spell.spell_type}, effect: #{spell.effect}"}
    end
  end

  def view_spellbook
    user = User.find_by(name: @users_name)
    puts "#{@users_name}'s Spellbook"
    puts "*****************"
    if user.spellbook.spells.empty?
      puts "Your Spellbook has no spells."
    else
      user.spellbook.spells.each do |spell|
        puts "name: #{spell.name}, type: #{spell.spell_type}, effect: #{spell.effect}"
      end
    end
  end



end
