class UsersController < ApplicationController
    def index
        set_congregation
        resp = UsersSerializer.new(@congregation.users).to_serialized_json
        render json: resp
    end

    def create
        set_congregation
        user = User.new(user_params)
        user.congregation = @congregation
        user.password = SecureRandom.base64(10)
        if user.save!
            render json: UserSerializer.new(user).to_serialized_json
        else
            render json: {"message": "unable to create user"}, status: :bad_request
        end
    end

    private
        def user_params
            params.require(:user).permit(:name, :password, :email, :role)
        end

        def set_congregation
            @congregation = Congregation.find(params[:congregation_id])
        end
end
