class TaskSerializer < ActiveModel::Serializer
  attributes :id, 
    :title,
    :description,
    :situation,
    :situation_humanize,
    :estimated_time,
    :image_url,
    :user_id,
    :comment
    

  def image_url
    if object.image.attached?
      Rails.application.routes.url_helpers.rails_blob_url(object.image, only_path: true)
    end
  end
end
