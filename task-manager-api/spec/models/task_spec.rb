require 'rails_helper'

RSpec.describe Task, type: :model do
  let(:user) {User.create(first_name: "Naruto", last_name: "Uzumaki", email: "hokage@gmail.com", password: "believeit!")}

  it "is valid with required info" do 
    task = Task.new(title: "Clean living room", status: "in_progress", user: user)
    expect(task).to be_valid
  end

  it "is invalid without title" do 
    task = Task.new(title: nil, description: "I will become hokage of the leaf village", status: "in_progress", user: user)
    expect(task).not_to be_valid
  end

  it "is invalid with nil status" do 
    task = Task.new(title: "Go grocery shopping", description: "Buy ingredients for ramen", status: nil, user: user)
    expect(task).not_to be_valid
  end

  it "is invalid with invalid status" do 
    task = Task.new(title: "Clean house", status: "do_tomorrow", user: user)
    expect(task).not_to be_valid
  end
end
