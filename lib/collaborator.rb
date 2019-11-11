class Collaborator<ActiveRecord::Base
    has_many :appointments
    has_many :pianists, through: :appointments
end