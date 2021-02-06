require 'rails_helper'

describe "API V1 Cages", type: 'request' do
  before(:each) do
    @cage1 = Cage.create(
      capacity: 1
    )
    @cage2 = Cage.create(
      capacity: 1
    )
    @dino1 = Dinosaur.create(
      name: "Leafy Boy",
      species: "Stegosaurus",
      food_type: "Herbivore",
      cage_id: @cage2.id
    )
  end

  describe "PATCH /api/v1/cages" do
    context "with valid parameters" do
      let(:valid_params) do
        { power_status: "DOWN"
        }
      end

      it "can power a cage down if empty" do
        patch "/api/v1/cages/#{@cage1.id}", params: valid_params

        expect(response).to be_successful
        expect(response.status).to eq(200)

        cage = Cage.first

        expect(cage.power_status).to eq("DOWN")
      end

      it "can NOT power a cage down if it has dinos in it" do
        patch "/api/v1/cages/#{@cage2.id}", params: valid_params

        expect(response).to_not be_successful
        expect(response.status).to eq(400)

        cage = Cage.first
        json = JSON.parse(response.body, symbolize_names: true)

        expect(cage.power_status).to eq("ACTIVE")
        expect(json[:data][:errors]).to eq("Can not power down a cage with dinosaurs in it!")
      end
    end
  end
end
