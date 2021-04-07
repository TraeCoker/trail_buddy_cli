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







end 