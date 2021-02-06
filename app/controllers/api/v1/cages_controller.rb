class Api::V1::CagesController < ApplicationController
  def create
    cage = Cage.new(cage_params)
    if cage.save
      render json: CageSerializer.new(cage), status: 201
    else
      render json: {"data":{"errors": cage.errors.full_messages}}, status: 400
    end
  end

  def index
    cages = Cage.where(power_status: params[:power_status])
    if params[:power_status] == "ACTIVE"
      render json: CageSerializer.new(cages)
    elsif params[:power_status] == "DOWN"
      render json: CageSerializer.(cages)
    else
      render json: {"data":{"errors": "No cages in system"}}, status: 400
    end
  end

  def show
    cage = Cage.find(params[:id])
    if cage.nil?
      render json: {"data":{"errors": "Can not find cage with id #{params[:id]}"}}, status: 400
    else
      render json: CageSerializer.new(cage)
    end
  end

  private

  def cage_params
    params.permit(:capacity, :power_status)
  end
end
