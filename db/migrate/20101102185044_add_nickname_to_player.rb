class AddNicknameToPlayer < ActiveRecord::Migration
  def self.up
    add_column :players, :nickname, :string
  end

  def self.down
    remove_column :players, :nickname
  end
end
