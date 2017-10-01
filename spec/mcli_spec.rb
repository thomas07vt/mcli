require "spec_helper"

RSpec.describe MCLI do
  it "has a version number" do
    expect(MCLI::VERSION).not_to be nil
  end

  describe '.run' do
    context 'whith no parameters passed' do
      before do
        ARGV.clear
      end

      it 'returns generic help' do
        expect(MCLI::NullCommand).to receive :help
        MCLI.run
      end
    end
  end
end
