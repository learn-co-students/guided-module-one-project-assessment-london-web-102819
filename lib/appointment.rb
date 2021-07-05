class Appointment<ActiveRecord::Base
    belongs_to :pianist
    belongs_to :collaborator

    def self.find_specific_appointment(pianist_id, collaborator_id)
        self.all.find_by(pianist_id: pianist_id, collaborator_id: collaborator_id)
    end 

    def self.current_appointments
        self.all.map{|app| "#{app.pianist.name} is working with #{app.collaborator.name}."}.sort
    end 

    def delete_appointment
        pianist=self.pianist
        collaborator = self.collaborator
        pianist.appointments.delete(self)
        collaborator.appointments.delete(self)
        self.destroy
    end


end