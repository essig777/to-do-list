require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  include Devise::Test::ControllerHelpers
  
  before do
    @admin_user = FactoryBot.create(:user, is_admin: true)
    @regular_user = FactoryBot.create(:user, is_admin: false)
    sign_in @admin_user
    request.headers.merge!(@admin_user.create_new_auth_token)
  end

  let(:params_user) { 
    FactoryBot.attributes_for(:user) 
  }

  context 'Current user is admin' do
    it 'register a user - 201 created' do
      post :register, params: { email: 'eduardoessig@maila.com', password: '123456', password_confirmation: '123456', is_admin: true } 
      expect(response).to have_http_status :created
    end
    
    it 'creates a user - 201 created' do
      post :create, params: { user: params_user }
      expect(response).to have_http_status :created
    end

    it 'shows a user - 200 OK' do
      get :show, params: { id: @regular_user.id }
      expect(response).to have_http_status :ok
      expect(JSON.parse(response.body)["id"]).to eq(@regular_user.id)
    end

    it 'updates a user - 200 OK' do
      patch :update, params: { id: @regular_user.id, user: { email: 'updated_email@example.com' } }
      expect(response).to have_http_status :ok
      expect(@regular_user.reload.email).to eq('updated_email@example.com')
    end

    it 'deletes a user - 204 No Content' do
      delete :destroy, params: { id: @regular_user.id }
      expect(response).to have_http_status :no_content
    end

    it 'returns a list of users - 200 OK' do
      get :index
      expect(response).to have_http_status :ok
    end
  end

  context 'Current user is not admin' do
    before do
      sign_in @regular_user
      request.headers.merge!(@regular_user.create_new_auth_token)
    end

    it 'returns 403 Forbidden when trying to create a user' do
      post :create, params: { user: params_user }
      expect(response).to have_http_status :forbidden
    end

    it 'returns 403 Forbidden when trying to update a user' do
      patch :update, params: { id: @regular_user.id, user: { email: 'not_allowed@example.com' } }
      expect(response).to have_http_status :forbidden
    end

    it 'returns 403 Forbidden when trying to delete a user' do
      delete :destroy, params: { id: @regular_user.id }
      expect(response).to have_http_status :forbidden
    end
  end
end
