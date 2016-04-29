require 'spec_helper'
RSpec.describe PinsController do
	describe "GET index" do
		it 'renders the index template' do
			get :index
			expect(response).to render_template("index")
		end
		
		it 'populates the @pins array with all pins' do
			get :index
			expect(assigns[:pins]).to eq(Pin.all) #use the rspec assign method to grab @pins
		end
	end
end