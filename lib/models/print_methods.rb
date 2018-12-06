def print_team_matches_all(name)
  matches = get_team_matches_all(name)
  if matches.length == 1
    puts "#{name} have played 1 match."
  else
    puts "#{name} have played #{matches.length} matches."
  end
  puts " "
  matches.each do |match|
    puts "#{Match.find_by(id: match["match_id"]).date}: #{Team.find_by(id: match["team1_id"]).name} #{Match.find_by(id: match["match_id"]).team1_goals} - #{Match.find_by(id: match["match_id"]).team2_goals} #{Team.find_by(id: match["team2_id"]).name}"
  end
end

def print_team_matches_home(name)
  matches = get_team_matches_home(name)
  if matches.length == 1
    puts "#{name} have played 1 home match."
  else
    puts "#{name} have played #{matches.length} home matches."
  end
  puts " "
  matches.each do |match|
    puts "#{Match.find_by(id: match["match_id"]).date}: #{Team.find_by(id: match["team1_id"]).name} #{Match.find_by(id: match["match_id"]).team1_goals} - #{Match.find_by(id: match["match_id"]).team2_goals} #{Team.find_by(id: match["team2_id"]).name}"
  end
end

def print_team_matches_away(name)
  matches = get_team_matches_away(name)
  if matches.length == 1
    puts "#{name} have played 1 away match."
  else
    puts "#{name} have played #{matches.length} away matches."
  end
  puts " "
  matches.each do |match|
    puts "#{Match.find_by(id: match["match_id"]).date}: #{Team.find_by(id: match["team1_id"]).name} #{Match.find_by(id: match["match_id"]).team1_goals} - #{Match.find_by(id: match["match_id"]).team2_goals} #{Team.find_by(id: match["team2_id"]).name}"
  end
end

def print_team_wins_all(name)
    wins = get_team_wins_all(name)
    if wins.count == 1
      puts "#{name} have won 1 game."
    else
      puts "#{name} have won #{wins.count} games."
    end
    puts " "
    wins.each do |match|
      puts "#{Match.find_by(id: match["match_id"]).date}: #{Team.find_by(id: match["team1_id"]).name} #{Match.find_by(id: match["match_id"]).team1_goals} - #{Match.find_by(id: match["match_id"]).team2_goals} #{Team.find_by(id: match["team2_id"]).name}"
    end
end

def print_team_wins_home(name)
    wins = get_team_wins_home(name)
    if wins.count == 1
      puts "#{name} have won 1 home game."
    else
      puts "#{name} have won #{wins.count} home games."
    end
    puts " "
    wins.each do |match|
      puts "#{Match.find_by(id: match["match_id"]).date}: #{Team.find_by(id: match["team1_id"]).name} #{Match.find_by(id: match["match_id"]).team1_goals} - #{Match.find_by(id: match["match_id"]).team2_goals} #{Team.find_by(id: match["team2_id"]).name}"
    end
end

def print_team_wins_away(name)
    wins = get_team_wins_away(name)
    if wins.count == 1
      puts "#{name} have won 1 away game."
    else
      puts "#{name} have won #{wins.count} away games."
    end
    puts " "
    wins.each do |match|
      puts "#{Match.find_by(id: match["match_id"]).date}: #{Team.find_by(id: match["team1_id"]).name} #{Match.find_by(id: match["match_id"]).team1_goals} - #{Match.find_by(id: match["match_id"]).team2_goals} #{Team.find_by(id: match["team2_id"]).name}"
    end
end

def print_team_draws_all(name)
    draws = get_team_draws_all(name)
    if draws.count == 1
      puts "#{name} have drawn 1 game."
    else
      puts "#{name} have drawn #{draws.count} games."
    end
    puts " "
    draws.each do |match|
      puts "#{Match.find_by(id: match["match_id"]).date}: #{Team.find_by(id: match["team1_id"]).name} #{Match.find_by(id: match["match_id"]).team1_goals} - #{Match.find_by(id: match["match_id"]).team2_goals} #{Team.find_by(id: match["team2_id"]).name}"
    end
end

def print_team_draws_home(name)
    draws = get_team_draws_home(name)
    if draws.count == 1
      puts "#{name} have drawn 1 home game."
    else
      puts "#{name} have drawn #{draws.count} home games."
    end
    puts " "
    draws.each do |match|
      puts "#{Match.find_by(id: match["match_id"]).date}: #{Team.find_by(id: match["team1_id"]).name} #{Match.find_by(id: match["match_id"]).team1_goals} - #{Match.find_by(id: match["match_id"]).team2_goals} #{Team.find_by(id: match["team2_id"]).name}"
    end
end

def print_team_draws_away(name)
    draws = get_team_draws_away(name)
    if draws.count == 1
      puts "#{name} have drawn 1 away game."
    else
      puts "#{name} have drawn #{draws.count} away games."
    end
    puts " "
    draws.each do |match|
      puts "#{Match.find_by(id: match["match_id"]).date}: #{Team.find_by(id: match["team1_id"]).name} #{Match.find_by(id: match["match_id"]).team1_goals} - #{Match.find_by(id: match["match_id"]).team2_goals} #{Team.find_by(id: match["team2_id"]).name}"
    end
