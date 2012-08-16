class CreateRecommenders < ActiveRecord::Migration
  def self.up
    create_table :recommenders do |t|
	    t.integer :user_alert_id
	    t.integer :recommended_to_supplier_id
	    t.integer :recommended_by_user_id
	    t.string  :recommended_by_name
      t.timestamps
    end
    add_index :recommenders, :user_alert_id
    add_index :recommenders, :recommended_to_supplier_id
  end

  def self.down
    drop_table :recommenders
  end
end
