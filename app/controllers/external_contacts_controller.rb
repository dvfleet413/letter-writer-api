class ExternalContactsController < ApplicationController
    def index
        set_congregation
        contacts = @congregation.external_contacts
        render json: contacts.to_json(only: [:id, :name, :address, :phone, :lat, :lng])
    end

    def create
        set_congregation
        BulkImportJob.perform_later(external_contacts_params[:contacts], @congregation)
        render json: {message: "ok"}.to_json
    end

    private
        def set_congregation
            @congregation = Congregation.find(params[:congregation_id])
        end

        def external_contacts_params
            params.require(:external_contact).permit(
                :firstName,
                :lastName,
                :phone,
                :address,
                :city,
                :state,
                :zipCode,
                :lng,
                :lat,
                contacts: [:firstName, :lastName, :phone, :address, :city, :state, :zipCode, :lng, :lat]
            )
        end
end