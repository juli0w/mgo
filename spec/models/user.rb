require "rails_helper"

RSpec.describe User, :type => :model do
  it "needs a password and email" do
    expect(User.new).to_not be_valid
  end
end
