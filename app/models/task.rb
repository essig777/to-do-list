class Task < ApplicationRecord
  
  # belongs
  belongs_to :user, optional: true

  # has_many
  has_many :comments, as: :commentable

  # Enumeration
  has_enumeration_for :situation, with: SituationEnum

  # attacheds
  has_one_attached :image
 

  #Scopes

  scope :situation_filter, ->(situation){
    where(situation: situation)
  }

  scope :user_filter, ->(user_id){
    where(user_id: user_id)
  }

  # scope :comment_filter, ->(desc_comment) {
  #   joins(:comment)
  #     # .where(comment: { description: desc_comment })
  #     .where("comments.description LIKE desc_comment")
  # }

end
