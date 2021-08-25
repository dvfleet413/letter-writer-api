class DataAxleService
    def initialize(congregation_object)
        @cong = congregation_object
    end
    
    def get_count(path)
        if @cong.lang == "eng"
            options = {
                headers: {
                    "X-AUTH-TOKEN": ENV["DATA_AXLE_API_KEY"]
                },
                body: {
                    filter: {
                        relation: "geo_polygon",
                        value: path
                    }
                }.to_json.gsub("lng", "lon")
            }
        else
            options = {
                headers: {
                    "X-AUTH-TOKEN": ENV["DATA_AXLE_API_KEY"]
                },
                body: {
                    filter: {
                        connective: "and",
                        propositions: [
                            {
                                relation: "geo_polygon",
                                value: path
                            },
                            {
                                relation: "equals",
                                attribute: "estimated_language",
                                value: @cong.lang
                            }
                        ]
                    } 
                }.to_json.gsub("lng", "lon")
            }
        end

        # Use ?limit=0 to get count of documents without being charged. Can be useful for comparison when territory is updated
        response = HTTParty.get('https://api.data-axle.com/v1/people/search?packages=standard_v3&limit=0', options)
        binding.pry
        return response["count"]
    end

    def get_contacts(path)
        options = {
            headers: {
                "X-AUTH-TOKEN": ENV["DATA_AXLE_API_KEY"]
            },
            body: {
                filter: {
                    relation: "geo_polygon",
                    value: path
                } 
            }.to_json.gsub("lng", "lon")
        }

        response = HTTParty.get('https://api.data-axle.com/v1/people/search?packages=standard_v3', options)

        return response["documents"]
    end

    def save_contacts(contacts)
        # use map so an array of the newly saved Contact objects is returned
        # when this method is called in controller
        binding.pry
        contacts.map do |contact|
            Contact.create(
                name: "#{contact["first_name"]} #{contact["last_name"]}",
                phone: row[:phone],
                address: "#{contact["street"]}\n#{contact["city"]}, #{contact["state"]}  #{contact["postal_code"]}",
                lat: contact["geocoordinate"]["lat"],
                lng: contact["geocoordinate"]["lon"],
                lang: contact["estimated_language"]
            )
        end
    end
end