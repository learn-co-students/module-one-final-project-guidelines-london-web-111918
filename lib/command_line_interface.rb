require_relative '../config/environment'

class CommandLineInterface

  def run
    Gosu::Sample.new("lib/music/Hedwigs_Theme.mp3").play
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

  def get_user_input
    gets.chomp.split.map(&:capitalize).join(" ")
  end

  def check_user
    if find_user
      puts "Welcome back, #{colorize(find_user.name)}!"
    else
      user = create_profile
      puts "Welcome, #{colorize(user.name)}! You have been sorted to #{colorize(user.house)}!"
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

  # <---------- Find Methods ---------->

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
      puts "\nSpell not found. Please try again:"
      find_spell
    else
      spell
    end
  end

  def find_spell_type
    types = Spell.where(spell_type: get_user_input)
    if types.empty?
      puts "\nNo spells found of that type. Please try again:"
      find_spell_type
    else
      types
    end
  end

  def find_spell_in_spellbook
    input = get_user_input
    book = find_spellbook.spells.map(&:name)
    if book.include?(input)
      input
    else
      puts "\nYou have entered a spell that is not in your Spellbook. Try again:"
      find_spell_in_spellbook
    end
  end

  # <---------- End Find Methods ---------->

  def menu
    sparkle
    puts "Please select one of the following options:"
    rows = []
    rows << [1, "List all Spells"]
    rows << [2, "Find spell by name"]
    rows << [3, "Find spell by type"]
    rows << [4, "View Spellbook"]
    rows << [5, "Add a spell to Spellbook"]
    rows << [6, "Remove a spell from Spellbook"]
    rows << [7, "Cast a spell from your Spellbook"]
    rows << [8, "Quit"]
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
      cast_spell
      menu
    when "8"
      puts colorize("\n✧･ﾟ: *✧･ﾟ:*   ").blink + colorize("Mischief Managed") + colorize("   *:･ﾟ✧*:･ﾟ✧\n").blink
    else
      puts "\nIncorrect input. Please enter a number, 1-7:"
      choice
    end
  end

  def print_spell(spell)
    "name: #{spell.name}, type: #{spell.spell_type}, effect: #{spell.effect}"
  end

  def show_all_spells
    rows = []
    Spell.all.each do |spell|
      rows << [spell.name, spell.spell_type, spell.effect]
    end
    table = Terminal::Table.new :title => colorize("Spells").bright, :headings => [Rainbow('Name').burlywood, Rainbow('Type').burlywood, Rainbow('Effect').burlywood], :rows => rows
    sparkle
    puts "#{table}"
  end

  def spell_search
    sparkle
    puts "Please enter a spell name:"
    spell = find_spell
    rows = []
    rows << [spell.name, spell.spell_type, spell.effect]
    table = Terminal::Table.new :headings => [Rainbow('Name').burlywood, Rainbow('Type').burlywood, Rainbow('Effect').burlywood], :rows => rows
    puts "\n#{table}"
    spell
  end

  def spell_search_by_type
    sparkle
    puts "Please enter a spell type:"
    spell_types = find_spell_type
    type = spell_types.first.spell_type
    rows = []
    spell_types.each do |spell|
      rows << [spell.name, spell.spell_type, spell.effect]
    end
    table = Terminal::Table.new :title => colorize("#{type} Spells").bright, :headings => [Rainbow('Name').burlywood, Rainbow('Type').burlywood, Rainbow('Effect').burlywood], :rows => rows
    puts "\n#{table}"
  end

  def view_spellbook
    user = find_user
    if user.spellbook.spells.empty?
      sparkle
      puts "Your Spellbook has no spells."
    else
      rows = []
      user.spellbook.spells.each do |spell|
        rows << [spell.name, spell.spell_type, spell.effect]
      end
      table = Terminal::Table.new :title => colorize("#{user.name}'s Spellbook").bright, :headings => [Rainbow('Name').burlywood, Rainbow('Type').burlywood, Rainbow('Effect').burlywood], :rows => rows
      sparkle
      puts "#{table}"
    end
  end

  def add_to_spellbook
    sparkle
    puts "Enter a Spell to add:"
    spell = find_spell
    spellbook = find_spellbook
    bind_spell = find_bind_spell(spell, spellbook)
    if bind_spell
      puts "\n#{colorize(spell.name).bright} is already in your Spellbook."
    else
      BindSpell.create(spellbook_id: spellbook.id, spell_id: spell.id)
      puts "\n#{colorize(spell.name).bright} has been added to your Spellbook."
    end
  end

  def remove_from_spellbook
    sparkle
    puts "Enter a Spell to remove:"
    spell = find_spell
    find_bind_spell(spell, find_spellbook).destroy
    puts "\n#{colorize(spell.name).bright} has been removed from your Spellbook."
  end

  def cast_spell
    sparkle
    if find_spellbook.spells.count == 0
      puts "You do not know any spells. Add spells you know to your Spellbook."
    else
      puts "Enter a spell you wish to cast:"
      puts Rainbow("\n(∩｀-´)⊃━☆   -*'^'~*-.,_,.-*~'^'~*-   ").burlywood + colorize("#{find_spell_in_spellbook}")
    end
  end

  def sparkle
    puts colorize("\n\n✧･ﾟ: *✧･ﾟ:* *:･ﾟ✧*:･ﾟ✧ ✧･ﾟ: *✧･ﾟ:* *:･ﾟ✧*:･ﾟ✧ ✧･ﾟ: *✧･ﾟ:* *:･ﾟ✧*:･ﾟ✧ ✧･ﾟ: *✧･ﾟ:* *:･ﾟ✧*:･ﾟ✧ ✧･ﾟ: *✧･ﾟ:* *:･ﾟ✧*:･ﾟ✧ ✧･ﾟ:･ﾟ✧* *:･ﾟ✧\n\n")
  end

end
