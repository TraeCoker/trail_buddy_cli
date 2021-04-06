class Area 

    attr_accessor :name, :city, :state, :directions, :lat, :long, :description
    @@all =[]
  
      def initialize(area_hash)
          area_hash.each do |key, value|
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