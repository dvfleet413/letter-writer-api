class DncsController < ApplicationController
    def index
      
    end

    def create
        dnc = Dnc.new({address: params[:dnc], territory_id: params[:territory_id]})
        if dnc.save
            render json: dnc
        else
            render json: {eror: "unable to save"}, status: :bad_request
        end
    end

end
