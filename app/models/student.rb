class Student < ApplicationRecord
    # associations
    belongs_to :instructor
    # validations
    validates :name, presence: true
    validates :age, presence: true
    validate :check_age

    def check_age
        if(self.age <= 17)
            errors.add(:age, "Prospective student is too young")
        end
    end
end
