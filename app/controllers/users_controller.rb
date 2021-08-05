class UsersController < ApplicationController
    def create
        set_congregation
        @congregation.users.build(user_params)
    end

    private
        def user_params
            params.require(:user).permit(:name, :password, :congregation_id)
        end

        def set_congregation
            @congregation = Congregation.find(params[:congregation_id])
        end
end
