class CLI 

    def start 
        puts "Hello adventurer! Welcome to Trail Buddy!"
        puts "Please enter the name of the State you would like to explore today:"
        input = user_input
        Scraper.get_data_by_state(input)
        binding.pry 
    end 

    def user_input 
        gets.strip.downcase
    end 

end 