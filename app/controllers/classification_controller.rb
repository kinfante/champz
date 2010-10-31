class ClassificationController < ApplicationController
  def show
    @championship = Championship.find(params[:id])
    @classification = generate_classification(@championship)
  end

  private
    def generate_classification(championship)
      #classification = Classification.initial_classification(championship.teams)
      classif = Hash.new
      championship.teams.each {|team|
        c = Classification.new()
        c.team = team
        c.games = 0
        c.win = 0
        c.draw = 0
        c.lost = 0
        c.pro_goals = 0
        c.against_goals = 0
        c.balance_goals = 0
        c.percent = 0
        c.points = 0
        classif[c.team.id] = c
      }
      classif

      championship.matches.each { |match|
        if match.status != 0
          classif[match.home_team.id].games += 1
          classif[match.away_team.id].games += 1
          classif[match.home_team.id].pro_goals += match.home_score
          classif[match.away_team.id].pro_goals += match.away_score
          classif[match.home_team.id].against_goals += match.away_score
          classif[match.away_team.id].against_goals += match.home_score

          if match.home_score > match.away_score
            classif[match.home_team.id].win += 1
            classif[match.away_team.id].lost += 1
            classif[match.home_team.id].points += 3
          elsif match.home_score < match.away_score
            classif[match.home_team.id].lost += 1
            classif[match.away_team.id].win += 1
            classif[match.away_team.id].points += 3
          else
            classif[match.home_team.id].draw += 1
            classif[match.away_team.id].draw += 1
            classif[match.home_team.id].points += 1
            classif[match.away_team.id].points += 1
          end

          classif[match.home_team.id].balance_goals = classif[match.home_team.id].pro_goals - classif[match.home_team.id].against_goals
          classif[match.away_team.id].balance_goals = classif[match.away_team.id].pro_goals - classif[match.away_team.id].against_goals
        end
      }

      classif.each { |c|
        c[1].percent = (c[1].points.to_f/(c[1].games.to_f*3)).to_f
      }

      classif.sort {|a,b| b[1].points<=>a[1].points}
    end
end
