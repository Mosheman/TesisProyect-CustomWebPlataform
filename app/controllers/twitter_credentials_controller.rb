class TwitterCredentialsController < ApplicationController
  before_action :set_twitter_credential, only: [:show, :edit, :update, :destroy]

  # GET /twitter_credentials
  # GET /twitter_credentials.json
  def index
    @twitter_credential = current_user.twitter_credential
  end

  # GET /twitter_credentials/1
  # GET /twitter_credentials/1.json
  def show    
    redirect_to settings_index_path
  end

  # GET /twitter_credentials/new
  def new
    current_user.twitter_credential = TwitterCredential.new
  end

  # GET /twitter_credentials/1/edit
  def edit
    redirect_to settings_index_path
  end

  # POST /twitter_credentials
  # POST /twitter_credentials.json
  def create
    current_user.twitter_credential = TwitterCredential.new(twitter_credential_params) 
    @twitter_credential = current_user.twitter_credential

    respond_to do |format|
      if @twitter_credential.save
        format.html { redirect_to settings_index_path, notice: 'Las credenciales de Twitter fueron correctamente creadas.' }
        format.json { render :show, status: :created, location: @twitter_credential }
      else
        flash[:error] = "No se pudieron crear las credenciales. Debe llenar los campos obligatorios."
        format.html { redirect_to settings_index_path }
        format.json { render json: @twitter_credential.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /twitter_credentials/1
  # PATCH/PUT /twitter_credentials/1.json
  def update
    respond_to do |format|
      if @twitter_credential.update(twitter_credential_params)
        format.html { redirect_to settings_index_path, notice: 'Las credenciales de Twitter fueron correctamente actualizadas.' }
        format.json { render :show, status: :ok, location: @twitter_credential }
      else
        flash[:error] = "No se pudieron crear las credenciales. Debe llenar los campos obligatorios."
        format.html { redirect_to settings_index_path }
        format.json { render json: @twitter_credential.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /twitter_credentials/1
  # DELETE /twitter_credentials/1.json
  def destroy
    @twitter_credential.destroy
    respond_to do |format|
      format.html { redirect_to twitter_credentials_url, notice: 'Twitter credential was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_twitter_credential
      @twitter_credential = current_user.twitter_credential
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def twitter_credential_params
      params.require(:twitter_credential).permit(:consumer_key, :consumer_secret, :access_token, :access_token_secret, :user_id)
    end
end
