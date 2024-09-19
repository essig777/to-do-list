class CommentSerializer < ActiveModel::Serializer
  attributes  :id,
              :description,
              :commentable_type,
              :commentable_id,
              :comment
end