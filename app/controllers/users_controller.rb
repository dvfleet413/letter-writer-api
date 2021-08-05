class UsersController < ApplicationController
    def create
    end

    private
        def user_params
            params.require(:user).permit(:name, :password, :congregation_id)
        end
end
