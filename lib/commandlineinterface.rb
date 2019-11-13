require_relative '../config/environment.rb'

class CommandLineInterface
    attr_reader :user_pianist, :user_collaborator, :logged_in_user

    def greet
        puts "Welcome to this fabulous fake opera house! 
        Here, you'll find the best repertoire with the most bizzare instruments~ 
        Shall we begin?" 
            new_or_not 
    end
        
    def user_menu
        loop do
            @prompt = TTY::Prompt.new
            input = @prompt. select(
                "To continue, please browse our user menu.",
                [ "New Appointment", "Cancel Appointment","View Your Appointment(s)","Update Information","In House Pianists","In House Collaborators", "Show Account Details","Exit"]
            )
            
            if input == "New Appointment"
                new_appointment 
            elsif input == "Cancel Appointment"
                cancel_appointment
            elsif input == "View Your Appointment(s)"
                view_appointments
            elsif input == "In House Pianists"
                in_house_pianists
            elsif input == "In House Collaborators"
                in_house_collaborators
            elsif input == "Update Information"
                info_update
            elsif input == "Show Account Details"
                puts "user_id: #{@logged_in_user.id}
                      user_name: #{@logged_in_user.name}
                      user_email: #{@logged_in_user.log_in_email}"
            elsif input == "Exit"
                return
            end
        end
    end

    def info_update
        puts "We are currently only allowing our collaborators to update their repertoire information."
        if  @logged_in_user.class == Collaborator 
            puts "Are you updating your (i) instrumental repertoire or (v) vocal repertoire?"
            a=gets.chomp
            if a.upcase == "I"
                puts "What is your new rep?"
                new_rep = gets.chomp
                @logged_in_user.update_instrumental_rep(new_rep)
            elsif a.upcase=="V"
                puts "What is your new rep?"
                new_rep = gets.chomp
                @logged_in_user.update_vocal_rep(new_rep)
            end
        end
    end 

    def in_house_collaborators
        puts "Here, you'll find all of our collaborators information."
        puts Collaborator.all.map{|collab|
            "#{collab.name} is working on #{collab.instrumental_repertoire==nil ?  collab.vocal_repertoire : collab.instrumental_repertoire}."
        }
    end

    def in_house_pianists
        puts "Here, you'll find all of our pianists information."
        puts Pianist.all.map{|pianist|
            "Pianist #{pianist.name} is an expert in #{pianist.expertise}. 
            To contact him/her: #{pianist.log_in_email}"
        }
    end 

    def cancel_appointment
        puts "Keep in mind, deletion of appointments are not reversable."
        if @logged_in_user.class == Pianist
            puts "Please state your collaborator's full name."
            collab_name = gets.chomp
            if Collaborator.exist?(collab_name)
                collaborator = Collaborator.all.find_by(name:collab_name)
                appointment = Appointment.find_specific_appointment(@logged_in_user.id,collaborator.id)
                appointment.destroy
            else 
                puts "We can't seem to find such appointment."
            end
        elsif @logged_in_user.class == Collaborator 
            puts "Please state your pianist's full name."
            pianist_name = gets.chomp
            if Pianist.exist?(pianist_name)
                pianist = Pianist.all.find_by(name: pianist_name)
                appointment = Appointment.find_specific_appointment(pianist.id,@logged_in_user.id)
                appointment.destroy
            else 
                puts "We can't seem to find such appointment."
            end
        end
        puts "Your appointment has been removed. Hope to see you soon!"
    end
         
            

    def new_appointment
        puts "Welcome to our booking system."
        if @logged_in_user.class == Pianist
            puts "Please state your collaborator's full name."
            collab_name = gets.chomp
            if Collaborator.exist?(collab_name)
                collaborator = Collaborator.all.find_by(name:collab_name)
                new_appointment = Appointment.create(pianist_id: @logged_in_user.id, collaborator_id: collaborator.id)
            else
                puts "This artist isn't currently available in our house."
                new_collaborator = add_new_collaborator
                new_appointment = Appointment.create(pianist_id: @logged_in_user.id, collaborator_id: new_collaborator.id)
            end
        elsif @logged_in_user.class == Collaborator 
            puts "Please state your pianist's full name."
            pianist_name = gets.chomp
            if Pianist.exist?(pianist_name)
                pianist = Pianist.all.find_by(name: pianist_name)
                new_appointment = Appointment.create(pianist_id: pianist.id, collaborator_id: @logged_in_user.id)
            else
                puts "This artist isn't currently available in our house."
                new_pianist = add_new_pianist
                new_appointment=Appointment.create(pianist_id: new_pianist.id, collaborator_id: @logged_in_user.id)
            end
        end 
        puts "Your appointment has been confirmed. Please check your appointments."
    end

    def new_or_not
        puts "Are you new to the House? Y/N"
        a = gets.chomp
        if a.upcase == "Y"
            puts "Welcome and let's get you going."
            create_new_account
        elsif a.upcase == "N"
            puts "Welcome back! It must've been good last time~"
            user_log_in
        else
            greet   
        end
    end 

    def user_log_in #should create a variable that holds the value of this logged in user
        puts "Please type in your email address: "
        user_email = gets.chomp
        search_result = Pianist.find_by(log_in_email: user_email)
        second_result =Collaborator.find_by(log_in_email: user_email)
        @logged_in_user = search_result || second_result
        # binding.pry 
        if search_result!= nil
            puts "Password, please"
            user_password = gets.chomp
            if search_result.password == user_password
                puts "#{logged_in_user.name}~ Welcome back!"
                user_menu
            else 
                puts "Something wasn't right. Try it again."
                user_log_in 
            end
        elsif second_result !=nil 
            puts "Password, please"
            user_password = gets.chomp
            if second_result.password == user_password
                puts "Welcome back!"
                user_menu
            else 
                puts "Something wasn't right. Try it again."
                user_log_in 
            end
        else
            puts "Shall we try this again?"
            user_log_in
        end
    end



    def create_new_account 
        puts "Are you a collaborator or a pianist?"
        user_field = gets.chomp 
        if user_field.upcase == "COLLABORATOR"
            puts "Please state your Full Name" 
            user_name = gets.chomp
            new_collaborator_log_in(user_name)
        elsif user_field.upcase == "PIANIST"
            puts "Please state your Full Name" 
            user_name = gets.chomp
            new_pianist_log_in(user_name)
        else
            puts "Please type the entire word."
            create_new_account
        end
    end

    def new_pianist_log_in(user_name)
        new_pianist_info = {name: user_name}
        puts "Your email address?"
        user_email = gets.chomp
        new_pianist_info[:log_in_email] = user_email
        puts "Please set your password between 6 - 12 characters of lowercase letters and numbers:"
        user_password = gets.chomp
        new_pianist_info[:password] = user_password
        # user.save
        Pianist.create(new_pianist_info)
        puts "Now let's log you in~"
        user_log_in 
    end


    def new_collaborator_log_in(user_name)
        collaborator_info = {full_name: user_name}
        puts "Are you an instrumentalist or a vocalist? i/v"
        user_field = gets.chomp 
        if user_field.upcase == "I"
            puts "What is your instrument?"
            user_instrument = gets.chomp
            collaborator_info[:instrument] = user_instrument
            puts "Your email address?"
            user_email = gets.chomp
            collaborator_info[:log_in_email] = user_email
            puts "Please set your password between 6 - 12 characters of lowercase letters and numbers:"
            user_password = gets.chomp
            collaborator_info[:password] = user_password
            Collaborator.create_new_instru_collaborator(collaborator_info)
            puts "Now let's log you in~"
            user_log_in 
          
        elsif user_field.upcase  == "V"
            puts "What is your voice type?"
            user_voice = gets.chomp
            collaborator_info[:voice_type]=user_voice 
            puts "Your email address?"
            user_email = gets.chomp
            collaborator_info[:log_in_email] = user_email
            puts "Please set your password between 6 - 12 characters of lowercase letters and numbers:"
            user_password = gets.chomp
            collaborator_info[:password] = user_password
            Collaborator.create_new_vocal_collaborator(collaborator_info)
            puts "Now let's log you in~"
            user_log_in
            
        else
            greet 
        end 
    end 

    def view_appointments
        if @logged_in_user.class == Pianist
            callabs = @logged_in_user.collaborators 
            if callabs == [ ] 
                puts "These are all current appointments and your name isn't found."
                puts  Appointment.all.map{|app| "#{app.pianist.name} is working with #{app.collaborator.name}."}.sort
            else 
                puts "These are your current collaborators."
                instrumentalists =callabs.select{|each| each.instrument!=nil}
                vocalists = callabs.select{|each| each.voice_type!=nil}
                puts "You are currently working with #{instrumentalists.size + vocalists.size } artists. They are: "
                puts instrumentalists.map{|each|  "#{each.name} is an instrumentalist. Instrument:#{each.instrument}"}.sort 
                puts vocalists.map{|each|  "#{each.name} is an vocalist. Voice type: #{each.voice_type}"}.sort
            end
        elsif @logged_in_user.class == Collaborator 
            pianists = @logged_in_user.pianists   
            if pianists == [ ] 
                puts "These are all current appointments and your name isn't found."
                puts Appointment.all.map{|app| "#{app.pianist.name} is working with #{app.collaborator.name}."}.sort
            else
                puts "Let me show you your pianist(s)."
                puts pianists.map{|each| "Currently, #{each.name} is your pianist."}
            end 
        end     
    end 

    def add_new_pianist
        puts "Didn't you see your pianist's name? Should we invite him/her? Commence invitation:"
        puts "May I have his/her full name?" 
        new_pianist_name = gets.chomp
        puts "What is his/her expertise(vocal/instrumental)?"
        new_pianist_expertise = gets.chomp 
        new_pianist = Pianist.create(name: new_pianist_name, expertise: new_pianist_expertise)
        puts "There, we've taken care of inviting your pianist #{new_pianist.name}. Welcome to the house!"    
        new_pianist
    end

    def add_new_collaborator
        puts "Didn't you see your collaborator's name? Should we invite him/her? Commence invitation:"
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
        new_collaborator 
    end

    # def who_is_working
    #     puts "Which pianist's work load would you like to see? Please type his/her full name [Full Name]."
    #     pianist=gets.chomp
    #     if Pianist.find_by(name: pianist)==nil 
    #         puts "I'm terribly sorry. But that pianist does not work for us yet."
    #     else 
    #         Pianist.find_by(name:pianist).collaborators.map{|each|
    #         puts "#{pianist} is currently working with #{each.name} on #{each.instrumental_repertoire!=nil ? each.instrumental_repertoire : each.vocal_repertoire}"}
    #     end 
    # end

    # def update_experience
    #     puts "Congratulations! Yet another year~ Tell me your Full Name ^_^"
    #     pianist_name = gets.chomp
    #     pianist = Pianist.find_by(name:pianist_name)
    #     if pianist !=nil 
    #         pianist.years_of_experience +=1
    #         pianist.save 
    #         puts "Take care! And best of luck on your future journeys!"
    #     else
    #         puts "Ooops! This pianist does not appear to exist in our book. Until next time~"
    #     end
    # end
end
