class CLI 

    def start 
        puts "Hello adventurer! Welcome to Trail Buddy!"
        puts "Please enter the State you would like to search for trails in:"
        user_input
    end 

    def user_input 
        gets.strip
    end 

end 