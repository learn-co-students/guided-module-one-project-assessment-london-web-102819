require_relative '../config/environment.rb'
require "pp"
class CommandLineInterface
    attr_reader :new_in_house, :user_pianist, :user_collaborator
    def greet
        puts "Welcome to this fabulous fake opera house! Here, you'll find the best repertoire with the most bizzare instruments~ Shall we begin?" 
    end

    def new_or_not
        puts "Are you new to the House? Y/N"
        a = gets.chomp
        loop do 
            if a.upcase == "Y"
                puts "Welcome and let me show you our in house artists."
                create_new_account
                break
            elsif a.upcase == "N"
                puts "Welcome back! It must've been good last time~"
                user_log_in
                break 
            else
                greet
                break    
            end
        end
    end 

    def your_field
        puts "Are you a pianist or a collaborator(vocal or instrumental)? P/C"
        a=gets.chomp    
        if a.upcase=="P"
            @user_pianist = true
            puts "Let me show you our current collaborators."
            instrumentalists = Collaborator.select{|each|each.instrument != nil}
            puts instrumentalists.map{|each|  "#{each.name} is an instrumentalist. Instrument:#{each.instrument}"}.sort 

            vocalists = Collaborator.select{|each|each.voice_type != nil}
            puts vocalists.map{|each|  "#{each.name} is an vocalist. Voice type: #{each.voice_type}"}.sort
        elsif a.upcase=="C"
            @user_collaborator =true 
            puts "Here are the top 10 pianists in house with the most years of experiences. Take a look."
            Pianist.order(:years_of_experience).last(10).each{|each| 
                puts "#{each.name}, years of experiences #{each.years_of_experience} in #{each.expertise} repertoire."
            }
        end
    end

    def add_new_pianist
        puts "Did you see your pianist's name or should we invite him/her? invite/nvm"
        a=gets.chomp
        if a.upcase == "INVITE"
            puts "May I have his/her full name?" 
            new_pianist_name = gets.chomp
            puts "What is his/her expertise(vocal/instrumental)?"
            new_pianist_expertise = gets.chomp 
            new_pianist = Pianist.create(name: new_pianist_name, expertise: new_pianist_expertise)
            puts "There, we've taken care of inviting your pianist #{new_pianist.name}. Welcome to the house!"    
        elsif a.upcase == "NVM"
            puts "Have a good day!"
        else 
            puts "Try harder next time."
        end 
    end

    def add_new_collaborator
        puts "Did you see your collaborator's name or should we invite him/her? invite/nvm"
        a=gets.chomp
        if a.upcase == "INVITE"
            puts "May I have his/her full name?" 
            new_collaborator_name = gets.chomp
            puts "Is he/her an instrumentalist or a vocalist? i/v"
            new_collaborator_field = gets.chomp 
            if new_collaborator_field.upcase == "I"
                puts "What is his/her instrument?"
                instrument= gets.chomp
                new_collaborator = Collaborator.create(name: new_collaborator_name, instrument: instrument)
                puts "Have fun making music with #{new_collaborator.name}!"
            elsif  new_collaborator_field.upcase == "V"
                puts "What is his/her voice type?"
                voice_type= gets.chomp
                new_collaborator = Collaborator.create(name: new_collaborator_name, voice_type: voice_type)
                puts "Have fun making music with #{new_collaborator.name}!"
            end   
        elsif a.upcase == "NVM"
            puts "Have a good day!"
        else 
            puts "Try harder next time."
        end 
    end

    def who_is_working
        puts "Which pianist's work load would you like to see? Please type his/her full name [Full Name]."
        pianist=gets.chomp
        if Pianist.find_by(name: pianist)==nil 
            puts "I'm terribly sorry. But that pianist does not work for us yet."
        else 
            Pianist.find_by(name:pianist).collaborators.map{|each|
            puts "#{pianist} is currently working with #{each.name} on #{each.instrumental_repertoire!=nil ? each.instrumental_repertoire : each.vocal_repertoire}"}
        end 
    end

    def update_experience
        puts "Congratulations! Yet another year~ Tell me your Full Name ^_^"
        pianist_name = gets.chomp
        pianist = Pianist.find_by(name:pianist_name)
        if pianist !=nil 
            pianist.years_of_experience +=1
            pianist.save 
            puts "Take care! And best of luck on your future journeys!"
        else
            puts "Ooops! This pianist does not appear to exist in our book. Until next time~"
        end
    end
end
