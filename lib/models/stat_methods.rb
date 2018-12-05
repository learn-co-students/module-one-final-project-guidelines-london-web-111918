
def get_league_table
  teams = Team.all.map(&:name)
  team_rows = []
  teams.each do |name|
    team_row_hash = {}
    team_row_hash["team"] = name
    team_row_hash["played"] = get_team_matches_all(name).count
    team_row_hash["wins"] = get_team_wins_all(name)
    team_row_hash["draws"] = get_team_draws_all(name)
    team_row_hash["losses"] = get_team_losses_all(name)
    team_row_hash["gf"] = get_team_goals_scored_all(name)
    team_row_hash["ga"] = get_team_goals_conceded_all(name)
    team_row_hash["gd"] = get_team_goal_difference_all(name)
    team_row_hash["points"] = get_team_points_all(name)
    team_rows << team_row_hash
  end
  ordered_rows = team_rows.sort_by{|team| team["team"]}.reverse.sort_by{|team| [ team["points"], team["gd"], team["gf"] ]}.reverse
  rows = ordered_rows.map do |team|
    [ ordered_rows.index(team)+1, team["team"], team["played"], team["wins"], team["draws"], team["losses"], team["gf"], team["ga"], team["gd"], team["points"] ]
  end
  league_table = Terminal::Table.new :headings => ['Position', 'Team Name', 'Played', 'Won', 'Drawn', 'Lost', 'Goals For', 'Goals Against', 'Goal Difference', 'Points'], :rows => rows
  puts " "
  puts "Premier League Table"
  puts " "
  puts league_table
  puts " "
end

def get_team_matches_all(name)
  (get_team_matches_home(name) + get_team_matches_away(name)).sort_by(&:id)
end

def get_team_matches_home(name)
  team_id = Team.find_by(name: name).id
  MatchTeam.where(team1_id: team_id)
end

def get_team_matches_away(name)
  team_id = Team.find_by(name: name).id
  MatchTeam.where(team2_id: team_id)
end

def get_team_goals_scored_all(name)
  get_team_goals_scored_home(name) + get_team_goals_scored_away(name)
end

def get_team_goals_scored_home(name)
  goals_scored_home = 0
  get_team_matches_home(name).each {|match| goals_scored_home += Match.find_by(id: match["match_id"]).team1_goals}
  goals_scored_home
end

def get_team_goals_scored_away(name)
  goals_scored_away = 0
  get_team_matches_away(name).each {|match| goals_scored_away += Match.find_by(id: match["match_id"]).team2_goals}
  goals_scored_away
end

def get_team_goals_conceded_all(name)
  get_team_goals_conceded_home(name) + get_team_goals_conceded_away(name)
end

def get_team_goals_conceded_home(name)
  goals_conceded_home = 0
  get_team_matches_home(name).each {|match| goals_conceded_home += Match.find_by(id: match["match_id"]).team2_goals}
  goals_conceded_home
end

def get_team_goals_conceded_away(name)
  goals_conceded_away = 0
  get_team_matches_away(name).each {|match| goals_conceded_away += Match.find_by(id: match["match_id"]).team1_goals}
  goals_conceded_away
end

def get_team_goal_difference_all(name)
  get_team_goal_difference_home(name) + get_team_goal_difference_away(name)
end

def get_team_goal_difference_home(name)
  get_team_goals_scored_home(name) - get_team_goals_conceded_home(name)
end

def get_team_goal_difference_away(name)
  get_team_goals_scored_away(name) - get_team_goals_conceded_away(name)
end

def get_team_wins_all(name)
  get_team_wins_home(name) + get_team_wins_away(name)
end

def get_team_wins_home(name)
  home_wins = 0
  get_team_matches_home(name).each {|match| home_wins += 1 if Match.find_by(id: match["match_id"]).team1_goals > Match.find_by(id: match["match_id"]).team2_goals}
  home_wins
end

def get_team_wins_away(name)
  away_wins = 0
  get_team_matches_away(name).each {|match| away_wins += 1 if Match.find_by(id: match["match_id"]).team1_goals < Match.find_by(id: match["match_id"]).team2_goals}
  away_wins
end

def get_team_losses_all(name)
  get_team_losses_home(name) + get_team_losses_away(name)
end

def get_team_losses_home(name)
  home_losses = 0
  get_team_matches_home(name).each {|match| home_losses += 1 if Match.find_by(id: match["match_id"]).team1_goals < Match.find_by(id: match["match_id"]).team2_goals}
  home_losses
end

def get_team_losses_away(name)
  away_losses = 0
  get_team_matches_away(name).each {|match| away_losses += 1 if Match.find_by(id: match["match_id"]).team1_goals > Match.find_by(id: match["match_id"]).team2_goals}
  away_losses
end

def get_team_draws_all(name)
  get_team_draws_home(name) + get_team_draws_away(name)
end

def get_team_draws_home(name)
  home_draws = 0
  get_team_matches_home(name).each {|match| home_draws += 1 if Match.find_by(id: match["match_id"]).team1_goals == Match.find_by(id: match["match_id"]).team2_goals}
  home_draws
end

def get_team_draws_away(name)
  away_draws = 0
  get_team_matches_away(name).each {|match| away_draws += 1 if Match.find_by(id: match["match_id"]).team1_goals == Match.find_by(id: match["match_id"]).team2_goals}
  away_draws
end

def get_team_points_all(name)
  get_team_points_home(name) + get_team_points_away(name)
end

def get_team_points_home(name)
  (get_team_wins_home(name) * 3) + get_team_draws_home(name)
end

def get_team_points_away(name)
  (get_team_wins_away(name) * 3) + get_team_draws_away(name)
end
