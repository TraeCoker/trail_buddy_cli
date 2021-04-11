class Weather 
    attr_accessor :trail, :day, :min_temp, :max_temp, :description, :humidity 
    @@all =[]

    def initialize(weather_hash)
        weather_hash.each do |key, value|
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