class PaperclipModelsController < ApplicationController
  
  def index
    @paperclip_models = PaperclipModel.page params[:page]
  end

  def create
    paperclip_model = PaperclipModel.new paperclip_model_params
    if paperclip_model.save
      redirect_to root_path, notice: 'paperclip_model created'
    else
      redirect_to root_path, notice: 'something wrong creating paperclip_model'
    end
  end

  private
    def paperclip_model_params
      params.require(:paperclip_model).permit(:image, :file)
    end

end