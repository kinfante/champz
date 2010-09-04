class AddTestData < ActiveRecord::Migration
  def self.up
    Championship.delete_all
    Championship.create(:name => "Campeonato Paulista",
      :description => "Campeonato Paulista disputado em São Paulo",
      :image_url => "http://www.noticiaspopulares.info/populares/wp-content/uploads/2009/12/tabela_campeonato_paulista_2010.png",
      :number_teams => 4,
      :match_type => 1,
      :user_id => 1)
    Championship.create(:name => "Campeonato Brasileiro",
      :description => "Campeonato Brasileiro disputado no país",
      :image_url => "http://blogdopaulonunes.com/v2/wp-content/uploads/2009/03/cbf1.jpg",
      :number_teams => 4,
      :match_type => 1,
      :user_id => 1)
  end

  def self.down
    Championship.delete_all
  end
end
