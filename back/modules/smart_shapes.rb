require_relative 'shapes'
require_relative '../shared/editable'

module SmartShapes
  include Shapes

  class SmartPolygon < Polygon
    include Editable
    attr_accessor :color

    def initialize(*points)
      @color = "#60e041"
      super(*points)
    end
  end

  class SmartMultiPolygon < MultiPolygon
    include Editable
    attr_accessor :name

    def initialize(name, *polygons)
      @name = name
      super(*polygons)
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

    protected 
    def points
      points = []
      parts.each do |part|
        part.polygons.each do |polygon|
          polygon.points.each do |point|
            points << point
          end
        end
      end
      points.uniq!
    end
  end
end