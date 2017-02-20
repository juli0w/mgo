require "rails_helper"

RSpec.describe Company, :type => :model do
  it "needs some fields" do
    expect(Company.new).to_not be_valid
  end

  it "creates sucessfully" do
    expect(Company.new(name: "teste",
                       slug: "teste",
                       category_id: Category.first.id)).to be_valid
  end

  it "fails on false slug" do
    expect(Company.new(name: "teste",
                       slug: "teste-dfas ..2@",
                       category_id: Category.first.id)).to_not be_valid
  end
end