end

def print_team_losses_all(name)
    losses = get_team_losses_all(name)
    if losses.count == 1
      puts "#{name} have lost 1 game."
    else
      puts "#{name} have lost #{losses.count} games."
    end
    puts " "
    losses.each do |match|
      puts "#{Match.find_by(id: match["match_id"]).date}: #{Team.find_by(id: match["team1_id"]).name} #{Match.find_by(id: match["match_id"]).team1_goals} - #{Match.find_by(id: match["match_id"]).team2_goals} #{Team.find_by(id: match["team2_id"]).name}"
    end
end

def print_team_losses_home(name)
    losses = get_team_losses_home(name)
    if losses.count == 1
      puts "#{name} have lost 1 home game."
    else
      puts "#{name} have lost #{losses.count} home games."
    end
    puts " "
    losses.each do |match|
      puts "#{Match.find_by(id: match["match_id"]).date}: #{Team.find_by(id: match["team1_id"]).name} #{Match.find_by(id: match["match_id"]).team1_goals} - #{Match.find_by(id: match["match_id"]).team2_goals} #{Team.find_by(id: match["team2_id"]).name}"
    end
end

def print_team_losses_away(name)
    losses = get_team_losses_away(name)
    if losses.count == 1
      puts "#{name} have lost 1 away game."
    else
      puts "#{name} have lost #{losses.count} away games."
    end
    puts " "
    losses.each do |match|
      puts "#{Match.find_by(id: match["match_id"]).date}: #{Team.find_by(id: match["team1_id"]).name} #{Match.find_by(id: match["match_id"]).team1_goals} - #{Match.find_by(id: match["match_id"]).team2_goals} #{Team.find_by(id: match["team2_id"]).name}"
    end
end

def print_team_goals_scored_all(name)
    goals = get_team_goals_scored_all(name)
    if goals == 1
      puts "#{name} have scored 1 goal."
    else
      puts "#{name} have scored #{goals} goals."
    end
end

def print_team_goals_scored_home(name)
    goals = get_team_goals_scored_home(name)
    if goals == 1
      puts "#{name} have scored 1 goal at home."
    else
      puts "#{name} have scored #{goals} goals at home."
    end
end

def print_team_goals_scored_away(name)
    goals = get_team_goals_scored_away(name)
    if goals == 1
      puts "#{name} have scored 1 goal away from home."
    else
      puts "#{name} have scored #{goals} goals away from home."
    end
end

def print_team_goals_conceded_all(name)
    goals = get_team_goals_conceded_all(name)
    if goals == 1
      puts "#{name} have conceded 1 goal."
    else
      puts "#{name} have conceded #{goals} goals."
    end
end

def print_team_goals_conceded_home(name)
    goals = get_team_goals_conceded_home(name)
    if goals == 1
      puts "#{name} have conceded 1 goal at home."
    else
      puts "#{name} have conceded #{goals} goals at home."
    end
end

def print_team_goals_conceded_away(name)
    goals = get_team_goals_conceded_away(name)
    if goals == 1
      puts "#{name} have conceded 1 goal away from home."
    else
      puts "#{name} have conceded #{goals} goals away from home."
    end
end

def print_team_goal_difference_all(name)
    diff = get_team_goal_difference_all(name)
    puts "#{name} have a goal difference of #{diff}."
end

def print_team_goal_difference_home(name)
    diff = get_team_goal_difference_home(name)
    puts "#{name} have a home goal difference of #{diff} from their home games."
end

def print_team_goal_difference_away(name)
    diff = get_team_goal_difference_away(name)
    puts "#{name} have a away goal difference of #{diff} from their away games."
end

def print_team_points_all(name)
  points = get_team_points_all(name)
  if points == 1
    puts "#{name} have 1 point."
  else
    puts "#{name} have #{points} points."
  end
end

def print_team_points_home(name)
  points = get_team_points_home(name)
  if points == 1
    puts "#{name} have 1 point from their home games."
  else
    puts "#{name} have #{points} points from their home games."
  end
end

def print_team_points_away(name)
  points = get_team_points_away(name)
  if points == 1
    puts "#{name} have 1 point from their away games."
  else
    puts "#{name} have #{points} points from their away games."
  end
end

def print_match_date(date)
  matches = get_match_date(date)
  if matches == []
    puts "----------------------------------------------------------"
    puts " "
    puts "There were no games played on #{date}!"
  else
    puts "----------------------------------------------------------"
    puts " "
    puts "The following games were played on #{date}:"
    puts " "
    matches.each do |match|
      team1_id = MatchTeam.find_by(match_id: match["id"]).team1_id
      team2_id = MatchTeam.find_by(match_id: match["id"]).team2_id
      puts "#{Team.find_by(id: team1_id).name} #{match["team1_goals"]} - #{Team.find_by(id: team2_id).name} #{match["team1_goals"]}"
    end
  end
  puts " "
  menu
end
