class CreateChampionships < ActiveRecord::Migration
  def self.up
    create_table :championships do |t|
      t.string :name
      t.text :description
      t.string :image_url
      t.integer :number_teams
      t.integer :match_type
      t.references :user

      t.timestamps
    end
  end

  def self.down
    drop_table :championships
  end
end
