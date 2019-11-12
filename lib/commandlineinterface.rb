require_relative '../config/environment.rb'
require "pp"
class CommandLineInterface
    attr_reader :new_in_house
    def greet
        puts "Welcome to this fabulous fake opera house! Here, you'll find the best repertoire with the most bizzare instruments~ Shall we begin?" 
    end

    def new_or_not
        puts "Are you new to the House? Y/N"
        a = gets.chomp
        if a.upcase == "Y"
            @new_in_house=true
            puts "Welcome and let me show you our in house artists."
        else
            @new_in_house=false 
            puts "Welcome back! It must've been good last time~"
        end
    end 

    def your_field
        puts "Are you a pianist or a collaborator(vocal or instrumental)? P/C"
        a=gets.chomp    
        if a.upcase=="P"
            puts "Let me show you our current collaborators."
            instrumentalists = Collaborator.select{|each|each.instrument != nil}
            puts instrumentalists.map{|each|  "#{each.name} is an instrumentalist. Instrument:#{each.instrument}"}.sort 

            vocalists = Collaborator.select{|each|each.voice_type != nil}
            puts vocalists.map{|each|  "#{each.name} is an vocalist. Voice type: #{each.voice_type}"}.sort
        elsif a.upcase=="C"
            puts "Here are the top 10 pianists in house with the most years of experiences. Take a look."
            Pianist.order(:years_of_experience).last(10).each{|each| 
                puts "#{each.name}, years of experiences #{each.years_of_experience} in #{each.expertise} repertoire."
            }
        end
    end

    def display_pianists
        puts "Would you like to take a look at our pianists roster? Y/N"
        a = gets.chomp
        if a.upcase == "Y"
        
        end
    end
end
