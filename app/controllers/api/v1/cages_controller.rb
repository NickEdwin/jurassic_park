class Api::V1::CagesController < ApplicationController
  def create
    cage = Cage.new(cage_params)
    
    if cage.save
      render json: CageSerializer.new(cage), status: 201
    else
      render json: {"data":{"errors": cage.errors.full_messages}}, status: 400
    end
  end

  private

  def cage_params
    params.permit(:capacity)
  end
end
