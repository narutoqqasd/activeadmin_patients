require 'rails_helper'
include Devise::TestHelpers
RSpec.describe  Admin::LocationsController, type: :controller do
	render_views
	let(:admin_user) { AdminUser.create!(email: 'admin@example.com', password: 'password')}

	before(:each) do
		sign_in admin_user
	end

	describe 'GET #index' do
		it 'populates an array of locations' do
			location = create(:location)
			test2 = create(:location)
			get :index,  locale: 'en'
			expect(assigns(:locations)).to match_array([location, test2])
		end
	end

	describe 'GET #new' do
		it "assigns a new location to @location" do
			get :new, locale: 'en'
			expect(assigns(:location)).to be_a_new(Location)
		end
	end

	describe 'GET #show' do
		it 'assigns the requested location to @location' do
			location = create(:location)
			get :show, id: location.id, locale: 'en'
			expect(assigns(:location)).to eq location
		end
	end

	describe 'GET #edit' do
		it 'renders location form' do
			location = create(:location)
			get :edit, id: location.id, locale: 'en'
			expect(assigns(:location)).to eq location
		end
	end

	describe 'POST #create' do
		it "redirects to locations#show" do
			post :create, locale: 'en', location: attributes_for(:location)
			expect(response).to redirect_to admin_location_path(assigns[:location])
		end
	end

	describe 'PATCH #update' do
		before :each do
			@location = create(:location, code: 'bbb', name: 'bbb')
		end
		it "changes @location's attributes" do
			patch :update, id: @location, locale: 'en', location: attributes_for(:location, code: 'ccc', name: 'ccc')
			@location.reload
			expect(@location.code).to eq('ccc')
			expect(@location.name).to eq('ccc')
		end
	end

	describe 'DELETE #destroy' do
		before :each do
			@location = create(:location)
		end
		it "deletes the location" do
			expect{ delete :destroy, id: @location, locale: 'en'}.to change(Location, :count).by(-1)
		end
		it "redirects to locations#index" do
			delete :destroy, id: @location, locale: 'en'
			expect(response).to redirect_to admin_locations_url
		end
	end


end
