class TerritoriesController < ApplicationController

    def index
        territories = Territory.all
        render json: territories.to_json(only: [:id, :name])
    end

    def show
        territory = Territory.find(params[:id])
        render json: territory.to_json(include: {points: {only: [:lat, :lng]}}, only: :name)
    end

    def update
        set_congregation
        set_territory
        if @territory.congregation != @congregation
            render json: {message: "Not authorized to update this territory"}, status: :unauthorized
        else
            @territory.points.destroy_all
            @territory.points.build(territory_params[:points])
            @territory.save
            render json: {message: "ok"}, status: :ok
        end
    end

    private
        def set_congregation
            @congregation = Congregation.find(params[:congregation_id])
        end

        def set_territory
            @territory = Territory.find(params[:id])
        end

        def territory_params
            params.require(:territory).permit(points: [:lng, :lat])
        end
end
