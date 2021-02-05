class DinosaurSerializer
  include FastJsonapi::ObjectSerializer

  attributes :name, :species, :food_type, :cage_id
end
