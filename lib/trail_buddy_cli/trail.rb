class Trail 
    
  @@all =[]

    def initialize(trail_hash)
        trail_hash.each do |key, value|
            self.class.attr_accessor(key)
            self.send("#{key}=", value)
        end 
        add_additional_attributes(Scraper.get_individual_trail_data(link))
        save 
    end 

    def add_additional_attributes(attributes_hash)
        attributes_hash.each do |key, value|
            self.class.attr_accessor(key)
            self.send("#{key}=", value)
        end 
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

    def weather
        Weather.all.select{|weather| weather.trail == self}
    end 

end 