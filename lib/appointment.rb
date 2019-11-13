class Appointment<ActiveRecord::Base
    belongs_to :pianist
    belongs_to :collaborator

    def self.find_specific_appointment(pianist_id, collaborator_id)
        self.all.find_by(pianist_id: pianist_id, collaborator_id: collaborator_id)
    end 
end