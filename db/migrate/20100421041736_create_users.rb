class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :screen_name
      t.string :twitter_id
      t.string :token

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end