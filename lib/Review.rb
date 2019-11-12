require 'pry'

class Review < ActiveRecord::Base
belongs_to :users
belongs_to :shows

  # def self.create_review(user_id)
  # Review.create(user_id: user_id)
  # end

  #def self.create.user

  #end

end
