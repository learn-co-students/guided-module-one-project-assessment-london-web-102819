 #!/usr/bin/env ruby
require_relative '../config/environment.rb'
cli = CommandLineInterface.new

cli.greet 

cli.new_or_not

cli.your_field

if cli.user_collaborator == true
    cli.add_new_pianist
elsif cli.user_pianist == true
    cli.add_new_collaborator
end

cli.who_is_working 

puts "Has it been another year? How time flies! Let's update your profile,pianist!
        Collaborators please look the other way <--"
cli.update_experience 




