class DncsController < ApplicationController
    def index
        if params[:territory_id]
            territory = Territory.find_by_id(params[:territory_id])
            if territory
                render json: territory.dncs
            else
                render json: {error: "unable to find territory"}, status: :bad_request
            end
        else
            render json: Dnc.all, include: :territory
        end
    end

    def create
        if params[:territory_id]
            dnc = Dnc.new(dnc_params)
            if dnc.save
                render json: dnc
            else
                render json: {eror: "unable to save"}, status: :bad_request
            end
        else
            BulkDncImportJob.perform_later(dnc_params[:dncs])
            render json: {message: "ok"}
        end
    end

    def update
        dnc = Dnc.find_by_id(params[:id])
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
            params.require(:dnc).permit(:address, :date, :publisher, :name, :notes, :territory_id, dncs: [:address, :date, :territoryName])
        end
end
