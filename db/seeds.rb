45.times do |i|
    Pianist.create(name: Faker::Name.name, years_of_experience: Faker::Number.within(range:1..20), expertise: ["instrumental", "vocal"].sample)
end

45.times do |i|
    if i %3 == 0
        Collaborator.create(name: Faker::Name.name,instrument: Faker::Music.instrument,
            instrumental_repertoire: Faker::Music::RockBand.name)
    else
        Collaborator.create(name: Faker::Name.name,voice_type: ["soprano", "tenor","contralto", "mezzo","baritone","bass","bass-baritone","counter tenor"].sample,
        vocal_repertoire: [Faker::Music::Opera.verdi,Faker::Music::Opera.rossini,Faker::Music::Opera.donizetti,Faker::Music::Opera.bellini].sample)
    end  
end

38.times do |i|
    Appointment.create(pianist_id: Pianist.all.sample.id,collaborator_id: Collaborator.all.sample.id)
end

