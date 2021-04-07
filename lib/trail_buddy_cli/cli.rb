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
        puts "                                                  "
        puts "Here are the top rated hiking trails for #{state}:"
        puts "--------------------------------------------------"
        Trail.select_by_state(state).each_with_index do |trail, index|
        puts "#{index + 1}. #{trail.name} - #{trail.location}"
        puts "                           "
        puts "#{trail.overview}"
        puts "Total time is #{trail.time_estimate.downcase}"
        puts "                           "
        end 
        puts "--------------------------------------------------"
        select_trail
    end 

    def select_trail
        puts "For more information on a trail, please enter the number of the corresponding trail"
        puts "enter 'back' to go back"
        puts "or enter 'exit' to exit"
        input = user_input

        if input.to_i.between?(1,10)
            more_trail_info(input.to_i)
        elsif input == "back"
            puts "              "
            start 
        elsif input == "exit"
            puts "              "
            puts "Happy hiking!"
        else 
            puts "invalid entry. Please try again."
            select_trail
        end 
    end 

    def more_trail_info(input)

    end 

    def user_input 
        gets.strip.downcase
    end 

end 