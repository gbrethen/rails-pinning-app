class PinsController < ApplicationController
  
  before_action :require_login, except: [:show, :show_by_name]
  
  def index
    @pins = Pin.all
  end
  
  def show
    @pin = Pin.find(params[:id])
	@users = User.joins(:pinnings).where("users.id = ? or pinnings.pin_id = ?", @pin.user_id, @pin.id)
  end
  
  def show_by_name
	@pin = Pin.find_by_slug(params[:slug]) #slug is a field in the database so we can use a named url instead of the id
	@users = User.joins(:pinnings).where("users.id = ? or pinnings.pin_id = ?", @pin.user_id, @pin.id)
	render :show
  end
  
  def new
	@pin = Pin.new
  end
  
  def create
	@pin = Pin.create(pin_params)
	
	if @pin.valid?
		@pin.save
		#@pin.pinnings.create(params[:pinning][:user_id], @pin.id, params[:pinning][:board_id])
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
  
  def repin
	@pin = Pin.find(params[:id])
	@pin.pinnings.create(user: current_user)
	redirect_to user_path(current_user)
  end
  
 private #every method below this is a private method
  
  def pin_params
	params.require(:pin).permit(:title, :category_id, :url, :text, :slug, :image, :user_id)
  end
  
end