class Pianist<ActiveRecord::Base
    has_many :appointments
    has_many :collaborators, through: :appointments

    
end