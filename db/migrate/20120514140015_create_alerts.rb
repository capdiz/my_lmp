class CreateAlerts < ActiveRecord::Migration
  def self.up
    create_table :alerts do |t|
      t.integer :user_id
      t.string :alert_title

      t.timestamps
    end
  end

  def self.down
    drop_table :alerts
  end
end
