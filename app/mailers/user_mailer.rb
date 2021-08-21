class UserMailer < ApplicationMailer
    default from: 'noreply@territorycounter.com'

    def confirmation_email
        @user = params[:user]
        @confirmation_url = params[:confirmation_url]
        mail(to: @user.email, subject: 'Welcome to The Territory Counter')
    end

    def new_account_email
        @cong = params[:cong]
        mail(to: "dvfleet413@gmail.com", subject: "New Territory Counter Account")
    end
end
