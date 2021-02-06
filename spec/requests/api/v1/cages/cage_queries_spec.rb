require 'rails_helper'

describe "API V1 Cages", type: 'request' do
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
  end

  describe "GET /api/v1/cages" do
    context "with valid parameters" do
      let(:valid_params) do
        { power_status: "ACTIVE"
        }
      end

      it "can get a list of all cages" do
        get "/api/v1/cages", params: valid_params
        expect(response).to be_successful
        expect(response.status).to eq(200)

        first_cage = Cage.first
        second_cage = Cage.last

        json = JSON.parse(response.body, symbolize_names: true)
        require"pry"; binding.pry
        expect(json[:data].length).to eq(2)
        expect(json[:data][0][:id]).to eq(first_cage.id.to_s)
        expect(json[:data][1][:id]).to eq(second_cage.id.to_s)
      end
    end
  end

  describe "GET /api/v1/cage/:id" do
    it "can get a specific cage by its id" do
      get "/api/v1/cages/#{@cage1.id}"
      expect(response).to be_successful
      expect(response.status).to eq(200)

      first_cage = Cage.first

      json = JSON.parse(response.body, symbolize_names: true)

      expect(json[:data][:id]).to eq(first_cage.id.to_s)
    end
  end
end
