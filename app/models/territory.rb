class Territory < ApplicationRecord
    has_many :points
    has_many :dncs
    has_many :assignments,  -> { order "checked_out asc" }
    belongs_to :congregation

    def polygon
        self.points.map {|point| [point["lat"], point["lng"]]}
    end

    def data_axle_polygon
        self.points.map{|point| {lat: point.lat, lon: point.lng}}
    end

    def sorted_assignments
        self.assignments.order(:checked_out)
    end

    def contacts
        contacts = self.congregation.api_access ? self.api_contacts : self.external_contacts
        contacts
    end

    def api_contacts
        polygon = self.polygon
        cong = self.congregation
        geometry = GPSTools::Geometry.new
        max_lat = geometry.max_lat(polygon)
        min_lat = geometry.min_lat(polygon)
        max_lng = geometry.max_lng(polygon)
        min_lng = geometry.min_lng(polygon)
        initial_filtered_contacts = Contact.all.select{|contact| contact.lat <= max_lat && contact.lat >= min_lat && contact.lng <= max_lng && contact.lng >= min_lng}
        data_axle_service = DataAxleService.new(cong)
        current_contacts = initial_filtered_contacts.select do |contact|            
            if GPSTools.in_polygon?(polygon, [contact.lat, contact.lng])
                cong.lang == "eng" ? true : contact.lang == cong.lang
            else
                false
            end
        end
        current_count = current_contacts.length
        updated_contact_info = data_axle_service.get_count(self.data_axle_polygon)
        updated_contact_count = updated_contact_info[:count]
        scroll_id = updated_contact_info[:scroll_id]
        if current_count < updated_contact_count && (current_count.to_f / updated_contact_count.to_f) < 0.9
            contact_results = data_axle_service.get_contacts(scroll_id)
            # Destroy current contacts in polygon and replace them with updated list
            if current_count > 0
                # This could be more performant by getting an ActiveRecord::Relation
                # and using #destroy_all instead of getting an Array
                current_contacts.each{|contact| contact.destroy}
            end
            contacts = data_axle_service.save_contacts(contact_results)
            # Append phone numbers to new contacts if congregation is enrolled
            if cong.phone_api_access
                contacts.each do |contact|
                    datafinder_service = DatafinderService.new(contact)
                    datafinder_service.append_phone
                end
            end
            contacts = Contact.all.select do |contact|            
                if GPSTools.in_polygon?(self.polygon, [contact.lat, contact.lng])
                    cong.lang == "eng" ? true : contact.lang == cong.lang
                else
                    false
                end
            end
        else
            contacts = current_contacts
        end
    end
    
    def external_contacts
        polygon = self.polygon
        cong = self.congregation
        geometry = GPSTools::Geometry.new
        max_lat = geometry.max_lat(polygon)
        min_lat = geometry.min_lat(polygon)
        max_lng = geometry.max_lng(polygon)
        min_lng = geometry.min_lng(polygon)
        initial_filtered_contacts = ExternalContact.all.select{|contact| contact.lat <= max_lat && contact.lat >= min_lat && contact.lng <= max_lng && contact.lng >= min_lng}
        initial_filtered_contacts.select do |contact|            
            if GPSTools.in_polygon?(polygon, [contact.lat, contact.lng])
                cong.lang == "eng" ? true : contact.lang == cong.lang
            else
                false
            end
        end
    end
end
