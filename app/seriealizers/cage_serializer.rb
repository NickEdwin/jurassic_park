class CageSerializer
  include FastJsonapi::ObjectSerializer

  attributes :capacity, :power_status
end
