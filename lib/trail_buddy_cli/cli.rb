class CLI 
    attr_accessor :current_state, :current_trail 

    VALID_STATES = ["alabama", "alaska", "arizona", "arkansas", "california", 
        "colorado", "connecticut", "delaware", "florida", "georgia",
         "hawaii", "idaho", "illinois", "indiana", "iowa", "kansas", "kentucky", "louisiana",
         "maine", "maryland", "massachusetts", "michigan", "minnesota", 
         "mississippi", "missouri", "montana", "nebraska", "nevada", "new hampshire", "new jersey", 
         "new mexico", "new york", "north carolina", "north dakota",
         "ohio", "oklahoma", "oregon", "pennsylvania", "rhode island", 
         "south carolina", "south dakota", "tennessee", "texas", "utah", "vermont", 
         "virginia", "washington", "washington dc", "west virginia", "wisconsin", "wyoming"] 


    def start 
        system "clear"
        hello 
        puts ""
        puts "Hello adventurer! Welcome to Trail Buddy!"
        puts ""
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
        @current_state = state.split(" ").map{|word| word.capitalize}.join(" ")

        Scraper.get_data_by_state(state) if !duplicate?(state)
        print_state_trails
    end 
        


    def print_state_trails 
        system "clear"
        puts ""                                                  
        puts "Here are the top rated hiking trails for #{current_state}:"
        puts "--------------------------------------------------"
        Trail.select_by_state(current_state).each_with_index do |trail, index|
        puts "#{index + 1}. #{trail.name} - #{trail.location}"
        puts ""
        puts "#{trail.overview}"
        puts "Total time is #{trail.time_estimate.downcase}"
        puts ""
        end 
        puts "--------------------------------------------------"
        select_trail
    end 

    def select_trail
        puts "For more information on a trail, please enter the number of the corresponding trail"
        puts "To explore a new state, enter 'new'"
        puts "To exit, enter 'exit'"
        input = user_input

        if input.to_i.between?(1,10)
            more_trail_info(input.to_i)
        elsif input == "new"
            puts ""
            start 
        elsif input == "exit"
            puts ""
            puts "Happy hiking!"
        else 
            puts ""
            puts "invalid entry. Please try again."
            select_trail
        end 
    end 

    def more_trail_info(input)
        system "clear"
        @current_trail = Trail.select_by_state(current_state)[input -1]
        puts ""             
        puts ""
        puts "#{current_trail.name} - #{current_trail.location}, #{current_state}"
        puts "#{current_trail.length} - #{current_trail.time_estimate}"
        puts "Difficulty: #{current_trail.difficulty}"
        puts "Elevation gain: #{current_trail.elevation_gain}"
        puts "route type: #{current_trail.route_type}"
        puts "---------------------------------------------------"
        current_trail.description != nil ? (puts "#{current_trail.description}") : (puts "#{current_trail.overview}")
        puts "---------------------------------------------------"
        puts "Facilities and contact information:"
        puts ""
        puts "#{current_trail.facilities}" 
        puts ""
        puts "#{current_trail.contact}" 
        menu 
    end 

    def menu 
        puts "" 
        puts "-To view the weather forecast for this area, enter 'weather'"
        puts "-To return to #{current_state} trails, enter 'back'"
        puts "-To explore a new state, enter 'new'"
        puts "-To exit, enter 'exit'"

        input = user_input
        if input == "weather"
            puts ""
            get_weather
            print_weather 
        elsif input == "back"
            print_state_trails
        elsif input == "new"
            puts ""
            start 
        elsif input == "exit"
            #puts ""
            #puts "Happy hiking!"
            goodbye
        else 
            puts ""
            puts "invalid entry! Please try again."
            menu 
        end 
    end 

    def get_weather
        API.get_weather_by_trail(current_trail) 
    end 

    def print_weather 
        puts ""
        puts "----------------------------------------"
        current_trail.weather.each do |day|
        puts "#{day.day}"
        puts ""
        puts "#{day.description}"
        puts "High: #{day.max_temp}°"
        puts "Low: #{day.min_temp}°"
        puts "Humidity: #{day.humidity}%"
        puts '_____________________'
        end 
        puts "----------------------------------------"
        weather_menu 
    end
    
    def weather_menu 
        puts "" 
        puts "-To return to #{current_state} trails, enter 'back'"
        puts "-To explore a new state, enter 'new'"
        puts "-To exit, enter 'exit'"

        input = user_input
        if input == "back"
            print_state_trails
        elsif input == "new"
            puts ""
            start 
        elsif input == "exit"
            #puts ""
            #puts "Happy hiking!"
            goodbye 
        else 
            puts ""
            puts "invalid entry! Please try again."
            menu 
        end 
    end 

    def duplicate?(state)
        Trail.all.detect{|trail| trail.state == current_state} ? true :false 
    end 

    def user_input 
        gets.strip.downcase
    end 

    def hello 
        puts <<-'EOF'
        ████████╗██████╗░░█████╗░██╗██╗░░░░░  ██████╗░██╗░░░██╗██████╗░██████╗░██╗░░░██╗
        ╚══██╔══╝██╔══██╗██╔══██╗██║██║░░░░░  ██╔══██╗██║░░░██║██╔══██╗██╔══██╗╚██╗░██╔╝
        ░░░██║░░░██████╔╝███████║██║██║░░░░░  ██████╦╝██║░░░██║██║░░██║██║░░██║░╚████╔╝░
        ░░░██║░░░██╔══██╗██╔══██║██║██║░░░░░  ██╔══██╗██║░░░██║██║░░██║██║░░██║░░╚██╔╝░░
        ░░░██║░░░██║░░██║██║░░██║██║███████╗  ██████╦╝╚██████╔╝██████╔╝██████╔╝░░░██║░░░
        ░░░╚═╝░░░╚═╝░░╚═╝╚═╝░░╚═╝╚═╝╚══════╝  ╚═════╝░░╚═════╝░╚═════╝░╚═════╝░░░░╚═╝░░░
        EOF
    end 

    def goodbye 
        system "clear"
        puts "Happy Hiking!".each_char {|c| putc c ; sleep 0.05; $stdout.flush }
        sleep 3
        system "clear"

    end 


end 