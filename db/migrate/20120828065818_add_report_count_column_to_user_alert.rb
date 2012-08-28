class AddReportCountColumnToUserAlert < ActiveRecord::Migration
  def self.up
	  add_column :user_alerts, :report_count, :integer
  end

  def self.down
	  remove_column :user_alerts, :report_count
  end
end
