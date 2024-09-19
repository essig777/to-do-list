require 'rails_helper'

RSpec.describe SituationsController, type: :controller do
  include Devise::Test::ControllerHelpers

  describe 'SituationsController' do
    context '#index' do
      it 'returns a JSON with the situations' do
        get :index        
        expect(response).to have_http_status(:ok)
        SituationEnum.to_a.each do |name, id|
          expect(JSON.parse(response.body)['situations']).to include({ 'id' => id, 'name' => name })
        end
      end
    end
  end
end
