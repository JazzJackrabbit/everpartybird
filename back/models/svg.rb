class SVG
  def self.svg(model)
    case model.class.to_s
    when 'SmartShapes::SmartPolygon'
      points = ""
      model.points.each do |p|
        points = "#{points}#{p.to_s} "
      end
      "<polygon  points=\"#{points}\" fill=\"#{model.color}\" />"

    when 'SmartShapes::SmartMultiPolygon'
      output = "<!-- #{model.name} -->\n"
      model.polygons.each do |p|
        output << "#{SVG.svg(p)}\n"
      end
      output

    when 'SmartShapes::SmartMultiPolygonGroup'
      output = ""
      model.parts.each do |name, smp|
        output << "#{SVG.svg(smp)}\n"
      end
      output

    when 'Everbird'
      output = "<svg xmlns=\"http://www.w3.org/2000/svg\" version=\"1.1\">\n"
      model.bird.parts.each do |part|
        output << SVG.svg(part)
      end
      output << "</svg>"
    end
  end
end