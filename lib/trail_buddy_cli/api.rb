class API 

    def self.get_data
        url = URI("https://trailapi-trailapi.p.rapidapi.com/?q-activities_activity_type_name_eq=hiking&q-country_cont=United%20States%20&limit=1200")

        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE

        key = ENV["API_KEY"]
        request = Net::HTTP::Get.new(url)
        request["x-rapidapi-key"] = key 
        request["x-rapidapi-host"] = 'trailapi-trailapi.p.rapidapi.com'

        response = http.request(request)
        array = JSON.parse(response.read_body)["places"]

    end 




end 