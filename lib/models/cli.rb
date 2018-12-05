
def get_team_matches_all(name)
  matches_all = []
  team_id = Team.find_by(name: name).id
  matches_all << MatchTeam.where(team1_id: team_id)
  matches_all << MatchTeam.where(team2_id: team_id)
  match_list = matches_all.flatten.sort_by(&:id)
  puts "#{name} have played #{match_list.length} matches:"
  match_list.map do |match|
    puts "#{Match.find_by(id: match["match_id"]).date}: #{Team.find_by(id: match["team1_id"]).name} #{Match.find_by(id: match["match_id"]).team1_goals} - #{Match.find_by(id: match["match_id"]).team2_goals} #{Team.find_by(id: match["team2_id"]).name}"
  end
end

def get_team_matches_home(name)
  team_id = Team.find_by(name: name).id
  matches_home = MatchTeam.where(team1_id: team_id)
  puts "#{name} have played #{matches_home.length} home matches:"
  matches_home.map do |match|
    puts "#{Match.find_by(id: match["match_id"]).date}: #{name} #{Match.find_by(id: match["match_id"]).team1_goals} - #{Match.find_by(id: match["match_id"]).team2_goals} #{Team.find_by(id: match["team2_id"]).name}"
  end
end

def get_team_matches_away(name)
  team_id = Team.find_by(name: name).id
  matches_away = MatchTeam.where(team2_id: team_id)
  puts "#{name} have played #{matches_away.length} away matches:"
  matches_away.map do |match|
    puts "#{Match.find_by(id: match["match_id"]).date}: #{Team.find_by(id: match["team1_id"]).name} #{Match.find_by(id: match["match_id"]).team1_goals} - #{Match.find_by(id: match["match_id"]).team2_goals} #{name}"
  end
end

def get_team_goals_scored_all(name)
  team_id = Team.find_by(name: name).id
  matches_home = MatchTeam.where(team1_id: team_id)
  matches_away = MatchTeam.where(team2_id: team_id)
  goals_scored = 0
  matches_home.each {|match| goals_scored += Match.find_by(id: match["match_id"]).team1_goals}
  matches_away.each {|match| goals_scored += Match.find_by(id: match["match_id"]).team2_goals}
  puts "#{name} have scored #{goals_scored} goals."
end

def get_team_goals_scored_home(name)
  team_id = Team.find_by(name: name).id
  matches_home = MatchTeam.where(team1_id: team_id)
  goals_scored_home = 0
  matches_home.each {|match| goals_scored_home += Match.find_by(id: match["match_id"]).team1_goals}
  puts "#{name} have scored #{goals_scored_home} goals at home."
end

def get_team_goals_scored_away(name)
  team_id = Team.find_by(name: name).id
  matches_away = MatchTeam.where(team2_id: team_id)
  goals_scored_away = 0
  matches_away.each {|match| goals_scored_away += Match.find_by(id: match["match_id"]).team2_goals}
  puts "#{name} have scored #{goals_scored_away} goals away from home."
end

def get_team_goals_conceded_all(name)
  team_id = Team.find_by(name: name).id
  matches_home = MatchTeam.where(team1_id: team_id)
  matches_away = MatchTeam.where(team2_id: team_id)
  goals_conceded = 0
  matches_home.each {|match| goals_conceded += Match.find_by(id: match["match_id"]).team2_goals}
  matches_away.each {|match| goals_conceded += Match.find_by(id: match["match_id"]).team1_goals}
  puts "#{name} have conceded #{goals_conceded} goals."
end

def get_team_goals_conceded_home(name)
  team_id = Team.find_by(name: name).id
  matches_home = MatchTeam.where(team1_id: team_id)
  goals_conceded_home = 0
  matches_home.each {|match| goals_conceded_home += Match.find_by(id: match["match_id"]).team2_goals}
  puts "#{name} have conceded #{goals_conceded_home} goals at home."
end

def get_team_goals_conceded_away(name)
  team_id = Team.find_by(name: name).id
  matches_away = MatchTeam.where(team2_id: team_id)
  goals_conceded_away = 0
  matches_away.each {|match| goals_conceded_away += Match.find_by(id: match["match_id"]).team1_goals}
  puts "#{name} have conceded #{goals_conceded_away} goals away from home."
