class Trail 
  attr_accessor :state, :name, :location, :length, :time_estimate, :difficulty, :link 
  @@all =[]

    def initialize(trail_hash)
        trail_hash.each do |key, value|
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