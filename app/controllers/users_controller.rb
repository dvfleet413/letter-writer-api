class UsersController < ApplicationController
    def index
        set_congregation
        resp = UsersSerializer.new(@congregation.users).to_serialized_json
        render json: resp
    end

    def create
        set_congregation
        user = User.new(
            name: user_params[:name],
            role: "Admin",
            email: user_params[:email].downcase,
            congregation: @congregation,
            password: SecureRandom.base64(10)
        )
        if user.save
            confirmation_url = "#{ENV["FRONTEND_URL"]}/confirm/#{generate_token({id: user.id})}"
            UserMailer.with(user: user, confirmation_url: confirmation_url).confirmation_email.deliver_later
            render json: UserSerializer.new(user).to_serialized_json
        else
            render json: {"message": "unable to create user"}, status: :bad_request
        end
    end

    def update
        set_congregation
        user = User.find(params[:id])
        user.update(user_params)
        user.save
        render json: UserSerializer.new(user).to_serialized_json
    end

    def confirm
        id = decode_token_and_get_user_id(user_params[:token])
        user = User.find(id)
        user.name = user_params[:name]
        user.password = user_params[:password]
        user.save
        render json: UserSerializer.new(user).to_serialized_json
    end

    private
        def user_params
            params.require(:user).permit(:name, :password, :email, :role, :token)
        end

        def set_congregation
            @congregation = Congregation.find(params[:congregation_id])
        end
end
