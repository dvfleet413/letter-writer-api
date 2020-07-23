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
        dnc = Dnc.new(dnc_params)
        if dnc.save
            render json: dnc
        else
            render json: {eror: "unable to save"}, status: :bad_request
        end
    end

    def update
        dnc = Dnc.find_by_id(params[:id])
        binding.pry
        if dnc.update(dnc_params)
            render json: dnc, status: :ok
        else 
            render json: {error: "unable to save"}, status: :bad_request
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

    private
        def dnc_params
            params.require(:dnc).permit(:address, :date, :territory_id)
        end
end
