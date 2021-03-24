class ExternalContactsController < ApplicationController
    def index
        set_congregation
        contacts = congregation.external_contacts
        render json: contacts.to_json(only: [:id, :name, :address, :phone, :lat, :lng])
    end

    private
        def set_congregation
            @congregation = Congregation.find(params[:congregation_id])
        end

        def external_contacts_params
            params.require(:external_contact).permit(:name, :address, :phone, :lng, :lat)
        end
end
