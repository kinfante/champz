class CreateMatches < ActiveRecord::Migration
  def self.up
    create_table :matches do |t|
      t.integer :home_team_id
      t.integer :away_team_id
      t.integer :home_score
      t.integer :away_score
      t.integer :status
      t.references :championship
      t.integer :round

      t.timestamps
    end
  end

  def self.down
    drop_table :matches
  end
end
