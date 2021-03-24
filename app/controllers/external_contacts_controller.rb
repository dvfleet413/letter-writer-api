class ExternalContactsController < ApplicationController
    def index
        set_congregation
        contacts = @congregation.external_contacts
        render json: contacts.to_json(only: [:id, :name, :address, :phone, :lat, :lng])
    end

    def create
        set_congregation
        params[:contacts].each do |row|
            if row[:zipCode].length == 3
                zipCode = "00#{row[:zipCode]}"
            elsif row[:zipCode].length == 4
                zipCode = "0#{row[:zipCode]}"
            else
                zipCode = row[:zipCode]
            end
            @congregation.external_contacts.create(
                name: "#{row[:firstName]} #{row[:lastName]}",
                phone: row[:phone],
                address: "#{row[:address]}\n#{row[:city]}, #{row[:state]}  #{zipCode}",
                lat: row[:lat],
                lng: row[:lng])
        end
        render json: {message: "ok"}.to_json
    end

    private
        def set_congregation
            @congregation = Congregation.find(params[:congregation_id])
        end

        def external_contacts_params
            params.require(:external_contact).permit(:contacts, :firstName, :lastName, :phone, :address, :city, :state, :zipCode, :lng, :lat)
        end
end
