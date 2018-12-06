require 'rest-client'
require 'pry'
require 'json'

# Get Match Info From API -------------
puts "Fetching match data"
url = "https://api.football-data.org/v2/competitions/PL/matches?status=FINISHED"
key = "5db158231dda4c11b33b88eb0a8f0a4a"

response = RestClient.get(url,'x-auth-token': key )
response_hash = JSON.parse(response)
match_array = response_hash["matches"]

match_list = []
match_array.each do |match_hash|
  new_match = {}
  new_match["date"] = match_hash["utcDate"][0..9]
  new_match["team1_goals"] = match_hash["score"]["fullTime"]["homeTeam"]
  new_match["team2_goals"] = match_hash["score"]["fullTime"]["awayTeam"]
  new_match["match_no"] = match_hash["id"]
  match_list << new_match
  print "."
end

# END --------------

# Get Team Info from API -----------
puts " "
puts "Fetching team data"

url = "https://api.football-data.org/v2/competitions/PL/teams"

response = RestClient.get(url,'x-auth-token': key )
response_hash = JSON.parse(response)
teams_array = response_hash["teams"]

teams = []
teams_array.each do |team_hash|
        new_team_hash = {}
        new_team_hash["name"] = team_hash["name"].gsub("AFC","").gsub("FC","").strip
        new_team_hash["colours"] = team_hash["clubColors"]
        new_team_hash["stadium"] = team_hash["venue"]
        new_team_hash["address"] = team_hash["address"]
        new_team_hash["founded"] = team_hash["founded"]
        teams << new_team_hash
        print "."
      end

team_list = teams.sort_by {|team| team["name"]}

# END --------------------

# Seed teams table ----------------
puts " "
puts "Building team table"

team_list.each do |team_hash|
  Team.create(name: team_hash["name"], colours: team_hash["colours"], stadium: team_hash["stadium"], address: team_hash["address"], founded: team_hash["founded"])
  print "."
end

# END -------------------

# Seed matches table -----------------
puts " "
puts "Building match table"

match_list.each do |match_hash|
  Match.create(date: match_hash["date"], team1_goals: match_hash["team1_goals"], team2_goals: match_hash["team2_goals"], match_no: match_hash["match_no"])
  print "."
end

# END ------------

# Seed match_teams table ------------
puts " "
puts "Building match_teams table"

Match.all.each do |match_hash|
  team1 = ""
  team2 = ""
  match_array.find do |match|
    if match["id"] == match_hash["match_no"]
      team1 = match["homeTeam"]["name"].gsub("AFC","").gsub("FC","").strip
      team2 = match["awayTeam"]["name"].gsub("AFC","").gsub("FC","").strip
    end
  end
  team1_id = Team.find_by(name: team1).id
  team2_id = Team.find_by(name: team2).id
  MatchTeam.create(match_id: match_hash["id"], team1_id: team1_id, team2_id: team2_id)
  print "."
end

# END ----------------
