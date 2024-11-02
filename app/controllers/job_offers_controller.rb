class JobOffersController < ApplicationController
  # Asegura que el usuario esté autenticado para todas las acciones
  before_action :authenticate_user!
  # Limita ciertas acciones solo al administrador
  before_action :authorize_admin, only: [ :new, :create, :edit, :update, :destroy ]
  # Carga la oferta antes de acciones específicas
  before_action :set_job_offer, only: [ :show, :edit, :update, :destroy ]

  # GET /job_offers or /job_offers.json
  def index
    @job_offers = JobOffer.all
  end

  # GET /job_offers/1 or /job_offers/1.json
  def show
  end

  # GET /job_offers/new
  def new
    @job_offer = JobOffer.new
  end

  # POST /job_offers or /job_offers.json
  def create
    @job_offer = JobOffer.new(job_offer_params)
    @job_offer.user = current_user # Asigna automáticamente el usuario actual (Esteban)

    respond_to do |format|
      if @job_offer.save
        format.html { redirect_to @job_offer, notice: "Job offer was successfully created." }
        format.json { render :show, status: :created, location: @job_offer }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @job_offer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /job_offers/1 or /job_offers/1.json
  def update
    respond_to do |format|
      if @job_offer.update(job_offer_params)
        format.html { redirect_to @job_offer, notice: "Job offer was successfully updated." }
        format.json { render :show, status: :ok, location: @job_offer }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @job_offer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /job_offers/1 or /job_offers/1.json
  def destroy
    @job_offer.destroy!
    respond_to do |format|
      format.html { redirect_to job_offers_path, status: :see_other, notice: "Job offer was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    # Autorización para limitar las acciones a solo el administrador
    def authorize_admin
      redirect_to root_path, alert: "No tienes permiso para realizar esta acción." unless current_user&.admin?
    end

    # Usa callbacks para configurar la oferta
    def set_job_offer
      @job_offer = JobOffer.find(params[:id])
    end

    # Solo permite parámetros específicos
    def job_offer_params
      params.require(:job_offer).permit(:title, :description)
    end
end
