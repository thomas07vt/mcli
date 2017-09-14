require "spec_helper"

RSpec.describe MCLI do
  it "has a version number" do
    expect(MCLI::VERSION).not_to be nil
  end
end
