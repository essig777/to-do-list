class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true
  has_many :comment, as: :commentable
  belongs_to :user
end
