class CreatePastes < ActiveRecord::Migration
  def self.up
    create_table :pastes do |t|
      t.string  :guid,    :null  => false
      t.string  :filename
      t.binary  :content
      t.integer :user_id, :null  => false

      t.timestamps
    end

    add_index :pastes, :guid
    add_index :pastes, :user_id
  end

  def self.down
    drop_table :pastes
  end
end
