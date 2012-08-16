class CreateListingCategories < ActiveRecord::Migration
  def self.up
    create_table :listing_categories, :id => false do |t|
      t.integer :listing_id
      t.integer :category_id

      t.timestamps
    end
    add_index :listing_categories, :listing_id
    add_index :listing_categories, :category_id
  end

  def self.down
    drop_table :listing_categories
  end
end
