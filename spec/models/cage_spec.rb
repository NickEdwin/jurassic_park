require 'rails_helper'

RSpec.describe Cage, type: :model do
  describe 'validations' do
    it { should validate_presence_of :capacity }

    describe 'relationships' do
      it { should have_many :dinosaurs }
    end
  end
end
