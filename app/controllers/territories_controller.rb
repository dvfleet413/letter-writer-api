class TerritoriesController < ApplicationController

    def index
        territories = Territory.all
        render json: territories.to_json(only: [:id, :name])
    end

    def show
        territory = Territory.find(params[:id])
        render json: territory.to_json(include: {points: {only: [:lat, :lng]}}, only: :name)
    end
end
