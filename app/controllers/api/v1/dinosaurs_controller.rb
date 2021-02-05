class Api::V1::DinosaursController < ApplicationController
  def create
    cage = Cage.find(params[:cage_id])
    if cage.capacity? || cage.power_off? || cage.carnivores?(dino_params)
      if cage.capacity? == true
        render json: {"data":{"errors": "Can not create dinosaur, cage is at capacity"}}, status: 400
      elsif cage.power_off? == true
        render json: {"data":{"errors": "Can not create dinosaur, cage is powered down"}}, status: 400
      else
        render json: {"data":{"errors": "Can not create dinosaur, carvivores can not be mixed!"}}, status: 400
      end
    else
      dino = cage.dinosaurs.new(dino_params)
      if dino.save
        render json: DinosaurSerializer.new(dino), status: 201
      else
        render json: {"data":{"errors": dino.errors.full_messages}}, status: 400
      end
    end
  end

  private

  def dino_params
    params.permit(:name, :species, :food_type, :cage_id)
  end
end
