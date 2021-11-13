class SessionsController < ApplicationController
    def create
        @user = User.find_by(email: params[:username])

        if @user && @user.authenticate(params[:password])
            token = generate_token({id: @user.id})
            resp = {
                user: UserSerializer.new(@user).to_serialized_json,
                jwt: token
            }
            render json: resp
        elsif @user && !@user.authenticate(params[:password])
            render json: {error: "Incorrect password, please try again"}, status: :unauthorized
        elsif !@user
            render json: {error: "Unable to find username, please try again"}, status: :unauthorized
        else
            render json: {error: "Unable to login, please try again"}, status: :unauthorized
        end
    end

    def get_current_user
        render json: { user: UserSerializer.new(logged_in_user).to_serialized_json }, status: :ok
    end
end
