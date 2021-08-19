class SubscriptionsController < ApplicationController
    def create
        set_congregation
        subscription = Subscription.new
        subscription.creation_date = DateTime.now

        @cong.subscription = subscription
    end

    def update

    end

    private
        def set_congregation
            @cong = Congregation.find(params[:congregation_id])
        end

        def subscription_params
            params.require(:subscription).permit(:payment_method_id)
        end
end
