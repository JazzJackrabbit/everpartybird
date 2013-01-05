module Configurable
  def config!(options={})
    options.each do |option, value|
      case option.to_sym
      when :color
        self.send :color!, value
      when :scale
        self.send :scale!, value
      end
    end
  end

  def config(options={})
    dup.tap { |result| result.config!(options) }
  end
end