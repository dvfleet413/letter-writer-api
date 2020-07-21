class DncsController < ApplicationController
    def index
        territory = Territory.find_by_id(params[:territory_id])
        if territory
          render json: territory.dncs
        else
          render json: {error: "unable to find territory"}, statuss: :bad_request
        end
    end

    def create
        dnc = Dnc.new({address: params[:dnc], territory_id: params[:territory_id]})
        if dnc.save
            render json: dnc
        else
            render json: {eror: "unable to save"}, status: :bad_request
        end
    end

    def destroy
        dnc = Dnc.find_by_id(params[:id])
        if dnc
            dnc.destroy
            render json: {message: "dnc deleted"}, status: :ok
        else
            render json: {error: "unable to find DNC"}, status: :bad_request
        end
    end
end
