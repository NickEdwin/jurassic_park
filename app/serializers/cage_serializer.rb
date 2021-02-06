class CageSerializer
  include FastJsonapi::ObjectSerializer

  attributes :capacity, :power_status

  attribute :dinosaurs do |cage|
    cage.dinosaurs
  end
end
