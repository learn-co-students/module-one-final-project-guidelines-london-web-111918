require 'rest-client'
require 'pry'
require 'json'



url = "https://api.football-data.org/v2/competitions/PL/matches?status=FINISHED"
key = "5db158231dda4c11b33b88eb0a8f0a4a"

response = RestClient.get(url,'x-auth-token': key )
response_hash = JSON.parse(response)
match_array = response_hash["matches"]

matches = []
matches = match_array.map do |match_hash|
              new_match = {}
              new_match["date"] = match_hash["utcDate"][0..9]
              new_match["team1"] = match_hash["homeTeam"]["name"].gsub("AFC", "").gsub("FC", "").strip
              new_match["team2"] = match_hash["awayTeam"]["name"].gsub("AFC", "").gsub("FC", "").strip
              new_match["team1goals"] = match_hash["score"]["fullTime"]["homeTeam"]
              new_match["team2goals"] = match_hash["score"]["fullTime"]["awayTeam"]
              matches << new_match
            end

match_list = matches[0].uniq

team_names = []
team_names = match_list.map do |match_hash|
                  team_names << match_hash["team1"]
                  team_names << match_hash["team2"]
                end

team_list = team_names[0].uniq.sort

binding.pry
0
