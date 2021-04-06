class Trails 
  attr_accessor :name, :city, :state 
  @@all =[]

    def initialize(trail_hash)

    end 

    def save 
        @@all << self 
    end 

    def self.all 
        @@all
    end 



end 