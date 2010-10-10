class Classification
  attr_accessor :pos, :team, :points, :games, :win, :draw, :lost, :pro_goals, :against_goals, :balance_goals, :percent

  def initial_classification(teams)
    classification = Array.new
    teams.each {|team|
      classification << Classification.new(:team => team)
    }
    classification
  end
end