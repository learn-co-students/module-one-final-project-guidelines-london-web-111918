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
    puts "on your TV which people used to get the latest football"
    puts "news and information."
end

def menu
    puts "------------------------------------------------------------"
    puts "To get information about a Premier League team, enter 'info'"
    puts "To start an information search query, enter 'search'"
    puts "To search for results by date played, enter 'date'"
    puts "To view the full Premier League table, enter 'table'"
    puts "(N.B The table is best viewed in fullscreen mode)"
    puts "To update the information in the database, enter 'update'"
    puts "Want more info about CEEFAX? enter 'ceefax'"
    puts "------------------------------------------------------------"
    puts "To exit SEEFACTS, enter 'exit' from anywhere in the program"
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
  elsif !input.to_i.between?(1,20)
    puts "----------------------------------------------------------"
    puts "Input not recognised, please enter a valid input"
    team_information
  end
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
  elsif !number.to_i.between?(1,20)
    puts "----------------------------------------------------------"
    puts "Input not recognised, please enter a valid input"
    query_name
  end
  name = Team.find_by(id: number).name
  query_type(name)
end

def query_type(name)
  puts "----------------------------------------------------------"
  puts "To select query to run on your team, please enter the"
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
  query = gets.strip
  if query.downcase == "exit"
    puts "----------------------------------------------------------"
    puts "Thankyou for using SEEFACTS, goodbye!"
    puts "----------------------------------------------------------"
    return nil
  elsif !query.to_i.between?(1,8)
    puts "----------------------------------------------------------"
    puts "Input not recognised, please enter a valid input"
    query_type(name)
  end
  query_location(name, query)
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
  location = gets.strip
  if location.downcase == "exit"
    puts "----------------------------------------------------------"
    puts "Thankyou for using SEEFACTS, goodbye!"
    puts "----------------------------------------------------------"
    return nil
  elsif !location.to_i.between?(1,3)
    puts "----------------------------------------------------------"
    puts "Input not recognised, please enter a valid input"
    query_location(name, query)
  end
  query_run(name, query, location)
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
  elsif !(/\d{4}-\d{2}-\d{2}/ === date.to_s)
    puts "----------------------------------------------------------"
    puts "Input not recognised, please enter a valid input"
    match_date
  else
    print_match_date(date)
  end
end

def table
  get_league_table
  menu
end

def update
  puts "------------------------------------------------------------"
  puts "deleting database..."
  system ("rake db:rollback STEP=3 &>/dev/null")
  puts "recreating database..."
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
