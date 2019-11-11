5.times do |i|
    Pianist.create(name: Faker::Name.name)
    Collaborator.create(name: Faker::Name.name)
    Appointment.create(pianist_id: Pianist.all.sample.id,collaborator_id: Collaborator.all.sample.id)
end

