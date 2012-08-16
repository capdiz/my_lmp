class CreateTellers < ActiveRecord::Migration
  def self.up
    create_table :tellers do |t|
	    t.integer :user_alert_id
	    t.integer :supplier_id
	    t.integer :no_of_recommendations
      t.timestamps
    end
    add_index :tellers, :user_alert_id
  end

  def self.down
    drop_table :tellers
  end
end
