require 'rails_helper'

describe "API V1 Dinos", type: 'request' do
  before(:each) do
    @cage1 = Cage.create(
      capacity: 1
    )
    @cage2 = Cage.create(
      capacity: 5
    )
  end

  describe "POST /api/v1/dinosaurs" do
    context "with valid parameters" do
      let(:valid_params) do
        { name: "Rex",
          species: "Tyrannosaurus",
          food_type: "Carnivore",
          cage_id: @cage1.id
        }
      end

      it "can add a new dino to the system" do
        post "/api/v1/dinosaurs", params: valid_params
        expect(response).to be_successful
        expect(response.status).to eq(201)
      end
    end

    context "with valid parameters" do
      let(:invalid_params) do
        { name: "",
          species: "Tyrannosaurus",
          food_type: "Carnivore",
          cage_id: @cage1.id
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
  end
end
