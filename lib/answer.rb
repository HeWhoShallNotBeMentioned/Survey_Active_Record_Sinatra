class Answer < ActiveRecord::Base
  belongs_to(:question)
  validates(:answer, :presence => true)
  validates :answer, length: { maximum: 50 }
end
