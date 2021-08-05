class CongregationsController < ApplicationController
    def create
        cong = Congregation.new(congregation_params)
        if cong.save()
            user = cong.users.build(user_params)
            render json: cong
        else
            render json: {error: "unable to save"}, status: :bad_request
        end
    end

    private
        def congregation_params
            params.require(:congregation).permit(:name, :api_access)
        end

        def user_params
            params.require(:user).permit(:name, :password, :congregation_id)
        end
end
