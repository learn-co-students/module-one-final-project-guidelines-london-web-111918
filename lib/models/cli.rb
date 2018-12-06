def run
  welcome
  menu
end

def welcome
    puts " "
    puts "------------------------------------------------------------"
    puts "Welcome to SEEFACTS - The Premier League Information Service"
    puts "------------------------------------------------------------"
    puts "This is a command line application for getting information"
    puts "and facts about Premier League teams and matches from the"
    puts "current season (Aug 2018 - May 2019). The name is a tribute"
    puts "to CEEFAX, the pre-internet text-based information service"
    puts "via TV which people used to get the latest football news"
    puts "and information."
end

def menu
    puts "------------------------------------------------------------"
    puts "To get information about a Premier League team, enter 'info'"
    puts "To start a match information search query, enter 'search'"
    puts "To search for match results by date, enter 'date'"
    puts "To view the full Premier League table, enter 'table'"
    puts "(N.B. The table displays best in fullscreen mode)"
    puts "To update the information in the database, enter 'update'"
    puts "Want more info about CEEFAX? enter 'ceefax'"
    puts "------------------------------------------------------------"
    puts "To return to this menu, enter 'menu' anywhere in the program"
    puts "To exit SEEFACTS, enter 'exit' anywhere in the program"
    puts "------------------------------------------------------------"
    input = gets.strip
    if input.downcase == 'info'
      team_information
    elsif input.downcase == 'search'
      query_name
    elsif input.downcase == 'date'
      match_date
    elsif input.downcase == 'table'
      table
    elsif input.downcase == 'update'
      update
    elsif input.downcase == 'ceefax'
      ceefax
    elsif input.downcase == 'menu'
      menu
    elsif input.downcase == "exit"
      puts "----------------------------------------------------------"
      puts "Thankyou for using SEEFACTS, goodbye!"
      puts "----------------------------------------------------------"
      return nil
    else
      puts "----------------------------------------------------------"
      puts "Input not recognised, please enter a valid input"
      menu
    end
end

def team_information
  puts "----------------------------------------------------------"
  puts "To get information about a specific team, please enter"
  puts "the corresponding number below:"
  puts "----------------------------------------------------------"
  puts " "
  Team.all.each {|team| puts "#{team["id"]} - #{team["name"]}"}
  puts " "
  puts "----------------------------------------------------------"
  input = gets.strip
  if input.downcase == "exit"
    puts "----------------------------------------------------------"
    puts "Thankyou for using SEEFACTS, goodbye!"
    puts "----------------------------------------------------------"
    return nil
  elsif input.downcase == "menu"
    menu
  elsif !input.to_i.between?(1,20)
    puts "----------------------------------------------------------"
    puts "Input not recognised, please enter a valid input"
    team_information
  else
    info = Team.find_by(id: input.to_i)
    puts "----------------------------------------------------------"
    puts " "
    puts "#{info["name"]} - Team Information"
    puts " "
    puts "Club Colours: #{info["colours"]}"
    puts "Stadium: #{info["stadium"]}"
    puts "Address: #{info["address"]}"
    puts "Year Founded: #{info["founded"]}"
    puts " "
    menu
  end
end

def query_name
  puts "----------------------------------------------------------"
  puts "To select a team to run the query on, please enter the"
  puts "corresponding number as listed below"
  puts "----------------------------------------------------------"
  puts " "
  Team.all.each {|team| puts "#{team["id"]} - #{team["name"]}"}
  puts " "
  puts "----------------------------------------------------------"
  number = gets.strip
  if number.downcase == "exit"
    puts "----------------------------------------------------------"
    puts "Thankyou for using SEEFACTS, goodbye!"
    puts "----------------------------------------------------------"
    return nil
  elsif number.downcase == "menu"
    menu
  elsif !number.to_i.between?(1,20)
    puts "----------------------------------------------------------"
    puts "Input not recognised, please enter a valid input"
    query_name
  else
    name = Team.find_by(id: number).name
    query_type(name)
  end
end

