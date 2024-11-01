class ApplicationMailer < ActionMailer::Base
  default from: "felipe.aguilera.fuentealba@gmail.com"
  layout "mailer"

  def new_application_notification(application)
    @application = application
    @admin_email = "faaf6@hotmail.com"
    mail(to: @admin_email, subject: "Nueva Postulación Recibida")
  end
end
