class ContactsController < ApplicationController
    def index
        contacts = Contact.all
        render json: contacts.to_json(only: [:name, :address, :phone, :lat, :lng])
    end
end
