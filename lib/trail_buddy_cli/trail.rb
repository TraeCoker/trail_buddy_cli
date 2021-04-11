class Trail 
  attr_accessor :state, :name, :location, :length, :time_estimate, :difficulty, :link,
                :overview, :description, :elevation_gain, :route_type, :facilities, :contact  
  @@all =[]

    def initialize(trail_hash)
        trail_hash.each do |key, value|
            self.send("#{key}=", value)
        end 
        add_additional_attributes(Scraper.get_individual_trail_data(link))
        save 
    end 

    def save 
        @@all << self 
    end 

    def self.all 
        @@all
    end 

    def self.select_by_state(state)
        all.select{|trail| trail.state == state}
    end 

    def add_additional_attributes(attributes_hash)
        attributes_hash.each do |key, value|
            self.send("#{key}=", value)
        end 
    end 

    def weather
        API.get_weather_by_city_and_state(self.location, self.state)
    end 


end 