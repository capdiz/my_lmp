class CreateProfilePhotos < ActiveRecord::Migration
  def self.up
    create_table :profile_photos do |t|
	    t.integer	:user_id
	    t.integer	:supplier_id
      t.timestamps
    end
    add_index :profile_photos, :user_id
    add_index :profile_photos, :supplier_id
  end

  def self.down
    drop_table :profile_photos
  end
end
