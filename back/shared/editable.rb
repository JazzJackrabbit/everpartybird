module Editable
  def self.included(base)
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
      @color = color
    end

    def color(color)
      dup.tap { |result| result.color!(color) }
    end
  end

  module SmartMultiPolygonMethods
    def color!(color)
      @polygons.each { |p| p.color!(color) }
    end

    def color(color)
      dup.tap { |result| result.color!(color) }
    end
  end

  module SmartMultiPolygonGroupMethods
    def color!(color)
      @parts.each do |p|
        p.polygons.each { |pp| pp.color!(color) }
      end
    end

    def color(color)
      dup.tap { |result| result.color!(color) }
    end

    def scale!(lvl)
      points.each do |point|
        point.x = point.x * lvl
        point.y = point.y * lvl
      end
    end

    def scale(lvl)
      dup.tap { |result| result.scale!(lvl) }
    end
  end

  module EverbirdMethods
    def color!(color)
      @bird.color!(color)
    end
    
    def color(color)
      dup.tap { |result| result.color!(color) }
    end

    def scale!(lvl)
      @bird.scale!(lvl)
    end

    def scale(lvl)
      dup.tap { |result| result.bird = @bird.scale(lvl) }
    end

    def config!(options={})
      options.each do |option, value|
        case option.to_sym
        when :color
          color!(value)
        when :scale
          scale!(value)
        end
      end
    end

    def config(options={})
      dup.tap { |result| result.config!(options) }
    end
  end
end