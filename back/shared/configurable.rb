module Configurable
  def config!(options={})
    options.each do |option, value|
      case option.to_sym
      when :color
        color!(value)
      when :scale
        if value.is_a?(Array)
          scale!(value[0], value[1])
          @bubble.scale!(value[0], value[1])
        else
          scale!(value)
          @bubble.scale!(value)
        end
      when :static_scale
        if value.is_a?(Array)
          static_scale!(value[0], value[1])
        else
          static_scale!(value)
        end
      when :bubble
        @bubble.config!(value)
      when :content
        say!(value)
      end
    end
  end

  def config(options={})
    dup.tap { |result| result.config!(options) }
  end
end