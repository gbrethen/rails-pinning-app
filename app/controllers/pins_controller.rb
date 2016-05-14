class PinsController < ApplicationController
  
  def index
    @pins = Pin.all
  end
  
  def show
    @pin = Pin.find(params[:id])
  end
  
  def show_by_name
	@pin = Pin.find_by_slug(params[:slug]) #slug is a field in the database so we can use a named url instead of the id
	render :show
  end
  
  def new
	@pin = Pin.new
  end
  
  def create
	@pin = Pin.create(pin_params)
	
	if @pin.valid?
		@pin.save
		redirect_to pin_path(@pin)
	else
		@errors = @pin.errors
		render :new
	end
  end
  
  def edit
	@pin = Pin.find(params[:id])
	render :edit
  end
  
  def update
	@pin = Pin.find(params[:id])
		
	if @pin.update_attributes(pin_params)
		redirect_to pin_path(@pin)
	else
		@errors = @pin.errors
		render :edit
	end
  end
  
 private #every method below this is a private method
  
  def pin_params
	params.require(:pin).permit(:title, :category_id, :url, :text, :slug, :image)
  end
  
end