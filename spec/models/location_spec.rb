require "rails_helper"
RSpec.describe Location, type: :model do

	describe Location do
		it "is valid with a code and name" do
			expect(build(:location)).to be_valid
		end

		it "is valid with a duplicate code and name" do
			FactoryGirl.create(:location)
			expect(build(:location)).to be_valid
		end

		it "is valid without a code" do
			location = build(:location, code: nil)
			expect(location).to be_valid
		end

		it "is invalid without a name"  do
			location = build(:location, name: nil)
			location.valid?
			expect(location.errors[:name]).to include("can't be blank")
		end

		it "is invalid with code's length > 10" do
			location = build(:location, code: 'a' * 11 )
			expect(location).not_to be_valid
		end

		it "is invalid with name's length > 80" do
			location = build(:location, name: 'a' * 81 )
			expect(location).not_to be_valid
		end


	end
end
