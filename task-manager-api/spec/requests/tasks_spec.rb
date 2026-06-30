require 'rails_helper'

RSpec.describe "Tasks", type: :request do
  describe "GET /index" do
    let(:user) {User.create!(first_name: "Naruto", last_name: "Uzumaki", email: "request_test@gmail.com", password: "believeit!")}
    let(:token) {JwtService.encode({user_id: user.id})}

    it "valid token return 200 status" do
      get "/tasks", headers: {"Authorization" => "Bearer #{token}"}
      expect(response).to have_http_status(:success)
    end

    it "no token return 401 Unauthorized" do 
      get "/tasks"
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "POST /tasks" do
    let(:user) {User.create!(first_name: "Naruto", last_name: "Uzumaki", email: "request_test@gmail.com", password: "believeit!")}
    let(:token) {JwtService.encode({user_id: user.id})}

    it "valid params return 201 created" do
      post "/tasks", 
      params: {task: {title: "Write tests", status: "pending"}},
      headers: {"Authorization" => "Bearer #{token}"}
      expect(response).to have_http_status(:created)
    end

    it "missing title returns 422" do 
      post "/tasks",
      params: {task: {title: nil, status: "pending"}},
      headers: {"Authorization" => "Bearer #{token}"}
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  # describe "GET /create" do
  #   it "returns http success" do
  #     get "/tasks/create"
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  # describe "GET /update" do
  #   it "returns http success" do
  #     get "/tasks/update"
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  # describe "GET /destroy" do
  #   it "returns http success" do
  #     get "/tasks/destroy"
  #     expect(response).to have_http_status(:success)
  #   end
  # end

end
