class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :github_account
      t.string :github_access_token
      t.string :access_token
      t.string :email
      t.string :name
      t.string :gravatar_id
      t.string :company
      t.string :location

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end

