class CongregationsController < ApplicationController
    def create
        cong = Congregation.new(congregation_params)
        if cong.save()
            render json: cong
        else
            render json: {error: "unable to save"}, status: :bad_request
        end
    end

    private
        def congregation_params:
            params.require(:congregation).permit(:name, :api_access)
        end
end
