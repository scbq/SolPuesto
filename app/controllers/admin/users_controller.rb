class Admin::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_admin!

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.password = Devise.friendly_token[0, 20] # Genera una contraseña temporal

    if @user.save
      RegistrationMailer.with(user: @user).user_created_email.deliver_now
      redirect_to new_admin_user_path, notice: "Usuario creado y notificado con éxito."
    else
      render :new, alert: "Hubo un problema al crear el usuario."
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :role)
  end

  def ensure_admin!
    if user_signed_in?
      redirect_to root_path, alert: "No tienes permiso para realizar esta acción." unless current_user.admin?
    else
      redirect_to new_user_session_path, alert: "Debes iniciar sesión como administrador para acceder a esta página."
    end
  end
end
