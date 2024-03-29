class DeviseInvitableAddToSuppliers < ActiveRecord::Migration
  def self.up
    change_table :suppliers do |t|
      t.string     :invitation_token, :limit => 60
      t.datetime   :invitation_sent_at
      t.datetime   :invitation_accepted_at
      t.integer    :invitation_limit
      t.references :invited_by, :polymorphic => true
      t.index      :invitation_token # for invitable
      t.index      :invited_by_id
    end
    
    # And allow null encrypted_password and password_salt:
    change_column_null :suppliers, :encrypted_password, true
  end
  
  def self.down
    change_table :suppliers do |t|
      t.remove_references :invited_by, :polymorphic => true
      t.remove :invitation_limit, :invitation_sent_at, :invitation_accepted_at, :invitation_token
    end
  end
end
