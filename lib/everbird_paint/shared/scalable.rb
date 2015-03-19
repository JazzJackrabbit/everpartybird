module Scalable
  def self.included(base)
    case base.to_s
    when 'SmartShapes::SmartPolygon'
      base.send :include, PolygonalMethods
    when 'SmartShapes::SmartMultiPolygon'
      base.send :include, PolygonalMethods
    when 'SmartShapes::SmartMultiPolygonGroup'
      base.send :include, PolygonalMethods
    when 'Everbird'
      base.send :include, EverbirdMethods
    end
  end          

  module PolygonalMethods
    def scale!(x,y=x)
      points.each do |point|
        point.x = point.x * x
        point.y = point.y * y
      end
    end

    def scale(x,y=x)
      dup.tap { |result| result.scale!(x,y) }
    end

    def static_scale!(x, y=x)
      points.each do |point|
        point.x = (point.x - top_left_point.x)*x + top_left_point.x
        point.y = (point.y - top_left_point.y)*y + top_left_point.y
      end
    end

    def static_scale(x,y=x)
      dup.tap { |result| result.static_scale!(x,y) }
    end

    def top_left_point
      tlp = points[0]
      points.each do |p|
        if (p.x <= tlp.x) && (p.y <= tlp.y)
          tlp = p
        end
      end
      tlp
    end
  end

  module EverbirdMethods
    def scale!(x,y=x)
      @bird.scale!(x,y)
    end

    def scale(x,y=x)
      dup.tap { |result| result.bird = @bird.scale(x,y) }
    end
  end
end