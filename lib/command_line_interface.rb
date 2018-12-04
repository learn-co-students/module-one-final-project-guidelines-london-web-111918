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
    @users_name = gets.chomp
    puts "Welcome #{@users_name}!"
    create_user ; nil
  end

  def create_user
    User.create(name: @users_name)
  end

  def menu
    puts "Please select one of the following options:"
    puts <<-MENU1
      1. List all spells
      2. Find spell by name
    MENU1
    user_input = gets.chomp
    case user_input
    when "1"
      show_all_spells
    when "2"
      find_spell
    end
  end

  def show_all_spells
    Spell.all.each do |spell|
      puts "#{spell.id}. name: #{spell.name}, type: #{spell.spell_type}, effect: #{spell.effect}"
    end
  end

  def find_spell
    puts "Please enter a spell name:"
    user_input = gets.chomp
    spell = Spell.find_by(name: user_input)
    puts "name: #{spell.name}, type: #{spell.spell_type}, effect: #{spell.effect}"
  end

end
