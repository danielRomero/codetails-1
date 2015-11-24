class CarrierwavesController < ApplicationController
  # attr_accessible :file, :file_cache
  # attr_accessible :image, :image_cache
  def index
    @carrierwave_models = Carrierwave.page params[:page]
  end

  def create
    carrierwave = Carrierwave.new carrierwave_params
    if carrierwave.save
      redirect_to root_path, notice: 'Carrierwave created'
    else
      redirect_to root_path, notice: 'something wrong creating carrierwave'
    end
  end

  private
    def carrierwave_params
      params.require(:carrierwave).permit(:image, :file)
    end
end
