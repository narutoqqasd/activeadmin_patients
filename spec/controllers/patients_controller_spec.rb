require 'rails_helper'
include Devise::TestHelpers
RSpec.describe  Admin::PatientsController, type: :controller do
	render_views
	let(:admin_user) { AdminUser.create!(email: 'admin@example.com', password: 'password')}

	before(:each) do
		sign_in admin_user
	end

	describe 'GET #index' do
		it 'populates an array of patients' do
			@location = create(:location)
			patient = create(:patient, location_id: @location.id)
			patient2 = create(:patient, location_id: @location.id)
			get :index,  locale: 'en'
			expect(assigns(:patients)).to match_array([patient, patient2])
		end
	end

	describe 'GET #new' do
		it "assigns a new patient to @patient" do
			get :new, locale: 'en'
			expect(assigns(:patient)).to be_a_new(Patient)
		end
	end

	describe 'GET #show' do
		it 'assigns the requested patient to @patient' do
			@location = create(:location)
			patient = create(:patient, location_id: @location.id)
			get :show, id: patient.id, locale: 'en'
			expect(assigns(:patient)).to eq patient
		end
		it 'viewed_count = 1' do
			@location = create(:location)
			patient = create(:patient, location_id: @location.id)
			get :show, id: patient.id, locale: 'en'
			expect(patient.impressionist_count).to eq 1
		end
	end

	describe 'GET #edit' do
		it 'renders patient form' do
			@location = create(:location)
			patient = create(:patient, location_id: @location.id)
			get :edit, id: patient.id, locale: 'en'
			expect(assigns(:patient)).to eq patient
		end
	end

	describe 'POST #create' do
		it "redirects to patients#show" do
			@location = create(:location)
			post :create, locale: 'en', patient: attributes_for(:patient, location_id: @location.id, locale: 'en')
			expect(response).to redirect_to admin_patient_path(assigns[:patient])
		end
	end

	describe 'PATCH #update' do
		before :each do
			@location = create(:location, code: 'bbb', name: 'bbb')
			@patient = create(:patient, location_id: @location.id)
		end
		it "changes @patient's attributes" do
			patch :update, id: @patient, locale: 'en', patient: attributes_for(:location, first_name: 'ccc', last_name: 'ccc')
			@patient.reload
			expect(@patient.first_name).to eq('ccc')
			expect(@patient.last_name).to eq('ccc')
		end
	end

	describe 'DELETE #destroy' do
		before :each do
			@location = create(:location)
			@patient = create(:patient, location_id: @location.id)
		end
		it "deletes the patient" do
			expect{ delete :destroy, id: @patient, locale: 'en'}.to change(Patient, :count).by(-1)
		end
		it "redirects to patients#index" do
			delete :destroy, id: @patient, locale: 'en'
			expect(response).to redirect_to admin_patients_url
		end
	end


end
