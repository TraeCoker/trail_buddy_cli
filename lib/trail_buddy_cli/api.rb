class API 

    def self.get_data
        url = URI("https://trailapi-trailapi.p.rapidapi.com/?limit=1200")

        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE

        key = ENV["API_KEY"]
        request = Net::HTTP::Get.new(url)
        request["x-rapidapi-key"] = key 
        request["x-rapidapi-host"] = 'trailapi-trailapi.p.rapidapi.com'

        response = http.request(request)
        array = JSON.parse(response.read_body)["places"]

        united_states_trails = array.select do |trail| 
            trail["country"] == "United States"
        end 
        
        united_states_trails.each do |area|
            binding.pry 
            Area.new(area)
        end 
 
        binding.pry 

        #for weeding out hiking trails
        # trail["activities"].select{|trail| trail["activity_type_name"] == "hiking"}

    end 




end 