class Team < ActiveRecord::Base
  belongs_to :championship
  has_many :matches, :foreign_key => :home_team_id, :dependent => :destroy
  has_many :matches, :foreign_key => :away_team_id, :dependent => :destroy
  has_many :players, :dependent => :destroy
end
