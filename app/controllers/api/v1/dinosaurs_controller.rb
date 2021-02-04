class Api::V1::DinosaursController < ApplicationController
  def create
    cage = Cage.find(params[:cage_id])
    dino = cage.dinosaurs.new(dino_params)

    if dino.save
      render json: DinosaurSerializer.new(dino), status: 201
    else
      render json: {"data":{"errors": dino.errors.full_messages}}, status: 400
    end
  end

  private

  def dino_params
    params.permit(:name, :species, :food_type, :cage_id)
  end
end
