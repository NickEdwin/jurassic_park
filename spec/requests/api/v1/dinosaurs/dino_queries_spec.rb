require 'rails_helper'

describe "API V1 Dinos", type: 'request' do
  before(:each) do
    @cage1 = Cage.create(
      capacity: 1
    )
    @cage2 = Cage.create(
      capacity: 2
    )
    @dino1 = Dinosaur.create(
      name: "Leafy Boy",
      species: "Stegosaurus",
      food_type: "Herbivore",
      cage_id: @cage1.id
    )
    @dino2 = Dinosaur.create(
      name: "Big Claw",
      species: "Velociraptor",
      food_type: "Carnivore",
      cage_id: @cage2.id
    )
    @dino3 = Dinosaur.create(
      name: "Vegan",
      species: "Stegosaurus",
      food_type: "Herbivore",
      cage_id: @cage1.id
    )
  end

  describe "GET /api/v1/dinosaurs" do
    context "with valid parameters" do
      let(:valid_params) do
        { species: "Stegosaurus"
        }
      end

      it "can get a list of all dinos by species" do
        get "/api/v1/dinosaurs", params: valid_params
        expect(response).to be_successful
        expect(response.status).to eq(200)

        json = JSON.parse(response.body, symbolize_names: true)

        expect(json[:data].length).to eq(2)
        expect(json[:data][0][:id]).to eq(@dino1.id.to_s)
        expect(json[:data][0][:attributes][:name]).to eq(@dino1.name)
      end
    end

    context "with invalid parameters" do
      let(:invalid_params) do
        { species: "Turkey"
        }
      end

      it "can get a list of all dinos by species" do
        get "/api/v1/dinosaurs", params: invalid_params
        expect(response).to_not be_successful
        expect(response.status).to eq(400)

        json = JSON.parse(response.body, symbolize_names: true)

        expect(json[:data][:errors]).to eq("No dinosaurs in system with species Turkey")
      end
    end
  end
end
