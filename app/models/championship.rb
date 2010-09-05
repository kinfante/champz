class Championship < ActiveRecord::Base
  belongs_to :user
  has_many :teams
  
  CHAMPIONSHIP_TYPES = [
    #Displayed              stored in db
    [ "One turn",           1 ],
    [ "Turn and return",    2 ]
  ]

  #START:validation
  validates_presence_of :name, :description, :number_teams, :match_type
  validates_numericality_of :number_teams, :match_type
  validates_uniqueness_of :name
  validates_format_of :image_url,
                      :with    => %r{(\.(gif|jpg|png)$)|(^$)}i,
                      :message => "must be a URL for a GIF, JPG, or PNG image"
  #END:validation

  def self.find_championships_for_home(page = 1)
    #find(:all)
    paginate :page => page, :per_page => 4
  end
end
