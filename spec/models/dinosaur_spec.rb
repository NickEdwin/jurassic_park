require 'rails_helper'

RSpec.describe Dinosaur, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :species }
    it { should validate_presence_of :food_type }

  end
end
