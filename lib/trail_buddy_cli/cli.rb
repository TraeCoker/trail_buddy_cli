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
        state = user_input
        validate_input(state)
    end 

    def validate_input(state)
        if VALID_STATES.include?(state)
            get_state_trails(state)
        else 
            puts "Invalid entry."
            puts "Please enter the name of the State you would like to explore today:"
            state = user_input
            validate_input(state)
        end 
    end 

    def get_state_trails(state)
        Scraper.get_data_by_state(state)
        print_state_trails(state)
    end 
        


    def print_state_trails(state)
        state = state.split("-").map{|word| word.capitalize}.join(" ")
        puts "Here are the top rated hiking trails for #{state}:"
        Trail.select_by_state(state).each_with_index do |trail, index|
        puts "#{index + 1}. #{trail.name}"
        end 
    end 


    def user_input 
        gets.strip.downcase
    end 

end 