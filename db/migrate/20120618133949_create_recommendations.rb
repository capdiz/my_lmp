class CreateRecommendations < ActiveRecord::Migration
  def self.up
    create_table :recommendations do |t|
	    t.integer	:user_id
	    t.string	:email
	    t.integer	:recommended_to_id
	    t.integer	:recommended_listing_id
	    t.string	:recommendation_token
	    t.integer	:recommendation_limit
	    t.datetime	:recommendation_limit_ends_at
	    t.datetime	:recommendation_accepted_at
	    t.datetime	:recommendation_sent_at

      t.timestamps
    end
   add_index :recommendations, :user_id 
   add_index :recommendations, :recommended_listing_id
  end

  def self.down
    drop_table :recommendations
  end
end
