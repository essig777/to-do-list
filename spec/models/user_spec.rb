require 'rails_helper'

RSpec.describe User, type: :model do

  before do
    @admin_user = FactoryBot.create(:user, is_admin: true)
    @regular_user = FactoryBot.create(:user, is_admin: false)
    @task1 = FactoryBot.create(:task, user_id: @admin_user.id)
    @task2 = FactoryBot.create(:task, user_id: @admin_user.id)
    @comment1 = FactoryBot.create(:comment, user_id: @admin_user.id, commentable_type: 'Task', commentable_id: @task1.id)
    @comment2 = FactoryBot.create(:comment, user_id: @admin_user.id, commentable_type: 'Task', commentable_id: @task2.id)
  end
  let(:params_user) { 
    FactoryBot.attributes_for(:user) 
  }

  describe 'Relations' do
    it 'has_many tasks' do
      expect(@admin_user.tasks.count).to eq(2)
    end

    it 'has_many comments' do
      expect(@admin_user.comments.count).to eq(2)
    end
  end

  describe 'Create user' do
    it 'Admin' do
      expect(@admin_user.is_admin).to be true
    end

    it 'Regular' do
      expect(@regular_user.is_admin).to be false
    end
  end
end
