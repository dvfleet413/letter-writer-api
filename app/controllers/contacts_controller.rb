class ContactsController < ApplicationController
    def index
        set_congregation
        data_axle_service = DataAxleService.new(@cong)

        polygon = polygon_params[:points].map { |point| [point["lat"], point["lng"]] }

        current_contacts = Contact.all.select do |contact|            
            if GPSTools.in_polygon?(polygon, [contact.lat, contact.lng])
                @cong.lang == "eng" ? true : contact.lang == @cong.lang
            else
                false
            end
        end

        current_count = current_contacts.length
        updated_contact_info = data_axle_service.get_count(polygon_params[:points])
        updated_contact_count = updated_contact_info[:count]
        scroll_id = updated_contact_info[:scroll_id]

        if current_count < updated_contact_count && (current_count / updated_contact_count) < 0.9
            contact_results = data_axle_service.get_contacts(scroll_id)

            # Destroy current contacts in polygon and replace them with updated list
            current_contacts.destroy_all if current_count > 0
            contacts = data_axle_service.save_contacts(contact_results)
        else
            contacts = current_contacts
        end

        render json: contacts.to_json, status: :ok
    end

    private
        def set_congregation
            @cong = Congregation.find(params[:congregation_id])
        end

        def polygon_params
            params.require(:path).permit(points: [:lng, :lat])
        end
end
