class Player < ActiveRecord::Base
  belongs_to :team

  POSITION_TYPES = [
    #Displayed              stored in db
    [ "Goalkeeper",  1 ],
    [ "Fullback",    2 ],
    [ "Midfielder",  3 ],
    [ "Forward",     4 ]
  ]
end
