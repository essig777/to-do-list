class SituationsController < ApplicationController
  def index
    render json: { situations: SituationEnum.to_a.map{ |name , id| { id: id, name: name }} }
  end
end