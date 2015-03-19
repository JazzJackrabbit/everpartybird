require_relative 'shapes'
require_relative '../shared/editable'
require_relative '../models/color'
require_relative '../shared/configurable'

module SmartShapes
  include Shapes

  class SmartPolygon < Polygon
    include Editable
    attr_accessor :color

    def initialize(*points)
      @color = '#e08a24'
      super(*points)
    end
  end

  class SmartMultiPolygon < MultiPolygon
    include Editable
    include Configurable
    attr_accessor :name

    def initialize(name, *polygons)
      @name = name
      super(*polygons)
    end

    def points
      points = []
      @polygons.each do |polygon|
        points << polygon.points
      end
      points.flatten!.uniq!
    end
  end

  class SmartMultiPolygonGroup
    include Editable
    attr_accessor :parts
    
    def initialize(*parts)
      @parts = []
      parts.each do |p|
        @parts << p
      end
    end

    def points
      points = []
      @parts.each do |part|
        points << part.points
      end
      points.flatten!.uniq!
    end
  end

  class SmartText < Text
    attr_accessor :tspans, :x, :y, :font_family, :font_size, :color, :font_weight

    def initialize(str, options={})
      options.each do |option, value|
        case option.to_sym
        when :x
          @x = value
        when :y
          @y = value
        when :font_family
          @font_family = value
        when :font_size
          @font_size = value
        when :color
          @color = value
        when :font_weight
          @font_weight = value
        end
      end
      super(str)
    end
  end
end