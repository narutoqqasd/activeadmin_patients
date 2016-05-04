class Patient < ActiveRecord::Base
	belongs_to :location
	validates :first_name, presence: true, length: { maximum: 30 }
	validates :middle_name, length: { maximum: 10 }
	validates :last_name, presence: true, length: { maximum: 30 }
	validates :status, :location, presence: true
	extend Enumerize
	enumerize :gender, in: ["not_available", "male", "female"]
	enumerize :status, in: ["initial", "referred", "treatment", "closed"]

	is_impressionable

	def get_full_name
		[last_name, first_name, middle_name].join(' ')
	end

	def get_mr
		"MR0000" + id.to_s
	end

	def get_age(birthday)
		now = Time.now.utc.to_date
		now.year - birthday.year - (birthday.to_date.change(:year => now.year) > now ? 1 : 0)
	end
end
