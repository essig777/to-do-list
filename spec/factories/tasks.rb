FactoryBot.define do
  factory :task do
    title { 'Task1' }
    description { 'Fazer uma task' }
    situation { 1 }

    after(:build) do |task|
      task.image.attach(
        io: File.open(Rails.root.join('spec/fixtures/files/a.png')),
        filename: 'a.png',
        content_type: 'image/png'
      )
    end
  end
end