FactoryGirl.define do
	factory :location do
		code  { Faker::Number.number(6)}
		name  { Faker::Name.name}
	end
end
