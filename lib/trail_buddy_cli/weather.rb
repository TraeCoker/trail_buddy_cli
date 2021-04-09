class ApiForWeather 

def get_weather 
    key = ENV["API_KEY"]
    results = Geocoder.search("Springfield, Missouri")
    coordinates = results.first.coordinates
    #binding.pry 

url = URI("https://community-open-weather-map.p.rapidapi.com/forecast/daily?lat=#{coordinates[0]}&lon=#{coordinates[1]}&cnt=7&units=imperial")

http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

request = Net::HTTP::Get.new(url)
request["x-rapidapi-key"] = key 
request["x-rapidapi-host"] = 'community-open-weather-map.p.rapidapi.com'

response = http.request(request)
forecast = JSON.parse(response.read_body)



end  



end 