class DragonflyModelsController < ApplicationController

  def create
    dragonfly_model = DragonflyModel.new dragonfly_model_params
    if dragonfly_model.save
      redirect_to root_path, notice: 'dragonfly_model created'
    else
      redirect_to root_path, notice: 'something wrong creating dragonfly_model'
    end
  end

  private
    def dragonfly_model_params
      params.require(:dragonfly_model).permit(:image, :file)
    end

end