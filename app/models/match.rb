class Match < ActiveRecord::Base
  belongs_to :home_team, :class_name => 'Team'
  belongs_to :away_team, :class_name => 'Team'
  #has_one :home_team, :class_name => 'Team' #,:foreign_key => :home_team_id
  #has_one :away_team, :class_name => 'Team'
  belongs_to :championship
end
