class RegistrationMailer < ApplicationMailer
  default to: "esteban@example.com" # Cambia a la dirección de Esteban

  def registration_request_email
    @name = params[:name]
    @user_email = params[:email]
    @message = params[:message]

    mail(subject: "Nueva Solicitud de Registro de #{@name}")
  end
end
