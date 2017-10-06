require 'spec_helper'

describe MCLI::Command do
  before do
    MCLI::CommandGroup.clear
    expect(MCLI::CommandGroup.commands.empty?).to eq true
  end

  context 'options' do
    before do
      Class.new(MCLI::Command) do
        register_as :test
        option :option

        def run
          puts options[:option]
        end
      end
    end

    it 'supports the full option flag' do
      set_argv "test --option success"
      expect { MCLI.run }
        .to output("success\n")
        .to_stdout_from_any_process
    end
  end

  context 'options with aliases' do
    before do
      Class.new(MCLI::Command) do
        register_as :test
        option :alias, alias: 'a'

        def run
          puts options[:alias]
        end
      end
    end

    it 'is supported' do
      set_argv "test -a success"
      expect { MCLI.run }
        .to output("success\n")
        .to_stdout_from_any_process
    end

    it 'supports the full option flag' do
      set_argv "test --alias success"
      expect { MCLI.run }
        .to output("success\n")
        .to_stdout_from_any_process
    end
  end

  context 'options with defaults' do
    before do
      Class.new(MCLI::Command) do
        register_as :test
        option :default, alias: 'd', default: 'default'

        def run
          puts options[:default]
        end
      end
    end

    it 'is supported' do
      set_argv "test"
      expect { MCLI.run }
        .to output("default\n")
        .to_stdout_from_any_process
    end

    it 'can be overridden' do
      set_argv "test --default override"
      expect { MCLI.run }
        .to output("override\n")
        .to_stdout_from_any_process
    end

    it 'can be overriden with the alias' do
      set_argv "test -d override"
      expect { MCLI.run }
        .to output("override\n")
        .to_stdout_from_any_process
    end
  end

  context 'options with requirements' do
    before do
      Class.new(MCLI::Command) do
        register_as :test
        option :required, required: true

        def run
          puts options[:required]
        end
      end
    end

    it 'is supported' do
      set_argv "test -r required"
      expect { MCLI.run }
        .to output("required\n")
        .to_stdout_from_any_process
    end

    it 'is enforced for missing flags' do
      set_argv "test"
      expect { MCLI.run }.to raise_error(OptionParser::MissingArgument)
    end

    it 'is enforced for blank arguments' do
      set_argv "test --required"
      expect { MCLI.run }.to raise_error(OptionParser::MissingArgument)
    end
  end

  context 'options as booleans' do
    before do
      Class.new(MCLI::Command) do
        register_as :test
        option :boolean, boolean: true

        def run
          puts options[:boolean] == true
        end
      end
    end

    it 'is supported' do
      set_argv "test --boolean"
      expect { MCLI.run }
        .to output("true\n")
        .to_stdout_from_any_process
    end

    it 'supported as false switch' do
      set_argv "test --no-boolean"
      expect { MCLI.run }
        .to output("false\n")
        .to_stdout_from_any_process
    end
  end

  context 'duplicate options' do
    before do
      Class.new(MCLI::Command) do
        register_as :test
        option :duplicate, default: 'first'
        option :duplicate, default: 'second'
        option :duplicate, default: 'last'

        def run
          puts options[:duplicate]
        end
      end
    end

    it 'takes the last one defined' do
      set_argv "test"
      expect { MCLI.run }
        .to output("last\n")
        .to_stdout_from_any_process
    end
  end

  context 'help option' do
    context 'by default' do
      before do
        Class.new(MCLI::Command) do
          register_as :test

          def run
            puts 'run'
          end

          def help
            puts 'help'
          end
        end
      end

      it 'is supported' do
        set_argv "test --help"
        expect { MCLI.run }
          .to output("help\n")
          .to_stdout_from_any_process
      end

      it 'is supported by the -h alias' do
        set_argv "test -h"
        expect { MCLI.run }
          .to output("help\n")
          .to_stdout_from_any_process
      end
    end

    context 'overrides' do
      before do
        Class.new(MCLI::Command) do
          register_as :test
          option :help, alias: 'h'

          def run
            puts options[:help]
          end
        end
      end

      it 'is supported' do
        set_argv "test --help override"
        expect { MCLI.run }
          .to output("override\n")
          .to_stdout_from_any_process
      end

      it 'is supported by the -h alias' do
        set_argv "test -h override"
        expect { MCLI.run }
          .to output("override\n")
          .to_stdout_from_any_process
      end
    end
  end
end


