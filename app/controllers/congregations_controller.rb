class CongregationsController < ApplicationController
    def create
        cong = Congregation.new(congregation_params)

        stripe_customer = Stripe::Customer.create({
            name: congregation_params[:name],
            email: user_params[:email]
        })
        
        cong.stripe_customer_id = stripe_customer.id

        if cong.save
            user = User.new(user_params)
            user.congregation = cong
            user.password = SecureRandom.base64(10)
            user.role = "Admin"
            if user.save!
                confirmation_url = "#{ENV["FRONTEND_URL"]}/confirm/#{generate_token({id: user.id})}"
                UserMailer.with(user: user, confirmation_url: confirmation_url).confirmation_email.deliver_later
                
                if !cong.api_access
                    UserMailer.with(cong: @cong).new_account_email_email.deliver_later
                end

                render json: cong
            else
                render json: {"message": "unable to create user"}, status: :bad_request
            end
        else
            render json: {"message": "unable to save"}, status: :bad_request
        end
    end

    private
        def congregation_params
            params.require(:congregation).permit(:name, :api_access)
        end

        def user_params
            params.require(:user).permit(:name, :email)
        end
end
