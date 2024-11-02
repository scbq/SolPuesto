class RegistrationMailer < ApplicationMailer
  def registration_request_email
    @name = params[:name]
    @message = params[:message]
    @user_email = params[:email]

    mail(to: ENV["ESTEBAN_EMAIL"], subject: "Nueva Solicitud de Registro de #{@name}")
  end
end
