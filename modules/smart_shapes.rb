require_relative 'shapes'
module SmartShapes
  include Shapes

  class SmartPolygon < Polygon
    attr_accessor :color

    def initialize(*points)
      @color = "#60e041"
      super(*points)
    end

    def to_svg
      points = ""
      @points.each do |p|
        points = "#{points}#{p.to_s} "
      end
      "<polygon  points=\"#{points}\" fill=\"#{@color}\" />"
    end

    def color(color)
      @color = color
    end
  end

  class SmartMultiPolygon < MultiPolygon
    attr_accessor :name
    def initialize(name, *polygons)
      @name = name
      super(*polygons)
    end

    def to_svg
      output = "<!-- #{@name} -->\n"
      @polygons.each do |p|
        output << "#{p.to_svg}\n"
      end
      output
    end

    def color(color)
      self.dup.tap do |result|
        result.polygons.each { |p| p.color(color) }
      end
    end
  end

  class SmartMultiPolygonGroup
    attr_accessor :parts
    def initialize(*parts)
      @parts = []
      parts.each do |p|
        @parts << p
      end
    end

    def to_svg
      output = ""
      @parts.each do |name, smp|
        output << "#{smp.to_svg}\n"
      end
      output
    end

    def scale(scale_level)
      dup.tap do |result|
        result.points.each do |point|
          point.x = point.x * scale_level
          point.y = point.y * scale_level
        end
      end
    end

    def color(color)
      dup.tap do |result|
        result.parts.each do |p|
          p.polygons.each { |pp| pp.color(color) }
        end
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