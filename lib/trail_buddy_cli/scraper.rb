class Scraper 

    def self.get_data_by_state(state)
        url = URI.parse("https://www.alltrails.com/us/#{state}")
        response = Net::HTTP.get(url)
        data = Nokogiri::HTML(response)
        trails = data.css(".styles-module__trailCard___2oHiP").each do |trail|
            name = trail.css(".styles-module__link___12BPT").text
            location = trail.css(".styles-module__link___3T9FO").text
            length = trail.css("span.xlate-none").first.text
            time_estimate = trail.css("span.xlate-none").last.text
            difficulty = trail.css(".styles-module__selected___3fawg").text
            relative_path = trail.css("a").first.attributes["href"].value
            link = "https://www.alltrails.com" + relative_path

            binding.pry 

        end 
    end 





end 