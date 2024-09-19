FactoryBot.define do
  factory :comment do
    description { 'Ola' }
    commentable_id { 1 }
    commentable_type { 'Task' }
    
  end
end