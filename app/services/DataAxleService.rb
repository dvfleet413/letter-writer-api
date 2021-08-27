class DataAxleService
    def initialize(congregation_object)
        @cong = congregation_object
    end
    
    def get_count(path)
        # Use ?limit=0 to get count of documents without being charged. Can be useful for comparison when territory is updated
        response = HTTParty.post('https://api.data-axle.com/v1/people/scan?packages=standard_v3&limit=0', options(path))

        return {count: response["count"], scroll_id: response["scroll_id"]}
    end

    def get_contacts(scroll_id)
        contacts = []

        loop do
            response = HTTParty.get("https://api.data-axle.com/v1/people/scan/#{scroll_id}?packages=standard_v3", headers: {"X-AUTH-TOKEN": ENV["DATA_AXLE_API_KEY"]})
            
            break if response.length == 0

            contacts += response
        end

        return contacts
    end

    def save_contacts(contacts)
        # use map so an array of the newly saved Contact objects is returned
        # when this method is called in controller
        contacts.map do |contact|
            Contact.create(
                name: "#{contact["first_name"]} #{contact["last_name"]}",
                phone: contact["phones"] && contact["phones"].length > 0 ? contact["phones"][0] : "Not Available",
                address: "#{contact["street"]}\n#{contact["city"]}, #{contact["state"]}  #{contact["postal_code"]}",
                lat: contact["geocoordinate"]["lat"],
                lng: contact["geocoordinate"]["lon"],
                lang: contact["estimated_language"]
            )
        end
    end

    private
        def options(path)
            if @cong.lang == "eng"
                {
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
                {
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
        end
end