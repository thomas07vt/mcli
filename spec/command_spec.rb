require 'spec_helper'

describe MCLI::Command do
  let(:command) { Class.new(MCLI::Command) }

  describe '.option' do
    context 'alias' do
      it 'defaults to nil' do
        command.option :alias
        expect(command.find_option(:alias).alias).to eq nil
      end

      it 'is accepted' do
        command.option :alias, alias: 'o'
        expect(command.find_option(:alias).alias).to eq '-o'
      end
    end

    context 'default' do
      it 'defaults to nil' do
        command.option :default
        expect(command.find_option(:default).default).to eq nil
      end

      it 'is accepted' do
        command.option :default, default: 'up'
        expect(command.find_option(:default).default).to eq 'up'
      end
    end

    context 'required' do
      it 'defaults to false' do
        command.option :required
        expect(command.find_option(:required).required).to eq false
      end

      it 'is accepted' do
        command.option :required, required: true
        expect(command.find_option(:required).required).to eq true
      end
    end

    context 'type' do
      it 'defaults to nil' do
        command.option :type
        expect(command.find_option(:type).type).to eq nil
      end

      it 'is accepted' do
        command.option :type, type: Integer
        expect(command.find_option(:type).type).to eq Integer
      end
    end

    context 'boolean' do
      it 'defaults to false' do
        command.option :boolean
        expect(command.find_option(:boolean).boolean).to eq false
      end

      it 'is accepted' do
        command.option :boolean, boolean: true
        expect(command.find_option(:boolean).boolean).to eq true
      end
    end
  end

  describe '.register_as' do
    it 'registers itself as the name given' do
      command.register_as :register_as
      expect(MCLI::CommandGroup.find_command(:register_as)).to eq(command)
    end
  end
end