def query_type(name)
  puts "----------------------------------------------------------"
  puts "To select a query to run on your team, please enter the"
  puts "corresponding number as listed below"
  puts "----------------------------------------------------------"
  puts " "
  puts "1. Results"
  puts "2. Wins"
  puts "3. Draws"
  puts "4. Losses"
  puts "5. Goals Scored"
  puts "6. Goals Conceded"
  puts "7. Goal Difference"
  puts "8. Points"
  puts " "
  puts "----------------------------------------------------------"
  puts "To start again and select a different team, enter 'back'"
  puts "----------------------------------------------------------"
  query = gets.strip
  if query.downcase == "exit"
    puts "----------------------------------------------------------"
    puts "Thankyou for using SEEFACTS, goodbye!"
    puts "----------------------------------------------------------"
    return nil
  elsif query.downcase == "menu"
    menu
  elsif query.downcase == "back"
    query_name
  elsif !query.to_i.between?(1,8)
    puts "----------------------------------------------------------"
    puts "Input not recognised, please enter a valid input"
    query_type(name)
  else
    query_location(name, query)
  end
end

def query_location(name, query)
  puts "----------------------------------------------------------"
  puts "To filter your query by match location, please enter the"
  puts "corresponding number as listed below"
  puts "----------------------------------------------------------"
  puts " "
  puts "1. All "
  puts "2. Home Matches"
  puts "3. Away Matches"
  puts " "
  puts "----------------------------------------------------------"
  puts "To start again and select a different team, enter 'back'"
  puts "----------------------------------------------------------"
  location = gets.strip
  if location.downcase == "exit"
    puts "----------------------------------------------------------"
    puts "Thankyou for using SEEFACTS, goodbye!"
    puts "----------------------------------------------------------"
    return nil
  elsif location.downcase == "menu"
    menu
  elsif location.downcase == "back"
    query_name
  elsif !location.to_i.between?(1,3)
    puts "----------------------------------------------------------"
    puts "Input not recognised, please enter a valid input"
    query_location(name, query)
  else
    query_run(name, query, location)
  end
end

def query_run(name, query, location)
  puts "----------------------------------------------------------"
  puts " "
  selection = "#{query}#{location}".to_i
  if selection == 11
    print_team_matches_all(name)
  elsif selection == 12
    print_team_matches_home(name)
  elsif selection == 13
    print_team_matches_away(name)
  elsif selection == 21
    print_team_wins_all(name)
  elsif selection == 22
    print_team_wins_home(name)
  elsif selection == 23
    print_team_wins_away(name)
  elsif selection == 31
    print_team_draws_all(name)
  elsif selection == 32
    print_team_draws_home(name)
  elsif selection == 33
    print_team_draws_away(name)
  elsif selection == 41
    print_team_losses_all(name)
  elsif selection == 42
    print_team_losses_home(name)
  elsif selection == 43
    print_team_losses_away(name)
  elsif selection == 51
    print_team_goals_scored_all(name)
  elsif selection == 52
    print_team_goals_scored_home(name)
  elsif selection == 53
    print_team_goals_scored_away(name)
  elsif selection == 61
    print_team_goals_conceded_all(name)
  elsif selection == 62
    print_team_goals_conceded_home(name)
  elsif selection == 63
    print_team_goals_conceded_away(name)
  elsif selection == 71
    print_team_goal_difference_all(name)
  elsif selection == 72
    print_team_goal_difference_home(name)
  elsif selection == 73
    print_team_goal_difference_away(name)
  elsif selection == 81
    print_team_points_all(name)
  elsif selection == 82
    print_team_points_home(name)
  elsif selection == 83
    print_team_points_away(name)
  end
  puts " "
  menu
end

def match_date
  puts "----------------------------------------------------------"
  puts "To find matches played on a specific date, enter the date"
  puts "below in the format YYYY-MM-DD (i.e enter 2018-12-06 to"
  puts "find games played on 6th December 2018)"
  puts "----------------------------------------------------------"
  date = gets.strip
  if date.to_s.downcase == "exit"
    puts "----------------------------------------------------------"
    puts "Thankyou for using SEEFACTS, goodbye!"
    puts "----------------------------------------------------------"
    return nil
  elsif date.to_s.downcase == "menu"
    menu
  elsif !(/\d{4}-\d{2}-\d{2}/ === date.to_s)
    puts "----------------------------------------------------------"
    puts "Input not recognised, please enter a valid input"
    match_date
  else
    print_match_date(date)
  end
end

def table
  print_league_table
  menu
end

def update
  puts "------------------------------------------------------------"
  puts "Deleting database..."
  system ("rake db:rollback STEP=3 &>/dev/null")
  puts "Recreating database..."
  system("rake db:migrate &>/dev/null")
  system("rake db:seed")
  puts " "
  puts "------------------------------------------------------------"
  puts "Database successfully updated!"
  menu
end

def ceefax
  system ("open https://en.wikipedia.org/wiki/Ceefax")
  menu
end
