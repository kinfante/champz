class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :name
      t.string :login
      t.string :hashed_password
      t.string :salt

      t.timestamps
    end
    
    User.create(:name => "Kleber Infante",
      :login => "kinfante",
      :password => "uol123",
      :password_confirmation => "uol123")
  end

  def self.down
    drop_table :users
  end
end
