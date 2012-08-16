class CreateContacts < ActiveRecord::Migration
  def self.up
    create_table :contacts do |t|
      t.string :message
      t.integer :user_id
      t.string :email

      t.timestamps
    end
    add_index :contacts, :user_id
  end

  def self.down
    drop_table :contacts
  end
end
