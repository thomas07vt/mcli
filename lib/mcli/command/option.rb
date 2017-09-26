# @private
class MCLI::Command::Option
  attr_reader :name, :alias, :default, :required, :type, :boolean

  def initialize(name, options={})
    opts = default_options.merge(options)

    @name     = name.to_sym
    @alias    = "-#{opts[:alias].to_s}" if opts[:alias]
    @default  = opts[:default]
    @required = opts[:required]
    @type     = opts[:type]
    @boolean  = opts[:boolean]
  end

  private

  def default_options
    {
      required: false,
      boolean: false
    }
  end
end

