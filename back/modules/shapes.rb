module Shapes
  class Point < Struct.new(:x, :y)
    def to_s
      "#{format("%.2f",self.x)},#{format("%.2f",self.y)}"
    end
  end

  class Polygon
    attr_accessor :points
    def initialize(*points)
      @points = Array.new
      points.each do |p|
        @points << p
      end
    end
  end

  class MultiPolygon
    attr_accessor :polygons
    def initialize(*polygons)
      @polygons = []
      polygons.each do |p|
        @polygons << p
      end
    end
  end
end