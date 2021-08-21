class UserMailer < ApplicationMailer
    default from: 'noreply@territorycounter.com'

    def confirmation_email
        @user = params[:user]
        @confirmation_url = params[:confirmation_url]
        mail(to: @user.email, subject: 'Welcome to My Awesome Site')
    end
end
