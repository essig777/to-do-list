require 'rails_helper'

RSpec.describe Task, type: :model do

  before do
    @admin_user = FactoryBot.create(:user, is_admin: true)
    @task = FactoryBot.create(:task, user_id: @admin_user.id, image: fixture_file_upload(Rails.root.join('spec/fixtures/files/a.png'), 'image/png'))
    @comment1 = FactoryBot.create(:comment, user_id: @admin_user.id, commentable_type: 'Task', commentable_id: @task.id)
    @comment2 = FactoryBot.create(:comment, user_id: @admin_user.id, commentable_type: 'Task', commentable_id: @task.id)
  end

  describe 'Relations' do
    it 'belongs_to user' do
      expect(@task.user).to be_kind_of(User)
    end

    it 'has_many comments' do
      expect(@task.comment.count).to eq(2)
    end

    it 'has_enumeration_for situation' do
      expect(SituationEnum::TO_DO).to eq(1)
      expect(SituationEnum::IN_PROGRESS).to eq(2)
      expect(SituationEnum::TEST).to eq(3)
      expect(SituationEnum::DONE).to eq(4)
      expect(@task.situation).to eq(1)
    end

    it 'has_one_attached image' do
      expect(@task.image).to be_attached
    end
  end

  describe 'Scopes' do
    it 'situation_filter' do
      expect(Task.situation_filter(@task.situation)).to include(@task)
    end

    it 'user_filter' do
      expect(Task.user_filter(@task.user_id)).to include(@task)
    end
  end
end