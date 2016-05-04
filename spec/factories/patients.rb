FactoryGirl.define do
	factory :patient do
		first_name  { Faker::Name.first_name}
		last_name  { Faker::Name.last_name }
		birthday { Faker::Time.birthday }
		gender { 'male' }
		status { 'treatment' }
		is_deleted { false }
	end
end
