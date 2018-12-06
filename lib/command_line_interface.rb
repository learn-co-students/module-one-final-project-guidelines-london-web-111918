require_relative '../config/environment'

class CommandLineInterface

  def run
    welcome
    menu
  end

  def welcome
    puts Rainbow("
    ,--.   ,--.              ,--.   ,--.            ,---.     ,---.                ,--.,--.
    |  |   |  | ,---. ,--.--.|  | ,-|  |     ,---. /  .-'    '   .-'  ,---.  ,---. |  ||  | ,---.
    |  |.'.|  || .-. ||  .--'|  |' .-. |    | .-. ||  `-,    `.  `-. | .-. || .-. :|  ||  |(  .-'
    |   ,'.   |' '-' '|  |   |  || `-' |    ' '-' '|  .-'    .-'    || '-' '|   --.|  ||  |.-'  `)
    '--'   '--' `---' `--'   `--' `---'      `---' `--'      `-----' |  |-'  `----'`--'`--'`----'
                                                                     `--'
    ").crimson.bright
    puts "Wizard / Witch Name:"
    @users_name = get_user_input
    check_user
  end

  def check_user
    if find_user
      puts "\nWelcome back, #{colorize(find_user.name)}!\n\n"
    else
      user = create_profile
      puts "\nWelcome, #{colorize(user.name)}! You have been sorted to #{colorize(user.house)}!\n\n"
    end
  end

  def create_profile
    user = User.create(name: @users_name, house: sorting_hat)
    book = Spellbook.create(name: "#{@users_name}'s Spellbook")
    user.spellbook = book
    user
  end

  def colorize(string)
    user = find_user
    case find_user.house
    when "Gryffindor"
      Rainbow(string).color("#ae0001")
    when "Ravenclaw"
      Rainbow(string).dodgerblue
    when "Slytherin"
      Rainbow(string).color("#2a623d")
    when "Hufflepuff"
      Rainbow(string).color("#ecb939")
    end
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
    user_input = get_user_input
    spell = Spell.find_by(name: user_input)
    if user_input == 1
      menu
    elsif !spell
      puts "\nSpell not found. Enter 1 for Menu or try again:"
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
    rows = []
    rows << [1, "List all Spells"]
    rows << [2, "Find spell by name"]
    rows << [3, "Find spell by type"]
    rows << [4, "View Spellbook"]
    rows << [5, "Add a spell to Spellbook"]
    rows << [6, "Remove a spell from Spellbook"]
    rows << [7, "Quit"]
    table = Terminal::Table.new :title => colorize("MENU"), :rows => rows
    puts table
    choice
  end

  def choice
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
      puts colorize("✧･ﾟ: *✧･ﾟ:*   ").blink + colorize("Mischief Managed") + colorize("   *:･ﾟ✧*:･ﾟ✧").blink
    else
      puts "\nIncorrect input. Please enter a number, 1-7:"
      choice
    end
  end

  def show_all_spells
    rows = []
    Spell.all.each do |spell|
      rows << [spell.name, spell.spell_type, spell.effect]
    end
    table = Terminal::Table.new :title => colorize("Spells").bright, :headings => [Rainbow('Name').burlywood, Rainbow('Type').burlywood, Rainbow('Effect').burlywood], :rows => rows
    puts "#{table}\n\n"
  end

  def spell_search
    puts "Please enter a spell name:"
    spell = find_spell
    rows = []
    rows << [spell.name, spell.spell_type, spell.effect]
    table = Terminal::Table.new :headings => [Rainbow('Name').burlywood, Rainbow('Type').burlywood, Rainbow('Effect').burlywood], :rows => rows
    puts "\n#{table}\n\n"
    spell
  end

  def spell_search_by_type
    puts "\nPlease enter a spell type:"
    user_input = get_user_input
    types = Spell.where(spell_type: user_input)
    if types.empty?
      puts "\nNo spells found of that type. Enter 1 for Menu or try again:"
      get_user_input == 1 ? menu : spell_search_by_type
    else
      rows = []
      types.each do |spell|
        rows << [spell.name, spell.spell_type, spell.effect]
      end
      table = Terminal::Table.new :title => colorize("#{user_input} Spells").bright, :headings => [Rainbow('Name').burlywood, Rainbow('Type').burlywood, Rainbow('Effect').burlywood], :rows => rows
      puts "\n#{table}\n\n"
    end
  end

  def view_spellbook
    user = find_user
    if user.spellbook.spells.empty?
      puts "\nYour Spellbook has no spells.\n\n"
    else
      rows = []
      user.spellbook.spells.each do |spell|
        rows << [spell.name, spell.spell_type, spell.effect]
      end
      table = Terminal::Table.new :title => colorize("#{user.name}'s Spellbook").bright, :headings => [Rainbow('Name').burlywood, Rainbow('Type').burlywood, Rainbow('Effect').burlywood], :rows => rows
      puts "\n#{table}\n\n"
    end
  end

  def add_to_spellbook
    puts "Enter a Spell to add:"
    spell = find_spell
    spellbook = find_spellbook
    bind_spell = find_bind_spell(spell, spellbook)
    if bind_spell
      puts "\n#{colorize(spell.name)} is already in your Spellbook.\n\n"
    else
      BindSpell.create(spellbook_id: spellbook.id, spell_id: spell.id)
      puts "\n#{colorize(spell.name)} has been added to your Spellbook.\n\n"
    end
  end

  def remove_from_spellbook
    puts "Enter a Spell to remove:"
    spell = find_spell
    find_bind_spell(find_spell, find_spellbook).destroy
    puts "#{colorize(spell.name)} has been removed from your Spellbook.\n\n"
  end

end
