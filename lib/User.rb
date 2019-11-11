
class User < ActiveRecord::Base
  has_many :reviews
  has_many :shows, through: :reviews
end