end

def get_team_goal_difference_all(name)
  team_id = Team.find_by(name: name).id
  matches_home = MatchTeam.where(team1_id: team_id)
  matches_away = MatchTeam.where(team2_id: team_id)
  goals_scored = 0
  matches_home.each {|match| goals_scored += Match.find_by(id: match["match_id"]).team1_goals}
  matches_away.each {|match| goals_scored += Match.find_by(id: match["match_id"]).team2_goals}
  goals_conceded = 0
  matches_home.each {|match| goals_conceded += Match.find_by(id: match["match_id"]).team2_goals}
  matches_away.each {|match| goals_conceded += Match.find_by(id: match["match_id"]).team1_goals}
  puts "#{name} have a goal difference of #{goals_scored - goals_conceded}."
end

def get_team_goal_difference_home(name)
  team_id = Team.find_by(name: name).id
  matches_home = MatchTeam.where(team1_id: team_id)
  goals_scored_home = 0
  matches_home.each {|match| goals_scored_home += Match.find_by(id: match["match_id"]).team1_goals}
  goals_conceded_home = 0
  matches_home.each {|match| goals_conceded_home += Match.find_by(id: match["match_id"]).team2_goals}
  puts "#{name} have a home goal difference of #{goals_scored_home - goals_conceded_home}."
end

def get_team_goal_difference_away(name)
  team_id = Team.find_by(name: name).id
  matches_away = MatchTeam.where(team2_id: team_id)
  goals_scored_away = 0
  matches_away.each {|match| goals_scored_away += Match.find_by(id: match["match_id"]).team2_goals}
  goals_conceded_away = 0
  matches_away.each {|match| goals_conceded_away += Match.find_by(id: match["match_id"]).team1_goals}
  puts "#{name} have an away goal difference of #{goals_scored_away - goals_conceded_away}."
end

def get_team_wins_all(name)
  team_id = Team.find_by(name: name).id
  matches_home = MatchTeam.where(team1_id: team_id)
  matches_away = MatchTeam.where(team2_id: team_id)
  wins = 0
  matches_home.each {|match| wins += 1 if Match.find_by(id: match["match_id"]).team1_goals > Match.find_by(id: match["match_id"]).team2_goals}
  matches_away.each {|match| wins += 1 if Match.find_by(id: match["match_id"]).team1_goals < Match.find_by(id: match["match_id"]).team2_goals}
  puts "#{name} have won #{wins} games."
end

def get_team_wins_home(name)
  team_id = Team.find_by(name: name).id
  matches_home = MatchTeam.where(team1_id: team_id)
  home_wins = 0
  matches_home.each {|match| home_wins += 1 if Match.find_by(id: match["match_id"]).team1_goals > Match.find_by(id: match["match_id"]).team2_goals}
  puts "#{name} have won #{home_wins} games at home."
end

def get_team_wins_away(name)
  team_id = Team.find_by(name: name).id
  matches_away = MatchTeam.where(team2_id: team_id)
  away_wins = 0
  matches_away.each {|match| away_wins += 1 if Match.find_by(id: match["match_id"]).team1_goals < Match.find_by(id: match["match_id"]).team2_goals}
  puts "#{name} have won #{away_wins} games away from home."
end

def get_team_losses_all(name)
  team_id = Team.find_by(name: name).id
  matches_home = MatchTeam.where(team1_id: team_id)
  matches_away = MatchTeam.where(team2_id: team_id)
  losses = 0
  matches_home.each {|match| losses += 1 if Match.find_by(id: match["match_id"]).team1_goals < Match.find_by(id: match["match_id"]).team2_goals}
  matches_away.each {|match| losses += 1 if Match.find_by(id: match["match_id"]).team1_goals > Match.find_by(id: match["match_id"]).team2_goals}
  puts "#{name} have lost #{losses} games."
end

