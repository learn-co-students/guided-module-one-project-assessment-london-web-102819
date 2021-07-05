class Pianist<ActiveRecord::Base
    extend Artist 
    has_many :appointments
    has_many :collaborators, through: :appointments
    # def self.create_new_pianist(new_pianist_info)
    #     # new_pianist_info is a hash with all the details for create a new collaborator
    #     self.create(name: new_pianist_info[:name],log_in_email: new_pianist_info[:log_in_email], password: new_pianist_info[:password])
    # end

    def self.exist?(pianist_name)
        #returns if 
        self.all.find_by(name: pianist_name)!= nil
    end
  
  

  

    
end