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
    ").magenta.bright
    puts "Wizard / Witch Name:"
    @users_name = get_user_input
    check_user
  end

  def check_user
    if find_user
      puts "\nWelcome back, #{find_user.name}!\n\n"
    else
      user = create_profile
      puts "\nWelcome, #{user.name}! You have been sorted to #{user.house}!\n\n"
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
    table = Terminal::Table.new :title => "MENU", :rows => rows
    puts table

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
        puts Rainbow("✧･ﾟ: *✧･ﾟ:*   ").lightseagreen.blink + Rainbow("Mischief Managed").lightseagreen + Rainbow("   *:･ﾟ✧*:･ﾟ✧").lightseagreen.blink
    end
  end

  def show_all_spells
    rows = []
    Spell.all.each do |spell|
      rows << [spell.name, spell.spell_type, spell.effect]
    end
    table = Terminal::Table.new :title => "Spells", :headings => ['Name', 'Type', 'Effect'], :rows => rows
    puts "#{table}\n\n"
  end

  def spell_search
    puts "Please enter a spell name:"
    spell = find_spell
    rows = []
    rows << [spell.name, spell.spell_type, spell.effect]
    table = Terminal::Table.new :headings => ['Name', 'Type', 'Effect'], :rows => rows
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
      table = Terminal::Table.new :title => "#{user_input} Spells", :headings => ['Spell', 'Type', 'Effect'], :rows => rows
      puts "\n#{table}\n\n"
    end
  end

  def view_spellbook
    user = find_user
    if user.spellbook.spells.empty?
      puts "Your Spellbook has no spells."
    else
      rows = []
      user.spellbook.spells.each do |spell|
        rows << [spell.name, spell.spell_type, spell.effect]
      end
      table = Terminal::Table.new :title => "#{user.name}'s Spellbook", :headings => ['Spell', 'Type', 'Effect'], :rows => rows
      puts "\n#{table}\n\n"
    end
  end

  def add_to_spellbook
    puts "Enter a Spell to add:"
    spell = find_spell
    spellbook = find_spellbook
    bind_spell = find_bind_spell(spell, spellbook)
    if bind_spell
      puts "\n#{spell.name} is already in your Spellbook.\n\n"
    else
      BindSpell.create(spellbook_id: spellbook.id, spell_id: spell.id)
      puts "\n#{spell.name} has been added to your Spellbook.\n\n"
    end
  end

  def remove_from_spellbook
    puts "Enter a Spell to remove:"
    spell = find_spell
    find_bind_spell(find_spell, find_spellbook).destroy
    puts "#{spell.name} has been removed from your Spellbook.\n\n"
  end

end