def get_team_losses_home(name)
  team_id = Team.find_by(name: name).id
  matches_home = MatchTeam.where(team1_id: team_id)
  home_losses = 0
  matches_home.each {|match| home_losses += 1 if Match.find_by(id: match["match_id"]).team1_goals < Match.find_by(id: match["match_id"]).team2_goals}
  puts "#{name} have lost #{home_losses} games at home."
end

def get_team_losses_away(name)
  team_id = Team.find_by(name: name).id
  matches_away = MatchTeam.where(team2_id: team_id)
  away_losses = 0
  matches_away.each {|match| away_losses += 1 if Match.find_by(id: match["match_id"]).team1_goals > Match.find_by(id: match["match_id"]).team2_goals}
  puts "#{name} have lost #{away_losses} games away from home."
end

def get_team_draws_all(name)
  team_id = Team.find_by(name: name).id
  matches_home = MatchTeam.where(team1_id: team_id)
  matches_away = MatchTeam.where(team2_id: team_id)
  draws = 0
  matches_home.each {|match| draws += 1 if Match.find_by(id: match["match_id"]).team1_goals == Match.find_by(id: match["match_id"]).team2_goals}
  matches_away.each {|match| draws += 1 if Match.find_by(id: match["match_id"]).team1_goals == Match.find_by(id: match["match_id"]).team2_goals}
  puts "#{name} have drawn #{draws} games."
end

def get_team_draws_home(name)
  team_id = Team.find_by(name: name).id
  matches_home = MatchTeam.where(team1_id: team_id)
  home_draws = 0
  matches_home.each {|match| home_draws += 1 if Match.find_by(id: match["match_id"]).team1_goals == Match.find_by(id: match["match_id"]).team2_goals}
  puts "#{name} have drawn #{home_draws} games at home."
end

def get_team_draws_away(name)
  team_id = Team.find_by(name: name).id
  matches_away = MatchTeam.where(team2_id: team_id)
  away_draws = 0
  matches_away.each {|match| away_draws += 1 if Match.find_by(id: match["match_id"]).team1_goals == Match.find_by(id: match["match_id"]).team2_goals}
  puts "#{name} have drawn #{away_draws} games away from home."
end

def get_team_points_all(name)
  team_id = Team.find_by(name: name).id
  matches_home = MatchTeam.where(team1_id: team_id)
  matches_away = MatchTeam.where(team2_id: team_id)
  points = 0
  matches_home.each {|match|
    if Match.find_by(id: match["match_id"]).team1_goals > Match.find_by(id: match["match_id"]).team2_goals
      points += 3
    elsif Match.find_by(id: match["match_id"]).team1_goals == Match.find_by(id: match["match_id"]).team2_goals
      points += 1
    end
    }
  matches_away.each {|match|
    if Match.find_by(id: match["match_id"]).team1_goals < Match.find_by(id: match["match_id"]).team2_goals
      points += 3
    elsif Match.find_by(id: match["match_id"]).team1_goals == Match.find_by(id: match["match_id"]).team2_goals
      points += 1
    end
    }
  puts "#{name} have #{points} points."
end

def get_team_points_home(name)
  team_id = Team.find_by(name: name).id
  matches_home = MatchTeam.where(team1_id: team_id)
  home_points = 0
  matches_home.each {|match|
    if Match.find_by(id: match["match_id"]).team1_goals > Match.find_by(id: match["match_id"]).team2_goals
      home_points += 3
    elsif Match.find_by(id: match["match_id"]).team1_goals == Match.find_by(id: match["match_id"]).team2_goals
      home_points += 1
    end
    }
  puts "#{name} have #{home_points} points from their home games."
end

def get_team_points_away(name)
  team_id = Team.find_by(name: name).id
  matches_away = MatchTeam.where(team2_id: team_id)
  away_points = 0
  matches_away.each {|match|
    if Match.find_by(id: match["match_id"]).team1_goals < Match.find_by(id: match["match_id"]).team2_goals
      away_points += 3
    elsif Match.find_by(id: match["match_id"]).team1_goals == Match.find_by(id: match["match_id"]).team2_goals
      away_points += 1
    end
    }
  puts "#{name} have #{away_points} points from their away games."
end
