class CreatePlayers < ActiveRecord::Migration
  def self.up
    create_table :players do |t|
      t.string :name
      t.string :last_name
      t.date :birth
      t.integer :position
      t.references :team

      t.timestamps
    end
  end

  def self.down
    drop_table :players
  end
end
