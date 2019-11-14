class Collaborator<ActiveRecord::Base
    has_many :appointments
    has_many :pianists, through: :appointments

    def self.create_new_instru_collaborator(collaborator_info)
        # collaborator_info is a hash with all the details for create a new instrumental collaborator
        self.create(name: collaborator_info[:full_name], instrument: collaborator_info[:instrument], log_in_email: collaborator_info[:log_in_email], password: collaborator_info[:password])
    end

    def self.create_new_vocal_collaborator(collaborator_info)
        # collaborator_info is a hash with all the details for create a new vocal collaborator
        self.create(name: collaborator_info[:full_name], voice_type: collaborator_info[:voice_type], log_in_email: collaborator_info[:log_in_email], password: collaborator_info[:password])
    end

    def self.exist?(collab_name)
        #returns if 
        self.all.find_by(name: collab_name)!= nil
    end

    def update_instrumental_rep(new_rep)
        self.update(instrumental_repertoire: new_rep)
    end 
    
    def update_vocal_rep(new_rep)
        self.update(vocal_repertoire: new_rep)
    end 
        
    def self.instrumentalists
        self.all.select{|collab| collab.instrument!=nil}
    end

    def self.vocalists
        self.all.select{|collab| collab.voice_type !=nil}
    end 

    def self.vocalists_repertoire
        self.instrumentalists.select{|instrumentalist| instrumentalist.vocal_repertoire!=nil}
    end 

    def self.instrumentalists_repertoire
        self.instrumentalists.select{|instrumentalist| instrumentalist.instrumental_repertoire!=nil}
        # instrumentalists_rep = [
        #     [["Name"], ["Instrumental Repertoire"]]
        # ]
        # # binding.pry
        # instrumentalists.map {|instrumentalist|
        #     [instrumentalists_repertoire <<
        #         [["#{instrumentalist.name}"], ["#{instrumentalist.instrumental_repertoire}"]]
        #     ] 
        # }
    end
    
    def self.in_house_collaborators_with_repertoire
        self.select{|collab|
            collab.instrumental_repertoire!=nil ||  collab.vocal_repertoire!=nil
        }
    end
 
 
end