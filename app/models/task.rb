class Task < ActiveRecord::Base
	belongs_to :user

	def complete!
		self.completed = true
		self
	end

	def as_json(options={})
		super(only: [:name,:due_date, :completed])
	end
end
