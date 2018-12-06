require_relative '../config/environment'

class CommandLineInterface

  def run
    welcome
    menu_table
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
    puts "Wizard / Witch Name:"
    @users_name = get_user_input
    check_user
  end

  def check_user
    if find_user
      puts "Welcome back, #{find_user.name}!"
    else
      create_profile
      puts "Welcome, #{@users_name}!"
    end
  puts "\n"
  end

  def create_profile
    user = User.create(name: @users_name)
    book = Spellbook.create(name: "#{@users_name}'s Spellbook")
    user.spellbook = book
  end

  def find_user
    User.find_by(name: @users_name)
  end

  def find_spellbook
    Spellbook.find_by(user_id: find_user.id)
  end

  def get_user_input
    gets.chomp.capitalize
  end

  def menu_table
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
        menu_table
      when "2"
        find_spell
        menu_table
      when "3"
        find_by_type
        menu_table
      when "4"
        view_spellbook
        menu_table
      when "5"
        add_to_spellbook
        menu_table
      when "6"
        remove_from_spellbook
        menu_table
      when "7"
        puts "✧･ﾟ: *✧･ﾟ:* 　Mischief Managed　 *:･ﾟ✧*:･ﾟ✧"
    end
  end


  def show_all_spells
    rows = []
    Spell.all.each do |spell|
      rows << [spell.name, spell.spell_type, spell.effect]
    end
    table = Terminal::Table.new :title => "Spells", :headings => ['Name', 'Type', 'Effect'], :rows => rows
    puts table
    puts "\n\n"
  end


  def find_spell
    puts "Please enter a spell name:"
    rows = []
    spell = Spell.find_by(name: get_user_input)
    if !spell
      puts "Spell not found."
      find_spell
    else
      rows << [spell.name, spell.spell_type, spell.effect]
    end
    table = Terminal::Table.new :title => "Spells", :headings => ['Name', 'Type', 'Effect'], :rows => rows
    puts table
    puts "\n\n"
    spell
  end


  def find_by_type
    rows = []
    puts "Please enter a spell type:"
    user_input = get_user_input
    types = Spell.where(spell_type: user_input)
    if types.empty?
      puts "No spells found of that type."
      find_by_type
    else
      types.each do |spell|
        rows << [spell.name, spell.spell_type, spell.effect]
      end
      table = Terminal::Table.new :title => "#{user_input} Spells", :headings => ['Spell', 'Type', 'Effect'], :rows => rows
      puts table
      puts "\n\n"
      end
    end

  def view_spellbook
    user = find_user
    rows = []
    if user.spellbook.spells.empty?
        puts "Your Spellbook has no spells."
      else
        user.spellbook.spells.each do |spell|
          rows << [spell.name, spell.spell_type, spell.effect]
        end
        table = Terminal::Table.new :title => "#{user.name}'s Spellbook", :headings => ['Spell', 'Type', 'Effect'], :rows => rows
        puts table
        puts "\n\n"
        end
  end

  def add_to_spellbook
    spell = find_spell
    spellbook = find_spellbook
    bind_spell = BindSpell.find_by(spellbook_id: spellbook.id, spell_id: spell.id)
    if bind_spell
      puts "#{spell.name} is already in your Spellbook"
    else
      BindSpell.create(spellbook_id: spellbook.id, spell_id: spell.id)
      puts "#{spell.name} has been added to your Spellbook"
    end
  end

  def remove_from_spellbook
    puts "Select Spell to remove"
    spell = find_spell
    spellbook = find_spellbook
    BindSpell.find_by(spellbook_id: spellbook.id, spell_id: spell.id).destroy
  end


end
