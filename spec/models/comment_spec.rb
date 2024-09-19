require 'rails_helper'

RSpec.describe Comment, type: :model do

  before do
    @admin_user = FactoryBot.create(:user, is_admin: true)
    @task = FactoryBot.create(:task, user_id: @admin_user.id, image: fixture_file_upload(Rails.root.join('spec/fixtures/files/a.png'), 'image/png'))
    @comment = FactoryBot.create(:comment, user_id: @admin_user.id, commentable_type: 'Task', commentable_id: @task.id)
    @comment1 = FactoryBot.create(:comment, user_id: @admin_user.id, commentable_type: 'Comment', commentable_id: @comment.id)
    @comment2 = FactoryBot.create(:comment, user_id: @admin_user.id, commentable_type: 'Comment', commentable_id: @comment.id)
  end

  describe 'Relations' do
    it 'belongs to user' do
      expect(@comment.user).to be_kind_of(User)
    end

    it 'belongs_to comentable' do
      expect(@comment.commentable_id?).to be true
      expect(@comment.commentable_type?).to be true
    end

    it 'has_many comments' do
      expect(@comment.comment.count).to eq(2)
    end
  end
end