class DatafinderService
    def initialize(contact)
        @contact = contact
    end

    def append_phone
        data = HTTParty.get("#{ENV["DATAFINDER_URL"]}&d_fullname=#{@contact.name}&d_fulladdr=#{@contact.street}&d_city=#{@contact.city}&d_state=#{@contact.state}", format: :json)
        @contact.phone = data["datafinder"]["results"][0]["Phone"] || nil
        @contact.phone_type = data["datafinder"]["results"][0]["LineType"] 
        @contact.save
        
        @contact
    end

end