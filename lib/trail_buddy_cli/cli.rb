class CLI 

    VALID_STATES = ["alabama", "alaska", "arizona", "arkansas", "california", 
        "colorado", "connecticut", "delaware", "florida", "georgia",
         "hawaii", "idaho", "illinois", "indiana", "iowa", "kansas", "kentucky", "louisiana",
         "maine", "maryland", "massachusetts", "michigan", "minnesota", 
         "mississippi", "missouri", "montana", "nebraska", "nevada", "new hampshire", "new jersey", 
         "new mexico", "new york", "north carolina", "north dakota",
         "ohio", "oklahoma", "oregon", "pennsylvania", "rhode island", 
         "south carolina", "south dakota", "tennessee", "texas", "utah", "vermont", "virgin island", 
         "virginia", "washington", "washington dc", "west virginia", "wisconsin", "wyoming"] 


    def start 
        puts "Hello adventurer! Welcome to Trail Buddy!"
        puts "Please enter the name of the State you would like to explore today:"
        input = user_input
        validate_input(input)
    end 

    def validate_input(input)
        if VALID_STATES.include?(input)
            input[" "]= "-" if input.include?(" ")
            get_state_trails(input)
        else 
            puts "Invalid entry."
            puts "Please enter the name of the State you would like to explore today:"
            input = user_input
            validate_input(input)
        end 
    end 

    def get_state_trails(input)
        Scraper.get_data_by_state(input)
        state = input.capitalize
        print_state_trails(state)
    end 
        


    def print_state_trails(state)
        puts "Here are the top rated hiking trails for #{state}:"
        Trail.select_by_state(state).each_with_index do |trail, index|
        puts "#{index + 1}. #{trail.name}"
        end 
    end 


    def user_input 
        gets.strip.downcase
    end 

end 