require_relative '../shared/scalable'
require_relative '../models/color'
module Editable
  def self.included(base)
    base.send :include, Scalable
    case base.to_s
    when 'SmartShapes::SmartPolygon'
      base.send :include, SmartPolygonMethods
    when 'SmartShapes::SmartMultiPolygon'
      base.send :include, SmartMultiPolygonMethods
    when 'SmartShapes::SmartMultiPolygonGroup'
      base.send :include, SmartMultiPolygonGroupMethods
    when 'Everbird'
      base.send :include, EverbirdMethods
    end
  end

  module SmartPolygonMethods
    def color!(color)
      @color = Color.color(color)
      self
    end

    def color(color)
      dup.tap { |result| result.color!(color) }
    end

    def shift!(x,y)
      @points.each do |pp|
        pp.x = pp.x + x
        pp.y = pp.y + y
      end
      self
    end

    def shift(x,y)
      dup.tap { |result| result.shift!(x,y) } 
    end
  end

  module SmartMultiPolygonMethods
    def color!(color)
      @polygons.each { |p| p.color!(color) }
      self
    end

    def color(color)
      dup.tap { |result| result.color!(color) }
    end

    def shift!(x,y)
      points.each do |pp|
        pp.x = pp.x + x
        pp.y = pp.y + y
      end
      self
    end

    def shift(x,y)
      dup.tap { |result| result.shift!(x,y) } 
    end
  end

  module SmartMultiPolygonGroupMethods
    def color!(color)
      @parts.each { |pp| pp.color!(color) }
      self
    end

    def color(color)
      dup.tap { |result| result.color!(color) }
    end

    def shift!(x,y)
      points.each do |pp|
        pp.x = pp.x + x
        pp.y = pp.y + y
      end
      self
    end

    def shift(x,y)
      dup.tap { |result| result.shift!(x,y) } 
    end
  end

  module EverbirdMethods
    def color!(color)
      @bird.color!(color)
      self
    end
    
    def color(color)
      dup.tap { |result| result.color!(color) }
    end
  end
end