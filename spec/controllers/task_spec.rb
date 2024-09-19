require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  include Devise::Test::ControllerHelpers

  before do
    @admin_user = FactoryBot.create(:user, is_admin: true)
    @task = FactoryBot.create(:task, user_id: @admin_user.id)
    sign_in @admin_user
    request.headers.merge!(@admin_user.create_new_auth_token)
  end

  let(:params_task) {
    FactoryBot.attributes_for(:task)
  }

  context 'Current user is admin' do
    context '#index' do
      it '200 ok' do
        get :index
        expect(response).to have_http_status :ok
      end

      it 'scopes - user_filter' do
        get :index, params: { user_id: @task.user_id}
        expect(JSON.parse(response.body).first["user_id"]).to eq(@task.user_id)
      end

      it 'scopes - situation_filter' do
        get :index, params: { situation: @task.situation }
        expect(JSON.parse(response.body).first["situation"]).to eq(@task.situation)
      end
    end

    context '#create' do
      it '201 created' do
        post :create, params: { task: params_task }
        expect(response).to have_http_status :created
      end
    end

    context '#show' do
      it '200 OK' do
        get :show, params: { id: @task.id }
        expect(response).to have_http_status :ok
        expect(JSON.parse(response.body)["id"]).to eq(@task.id)
      end

      it 'shows task comments - 200 OK' do
        comment = FactoryBot.create(:comment, commentable_id: @task.id, commentable_type: 'Task', user_id: @admin_user.id)
        get :list_comment, params: { id: @task.id }
        expect(response).to have_http_status :ok
        expect(JSON.parse(response.body)[0]["id"]).to eq(comment.id)
      end
    end

    context '#updates' do
      it '200 OK' do
        patch :update, params: { id: @task.id, task: { title: 'Updated Task' } }
        expect(response).to have_http_status :ok
        expect(@task.reload.title).to eq('Updated Task')
      end

      it 'adds user to task - 200 OK' do
        new_user = FactoryBot.create(:user)
        patch :add_user_to_task, params: { id: @task.id, user_id: new_user.id }
        expect(response).to have_http_status :ok
        expect(@task.reload.user_id).to eq(new_user.id)
      end
    end

    context '#delete' do
      it '204 No Content' do
        delete :destroy, params: { id: @task.id }
        expect(response).to have_http_status :no_content
        expect(Task.find_by(id: @task.id)).to be_nil
      end
    end
  end

  context 'Current user is not admin' do
    before do
      sign_out @admin_user
      @user = FactoryBot.create(:user, is_admin: false)
      @task2 = FactoryBot.create(:task, user_id: @user.id)
      @task3 = FactoryBot.create(:task, user_id: @user.id)
      sign_in @user
      request.headers.merge!(@user.create_new_auth_token)
    end

    context '#index' do
      it '200 OK' do
        get :index
        expect(response).to have_http_status :ok
        expect(JSON.parse(response.body).length).to eq(2)
      end
    end

    context '#show' do
      it '200 OK' do
        get :show, params: { id: @task2.id }
        expect(response).to have_http_status :ok
        expect(JSON.parse(response.body)["id"]).to eq(@task2.id)
      end
    end

    context '#create' do
      it '201 CREATED' do
        post :create, params: { task: params_task }
        expect(response).to have_http_status :created
      end
    end

    context '#update' do
      it '200 OK' do
        patch :update, params: { id: @task2.id, task: { title: 'Updated Task' } }
        expect(response).to have_http_status :ok
        expect(@task2.reload.title).to eq('Updated Task')
      end
    end

    context '#destroy' do
      it '204 NO CONTENT' do
        delete :destroy, params: { id: @task2.id }
        expect(response).to have_http_status :no_content
      end
    end
  end
end