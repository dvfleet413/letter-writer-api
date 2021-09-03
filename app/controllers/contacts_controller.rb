class ContactsController < ApplicationController
    def index
        set_congregation
        set_territory

        if @territory.congregation != @cong
            render json: {"message": "territory does not belong to congregation"}, status: :unauthorized
        end

        data_axle_service = DataAxleService.new(@cong)

        current_contacts = Contact.all.select do |contact|            
            if GPSTools.in_polygon?(@territory.polygon, [contact.lat, contact.lng])
                @cong.lang == "eng" ? true : contact.lang == @cong.lang
            else
                false
            end
        end

        current_count = current_contacts.length
        updated_contact_info = data_axle_service.get_count(@territory.data_axle_polygon)
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
            if @cong.phone_api_access
                contacts.each do |contact|
                    datafinder_service = DatafinderService.new(contact)
                    datafinder_service.append_phone
                end
            end

            contacts = Contact.all.select do |contact|            
                if GPSTools.in_polygon?(@territory.polygon, [contact.lat, contact.lng])
                    @cong.lang == "eng" ? true : contact.lang == @cong.lang
                else
                    false
                end
            end
        else
            contacts = current_contacts
        end

        render json: contacts.to_json, status: :ok
    end

    private
        def set_congregation
            @cong = Congregation.find(params[:congregation_id])
        end

        def set_territory
            @territory = Territory.find(params[:territory_id])
        end
end
