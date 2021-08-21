class SubscriptionsController < ApplicationController
    def create
        set_congregation

        Stripe::PaymentMethod.attach(
            subscription_params[:payment_method_id],
            {customer: @cong.stripe_customer_id}
        )

        Stripe::Customer.update(
            @cong.stripe_customer_id,
            invoice_settings: {
                default_payment_method: subscription_params[:payment_method_id]
            }
        )

        stripe_subscription = Stripe::Subscription.create({
            customer: @cong.stripe_customer_id,
            items: [
                {price: subscription_params[:price_id]}
           ] 
        })

        @cong.subscription = Subscription.create({
            creation_date: DateTime.now,
            stripe_id: stripe_subscription.id,
            current_period_end: DateTime.strptime(stripe_subscription.current_period_end.to_s, "%s"),
            cancel_at_period_end: stripe_subscription.cancel_at_period_end,
            price: stripe_subscription.items.data[0].price.unit_amount,
            price_id: stripe_subscription.items.data[0].price.id,
            product_id: stripe_subscription.items.data[0].price.product
        })
        
        if @cong.save
            UserMailer.with(cong: @cong).new_account_email.deliver_later
            render json: @cong.subscription
        else
            render json: {"message": "unable to create subscription"}, status: :bad_request
        end
    end

    def update

    end

    private
        def set_congregation
            @cong = Congregation.find(params[:congregation_id])
        end

        def subscription_params
            params.require(:subscription).permit(:payment_method_id, :price_id)
        end
end
