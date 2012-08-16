class AddSubjectToContact < ActiveRecord::Migration
  def self.up
    add_column :contacts, :subject, :string
  end

  def self.down
    remove_column :contacts, :subject
  end
end
