class Trail 
  attr_accessor :name, :city, :state 
  @@all =[]

    def initialize(trail_hash)
        trail_hash.each do |key, value|
            self.send("#{key}=", value) if self.respond_to?("#{key}")
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