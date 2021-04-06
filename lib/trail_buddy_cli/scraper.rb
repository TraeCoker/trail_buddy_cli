class Scraper 

    def self.get_data_by_state(state)
        url = URI.parse("https://www.alltrails.com/us/#{state}")
        response = Net::HTTP.get(url)
        data = Nokogiri::HTML(response)
        trails = data.css(".styles-module__trailCard___2oHiP").each do |trail|
            name = trail.css(".styles-module__link___12BPT").text
            location = trail.css(".styles-module__link___3T9FO").text
            
            binding.pry 

        end 
    end 





end 