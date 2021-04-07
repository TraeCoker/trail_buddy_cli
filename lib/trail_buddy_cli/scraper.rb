class Scraper 


    def self.get_data_by_state(state)
        state[" "]= "-" if state.include?(" ")
        url = URI.parse("https://www.alltrails.com/us/#{state}")
        response = Net::HTTP.get(url)
        data = Nokogiri::HTML(response)
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
        data = Nokogiri::HTML(response)

        #binding.pry 
        attributes_hash = {}
        attributes_hash[:overview] = data.css(".line-clamp-4").text if data.css(".line-clamp-4") != nil
        #:elevation_gain => data.css(".styles-module__detailData___kQ-eK")[1].text if data.css(".styles-module__detailData___kQ-eK") != nil,
        #:route_type => data.css(".styles-module__detailData___kQ-eK")[2].text if data.css(".styles-module__detailData___kQ-eK")[2] != nil,
        #:description => data.css(".styles-module__displayText___17Olo")[0].text if data.css(".styles-module__displayText___17Olo")[0] != nil,
        #:facilities => data.css(".styles-module__displayText___17Olo")[1].text if data.css(".styles-module__displayText___17Olo")[1] != nil,
        #:contact => data.css(".styles-module__displayText___17Olo")[2].text if data.css(".styles-module__displayText___17Olo")[2] != nil  
        attributes_hash 






    end 







end 