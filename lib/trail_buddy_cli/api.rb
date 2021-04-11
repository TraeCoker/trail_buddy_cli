#API is used to get weather data for individual trails 
class API

def self.get_weather_by_city_and_state(city, state)
    key = ENV["API_KEY"]
    results = Geocoder.search("#{city}, #{state}")
    coordinates = results.first.coordinates
 

    url = URI("https://community-open-weather-map.p.rapidapi.com/forecast/daily?lat=#{coordinates[0]}&lon=#{coordinates[1]}&cnt=7&units=imperial")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(url)
    request["x-rapidapi-key"] = key 
    request["x-rapidapi-host"] = 'community-open-weather-map.p.rapidapi.com'

    response = http.request(request)
    forecast = JSON.parse(response.read_body)
    binding.pry 


end  



end 