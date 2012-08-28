class CreateListings < ActiveRecord::Migration
  def self.up
    create_table :listings 	 do |t|
      t.integer	 :supplier_id
      t.string	 :title
      t.string 	 :description
      t.float 	 :price

      t.timestamps
    end
    add_index :listings, :user_id
  end

  def self.down
    drop_table :listings
  end
end
