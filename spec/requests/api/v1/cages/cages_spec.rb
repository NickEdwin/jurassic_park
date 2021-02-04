require 'rails_helper'

describe "API V1 Cages", type: 'request' do
  describe "POST /api/v1/cages" do
    context "with valid parameters" do
      let(:valid_params) do
        { capacity: 5
        }
      end

      it "can add a new cage to the system" do
        post "/api/v1/cages", params: valid_params
        expect(response).to be_successful
        expect(response.status).to eq(201)
      end

      it "can shows proper json response for new cage" do
        post "/api/v1/cages", params: valid_params
        json = JSON.parse(response.body, symbolize_names: true)

        cage = Cage.last

        expect(json[:data][:id]).to eq(cage.id.to_s)
        expect(json[:data][:type]).to eq("cage")
        expect(json[:data][:attributes][:capacity]).to eq(cage.capacity)
        expect(json[:data][:attributes][:power_status]).to eq(cage.power_status)
        expect(json[:data][:attributes][:power_status]).to eq("ACTIVE")
      end
    end

    context "with invalid parameters" do
      let(:valid_params) do
        { capacity: 0
        }
      end

      it "can not add a cage with 0 capacity" do
        post "/api/v1/cages", params: valid_params
        expect(response).to_not be_successful
        expect(response.status).to eq(400)

        json = JSON.parse(response.body, symbolize_names: true)

        expect(json[:data][:errors].first).to eq("Capacity must be greater than or equal to 1")
      end
    end
  end
end
