require "rails_helper"
RSpec.describe Patient, type: :model do

	describe Patient do
		before :each do
			@location = Location.create(code: 'aaa', name: 'aaa')
		end

		it "is valid with a first_name, last_name, status and  location" do
			expect(build(:patient, location_id: @location.id)).to be_valid
		end

		it "is invalid without a first_name, last_name, status and  location" do
			patient = build(:patient, first_name: nil, last_name: nil, status: nil, location_id: nil)
			expect(patient).not_to be_valid
		end

		it "is invalid with first_name'length > 30" do
			patient = build(:patient, first_name: 'a' * 31, location_id: @location.id)
			expect(patient).not_to be_valid
		end

		it "is invalid with middle_name'length > 10" do
			patient = build(:patient, middle_name: 'a' * 11, location_id: @location.id)
			expect(patient).not_to be_valid
		end

		it "is invalid with last_name'length > 30" do
			patient = build(:patient, last_name: 'a' * 31, location_id: @location.id)
			expect(patient).not_to be_valid
		end

		it "returns a patient's full name(last name, first name and middle name) as a string" do
			patient = build(:patient, first_name: 'aaa', middle_name: 'bbb', last_name: 'ccc', location_id: @location.id)
			expect(patient.get_full_name).to eq  'ccc aaa bbb'
		end

		it "returns a ptient's MR name as a string" do
			patient = build(:patient, location_id: @location.id)
			expect(patient.get_mr).to eq ['MR0000', patient.id].join('')
		end


	end
end
