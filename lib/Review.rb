require 'pry'

class Review < ActiveRecord::Base
belongs_to :users
belongs_to :shows

end
