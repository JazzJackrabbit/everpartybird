module Shapes
  class Point < Struct.new(:x, :y)
    def to_s
      "#{format("%.2f",self.x)},#{format("%.2f",self.y)}"
    end

    def self.between(a,b)
      x = (b.x-a.x).abs/2 + a.x
      y = (b.y-a.y).abs/2 + a.y
      Point.new(x,y) 
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

  class Text
    attr_accessor :text
    def initialize(str)
      @text = str
    end
  end
end