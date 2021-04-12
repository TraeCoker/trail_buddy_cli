class Scraper 


    def self.get_data_by_state(state)
        state[" "]= "-" if state.include?(" ")
        url = URI.parse("https://www.alltrails.com/us/#{state}")
        response = Net::HTTP.get(url)
        noko = Nokogiri::HTML(response)
        if redirected?(noko)
            redirected_link = noko.css("a").first.attributes["href"].value
            url = URI.parse(redirected_link)
            response = Net::HTTP.get(url)
            data = Nokogiri::HTML(response)
        else 
            data = noko 
        end 
        
        trails = data.css(".styles-module__trailCard___2oHiP").each do |trail|
            relative_path = trail.css("a").first.attributes["href"].value
            trail_hash = {
                :state => state.split("-").map{|word| word.capitalize}.join(" "),
                :name => trail.css(".styles-module__link___12BPT").text,
                :location => trail.css(".styles-module__link___3T9FO").text,
                :length => trail.css("span.xlate-none").first.text,
                :time_estimate => trail.css("span.xlate-none").last.text,
                :difficulty => trail.css(".styles-module__selected___3fawg").text,
                :link => "https://www.alltrails.com" + relative_path }
                Trail.new(trail_hash)
            end 

    end 


    def self.get_individual_trail_data(trail_link)
        url = URI.parse(trail_link)
        response = Net::HTTP.get(url)
        noko = Nokogiri::HTML(response)
        if redirected?(noko)
            redirected_link = noko.css("a").first.attributes["href"].value
            url = URI.parse(redirected_link)
            response = Net::HTTP.get(url)
            data = Nokogiri::HTML(response)
        else 
            data = noko 
        end 
         

        attributes_hash = {}

        attributes_hash[:overview] = data.css(".line-clamp-4").text if data.css(".line-clamp-4") != nil
        attributes_hash[:elevation_gain] = data.css(".styles-module__detailData___kQ-eK")[1].text if data.css(".styles-module__detailData___kQ-eK") != nil
        attributes_hash[:route_type] = data.css(".styles-module__detailData___kQ-eK")[2].text if data.css(".styles-module__detailData___kQ-eK")[2] != nil
        attributes_hash[:description] = data.css(".styles-module__displayText___17Olo")[0].text if data.css(".styles-module__displayText___17Olo")[0] != nil
        attributes_hash[:facilities] = data.css(".styles-module__displayText___17Olo")[1].text if data.css(".styles-module__displayText___17Olo")[1] != nil
        attributes_hash[:contact] = data.css(".styles-module__displayText___17Olo")[2].text if data.css(".styles-module__displayText___17Olo")[2] != nil  

        attributes_hash 
    end 

    def self.redirected?(noko)
        noko.css("body").text.include?("You are being redirected")
    end 

end 