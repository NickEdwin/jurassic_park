require 'rails_helper'

describe "API V1 Dinos", type: 'request' do
  before(:each) do
    @cage1 = Cage.create(
      capacity: 1
    )
    @cage2 = Cage.create(
      capacity: 2
    )
    @cage3 = Cage.create(
      capacity: 2
    )
    @cage4 = Cage.create(
      capacity: 2
    )
    @dino1 = Dinosaur.create(
      name: "Leafy Boy",
      species: "Stegosaurus",
      food_type: "Herbivore",
      cage_id: @cage2.id
    )
    @dino2 = Dinosaur.create(
      name: "Big Claw",
      species: "Velociraptor",
      food_type: "Carnivore",
      cage_id: @cage3.id
    )
  end

  describe "POST /api/v1/dinosaurs" do
    context "with valid parameters" do
      let(:valid_params) do
        { name: "Little Rex",
          species: "Tyrannosaurus",
          food_type: "Carnivore",
          cage_id: @cage1.id
        }
      end

      it "can add a new dino to the system" do
        post "/api/v1/dinosaurs", params: valid_params
        expect(response).to be_successful
        expect(response.status).to eq(201)

        json = JSON.parse(response.body, symbolize_names: true)

        cage = Cage.first
        dino = cage.dinosaurs.last

        expect(json[:data][:id]).to eq(dino.id.to_s)
        expect(json[:data][:type]).to eq("dinosaur")
        expect(json[:data][:attributes][:name]).to eq(dino.name)
      end
    end

    context "with invalid parameters" do
      let(:invalid_params) do
        { name: "",
          species: "Tyrannosaurus",
          food_type: "Carnivore",
          cage_id: @cage4.id
        }
      end

      it "can not add a new dino to the system" do
        post "/api/v1/dinosaurs", params: invalid_params
        expect(response).to_not be_successful
        expect(response.status).to eq(400)

        json = JSON.parse(response.body, symbolize_names: true)

        expect(json[:data][:errors].first).to eq("Name can't be blank")
      end
    end

    context "testing capacity for cages" do
      let(:valid_params) do
        { name: "Rex",
          species: "Tyrannosaurus",
          food_type: "Carnivore",
          cage_id: @cage1.id
        }
      end

      it "can not add more dinos than cage capacity" do
        post "/api/v1/dinosaurs", params: valid_params
        post "/api/v1/dinosaurs", params: valid_params

        expect(response).to_not be_successful

        json = JSON.parse(response.body, symbolize_names: true)

        expect(json[:data][:errors]).to eq("Can not create dinosaur, cage is at capacity")
      end
    end

    context "testing mixing species for cages" do
      let(:valid_params) do
        { name: "Rex",
          species: "Tyrannosaurus",
          food_type: "Carnivore",
          cage_id: @cage2.id
        }
      end

      it "can not mix herbivores and carnivores" do
        post "/api/v1/dinosaurs", params: valid_params

        expect(response).to_not be_successful

        json = JSON.parse(response.body, symbolize_names: true)

        expect(json[:data][:errors]).to eq("Can not create dinosaur, carvivores can not be mixed!")
      end
    end

    context "testing mixing species for cages" do
      let(:valid_params) do
        { name: "Rex",
          species: "Tyrannosaurus",
          food_type: "Carnivore",
          cage_id: @cage3.id
        }
      end

      it "can not mix carnivores of 2 different species" do
        post "/api/v1/dinosaurs", params: valid_params

        expect(response).to_not be_successful

        json = JSON.parse(response.body, symbolize_names: true)

        expect(json[:data][:errors]).to eq("Can not create dinosaur, carvivores can not be mixed!")
      end
    end

    context "testing same species for cages" do
      let(:valid_params) do
        { name: "Big Rex",
          species: "Tyrannosaurus",
          food_type: "Carnivore",
          cage_id: @cage4.id
        }
      end

      it "can mix carnivores if they are the same species" do
        post "/api/v1/dinosaurs", params: valid_params
        post "/api/v1/dinosaurs", params: valid_params

        expect(response).to be_successful

        json = JSON.parse(response.body, symbolize_names: true)

        cage = Cage.last
        dino = cage.dinosaurs.last

        expect(json[:data][:id]).to eq(dino.id.to_s)
        expect(json[:data][:type]).to eq("dinosaur")
        expect(json[:data][:attributes][:name]).to eq(dino.name)
      end
    end
  end
end
