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

  describe "GET /tasks/:id" do
    let(:user) {User.create!(first_name: "Sasuke", last_name: "Uchiha", email: "clankiller@gmail.com", password: "fuckitachi")}
    let(:task) {user.tasks.create!(title: "Kill Naruto", status: "pending")}
    let(:token) {JwtService.encode({user_id: user.id})}

    it "get task by ID returns 200" do
      get "/tasks/#{task.id}",
      headers: {"Authorization" => "Bearer #{token}"}
      expect(response).to have_http_status(:success)
    end

    it "get missing task ID returns 404" do 
      get "/tasks/#{880}",
      headers: {"Authorization" => "Bearer #{token}"}
      expect(response).to have_http_status(:not_found)
    end
  end
end
