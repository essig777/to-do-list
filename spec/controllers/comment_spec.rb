require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  include Devise::Test::ControllerHelpers

  before do
    @admin_user = FactoryBot.create(:user, is_admin: true)
    @task = FactoryBot.create(:task)
    @comment = FactoryBot.create(:comment, user_id: @admin_user.id)
    sign_in @admin_user
    request.headers.merge!(@admin_user.create_new_auth_token)
  end

  let(:params_comment) {
    FactoryBot.attributes_for(:comment, commentable_id: @comment.id, commentable_type: 'Comment', user_id: @admin_user.id)
  }

  describe 'Current user is admin' do
    it 'creates a comment - 201 created' do
      post :create, params: { comment: params_comment }
      expect(response).to have_http_status :created
    end

    it 'shows a comment - 200 OK' do
      get :show, params: { id: @comment.id }
      expect(response).to have_http_status :ok
      expect(JSON.parse(response.body)["id"]).to eq(@comment.id)
    end

    it 'updates a comment - 200 OK' do
      patch :update, params: { id: @comment.id, comment: { description: 'Updated comment' } }
      expect(response).to have_http_status :ok
      expect(@comment.reload.description).to eq('Updated comment')
    end

    it 'destroys a comment - 204 No Content' do
      delete :destroy, params: { id: @comment.id }
      expect(response).to have_http_status :no_content
      expect(Comment.find_by(id: @comment.id)).to be_nil
    end

    it 'shows comments of comment - 200 OK' do
      comment2 = FactoryBot.create(:comment, commentable_id: @comment.id, commentable_type: 'Comment', user_id: @admin_user.id)
      get :show_comment, params: { id: @comment.id }
      expect(response).to have_http_status :ok
      expect(JSON.parse(response.body)[0]["id"]).to eq(comment2.id)
    end

    it 'create comments of comment - 200 OK' do
      post :create, params: { comment: { commentable_id: @comment.id, commentable_type: 'Comment', user_id: @admin_user.id } }
      expect(response).to have_http_status :created
    end
  end
end
