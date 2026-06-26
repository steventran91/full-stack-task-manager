require 'rails_helper'

RSpec.describe User, type: :model do
  it "is valid with all required info" do 
    user = User.new(first_name: "Naruto", last_name: "Uzumaki", email: "hokage@gmail.com", password: "believeit!")
    expect(user).to be_valid
  end

  it "is invalid without first_name" do 
    user = User.new(first_name: nil, last_name: "Uzumaki", email: "hokage@gmail.com", password: "believeit!")
    expect(user).not_to be_valid
  end

  it "is invalid without last_name" do
    user = User.new(first_name: "Naruto", last_name: nil, email: "hokage@gmail.com", password: "believeit!")
    expect(user).not_to be_valid
  end

  it "is invalid without email" do 
    user = User.new(first_name: "Naruto", last_name: "Uzumaki", email: nil, password: "believeit!")
    expect(user).not_to be_valid
  end

  it "is invalid without password" do 
    user = User.new(first_name: "Naruto", last_name: "Uzumaki", email: "hokage@gmail.com", password: nil)
    expect(user).not_to be_valid
  end

  it "is invalid with duplicate email" do 
    user = User.create(first_name: "Naruto", last_name: "Uzumaki", email: "hokage@gmail.com", password: "believeit!")
    expect(user).to be_valid 
    user_2 = User.new(first_name: "Sasuke", last_name: "Uchiha", email: "hokage@gmail.com", password: "dontbeleiveit!")
    expect(user_2).not_to be_valid
  end

  it "is invalid with incorrect email format" do 
    user = User.new(first_name: "Naruto", last_name: "Uzumaki", email: "this-is-not-an-email", password: "believeit!")
    expect(user).not_to be_valid
  end
end
