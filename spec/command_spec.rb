require 'spec_helper'

describe MCLI::Command do
  let(:command) { Class.new(MCLI::Command) }

  context '.option' do
    describe 'alias' do
      it 'defaults to nil' do
        command.option :alias
        expect(command.find_option(:alias).alias).to eq nil
      end

      it 'is accepted' do
        command.option :alias, alias: 'o'
        expect(command.find_option(:alias).alias).to eq '-o'
      end
    end

    describe 'default' do
      it 'defaults to nil' do
        command.option :default
        expect(command.find_option(:default).default).to eq nil
      end

      it 'is accepted' do
        command.option :default, default: 'up'
        expect(command.find_option(:default).default).to eq 'up'
      end
    end

    describe 'required' do
      it 'defaults to false' do
        command.option :required
        expect(command.find_option(:required).required).to eq false
      end

      it 'is accepted' do
        command.option :required, required: true
        expect(command.find_option(:required).required).to eq true
      end
    end

    describe 'type' do
      it 'defaults to nil' do
        command.option :type
        expect(command.find_option(:type).type).to eq nil
      end

      it 'is accepted' do
        command.option :type, type: Integer
        expect(command.find_option(:type).type).to eq Integer
      end
    end

    describe 'boolean' do
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
end
