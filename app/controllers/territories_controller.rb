class TerritoriesController < ApplicationController

    def index
        set_congregation
        territories = @congregation.territories
        render json: territories, each_serializer: TerritoriesSerializer
    end

    def create
        set_congregation
        territory = Territory.new(name: territory_params[:name])
        territory.points.build(territory_params[:points])
        @congregation.territories << territory
        render json: {message: "ok", territory: territory}, status: :ok
    end

    def show
        territory = Territory.find(params[:id])
        # render json: territory.to_json(include: [{points: {only: [:lat, :lng]}}, :dncs], methods: :sorted_assignments, only: :name)
        render json: territory
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
            params.require(:territory).permit(:name, points: [:lng, :lat])
        end
end
