class Weather 
 
    @@all =[]

    def initialize(weather_hash)
        weather_hash.each do |key, value|
            self.class.attr_accessor(key)
            self.send("#{key}=", value)
        end 
        save 
    end 

    def save 
        @@all << self 
    end 

    def self.all 
        @@all 
    end 

end 