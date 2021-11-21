require 'rake' 
require 'nokogiri'
require 'open-uri' 

desc "Inserts player data by parsing xml data from input source into db"
task insert_player_data: :environment do
doc=Nokogiri::XML(URI.open("http://www.cafeconleche.org/examples/baseball/1998statistics.xml"))
def calculate_average(player_node)
    return player_node.at("HITS").text.to_f/player_node.at("AT_BATS").text.to_f unless 
    player_node.at('HITS').nil? ||player_node.at("AT_BATS").nil? || (player_node.at("AT_BATS").text.to_i)==0


end
def calculate_stolen_base(player_node)
    #In baseball statistics, stolen bases are denoted by SB. Attempts to steal 
    #that result in the baserunner being out are caught stealing (CS).
    #The sum of these statistics is steal attempts.
    return player_node.at("STEALS").text.to_f+player_node.at("CAUGHT_STEALING").text.to_f unless player_node.at("STEALS").nil? || player_node.at("CAUGHT_STEALING").nil?
end
def get_text(player_node,node)
    player_node.at(node).text unless player_node.at(node).nil?        
end

doc.xpath('//SEASON//LEAGUE').each do |league_node|
    league_name=league_node.at("LEAGUE_NAME").text
    print(league_name)
    league=League.create(league_name: league_name)
    league_node.search(".//DIVISION").each do |division_node|
        
        division_name=division_node.at('DIVISION_NAME').text
        print(division_name)
        division=Division.create(division_name: division_name,league_id: league.id)
        division_node.search(".//TEAM").each do |team_node|
            team_name = team_node.at('TEAM_NAME').text
            team_city =team_node.at('TEAM_CITY').text
            team=Team.create(team_name: team_name,team_city: team_city, division_id: division.id)
            team_node.search(".//PLAYER").each do |player_node|
                average=calculate_average(player_node)
                #print(average)
                stolen_base=calculate_stolen_base(player_node)
                #print(stolen_base)
                Player.create(
                    surname: get_text(player_node,'SURNAME'),
                    given_name: get_text(player_node,'GIVEN_NAME'),
                    position: get_text(player_node,'POSITION'),
                    
                    wins: get_text(player_node,'WINS'),
                    losses: get_text(player_node,'LOSSES'),
                    saves: get_text(player_node,'SAVES'),
                    games: get_text(player_node,'GAMES'),
                    games_started: get_text(player_node,'GAMES_STARTED'),
                    complete_games: get_text(player_node,'COMPLETE_GAMES'),
                    shout_outs: get_text(player_node,'SHOUT_OUTS'),
                    era: get_text(player_node,'ERA'),
                    at_bats: get_text(player_node,'AT_BATS'),
                    innings: get_text(player_node,'INNINGS'),
                    home_runs: get_text(player_node,'HOME_RUNS'),
                    runs: get_text(player_node,'RUNS'),
                    hits: get_text(player_node,'HITS'),
                    doubles: get_text(player_node,'DOUBLES'),
                    triples: get_text(player_node,'TRIPLES'),
                    rbi: get_text(player_node,'RBI'),
                    steals: get_text(player_node,'STEALS'),
                    caught_stealing: get_text(player_node,'CAUGHT_STEALING'),
                    sacrifice_hits: get_text(player_node,'SACRIFICE_HITS'),
                    sacrifice_flies: get_text(player_node,'SACRIFICE_FLIES'),
                    errs: get_text(player_node,'errs'),
                    pb: get_text(player_node,'PB'),
                    walks: get_text(player_node,'WALKS'),
                    struck_out: get_text(player_node,'STRUCK_OUT'),
                    hit_by_pitch: get_text(player_node,'hit_by_pitch'),
                    earned_runs: get_text(player_node,'EARNED_RUN'),
                    hit_batter: get_text(player_node,'HIT_BATTER'),
                    wild_pitches: get_text(player_node,'WILD_PITCHES'),
                    balk: get_text(player_node,'BALK'),
                    walked_batter: get_text(player_node,'WALKED_BATTER'),
                    struck_out_batter: get_text(player_node,'STRUCK_OUT_BATTER'),
                    average: average,
                    stolen_base: stolen_base,
                    team_id: team.id)       
            end
        end
    end
end
end
