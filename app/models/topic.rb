class Topic < ActiveRecord::Base
  has_many :questions
end
