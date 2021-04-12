#API is used to get weather data for individual trails 
class API

    def self.get_weather_by_trail(trail)
        key = ENV["API_KEY"]
        results = Geocoder.search("#{trail.location}, #{trail.state}")
        coordinates = results.first.coordinates
    

        url = URI("https://community-open-weather-map.p.rapidapi.com/forecast/daily?lat=#{coordinates[0]}&lon=#{coordinates[1]}&cnt=7&units=imperial")

        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE

        request = Net::HTTP::Get.new(url)
        request["x-rapidapi-key"] = key 
        request["x-rapidapi-host"] = 'community-open-weather-map.p.rapidapi.com'

        response = http.request(request)
        data = JSON.parse(response.read_body)
        
        i = 0 
        forecast_array = data["list"].map do |day|
            days = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday']
            hash = {}
            
            hash[:trail] = trail
            hash[:day] = days[Time.now.wday + i < 7 ? Time.now.wday + i : 0]
            hash[:min_temp] = day["temp"]["min"].to_i
            hash[:max_temp] = day["temp"]["max"].to_i
            hash[:description] = day["weather"][0]["description"]
            hash[:humidity] = day["humidity"]

            i += 1
            hash 
            Weather.new(hash)
        end 
    end  

end 