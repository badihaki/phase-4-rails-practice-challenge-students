class StudentSerializer < ActiveModel::Serializer
  attributes :id, :name, :major, :age
  #associations
  belongs_to :instructor
end
