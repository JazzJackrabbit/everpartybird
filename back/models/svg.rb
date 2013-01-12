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

    when 'SmartShapes::SmartText'
      x, y, font_family = model.x, model.y, model.font_family
      font_size, color, font_weight = model.font_size, model.color, model.font_weight
      output = "<text x=\"#{x}\" y=\"#{y}\" font-family=\"#{font_family}\" font-size=\"#{font_size}\"
                font-weight=\"#{font_weight}\" fill=\"#{color}\">"
      output << model.text
      output << "</text>\n"

    when 'Everbird'
      output = "<svg xmlns=\"http://www.w3.org/2000/svg\" version=\"1.1\" width=\"100%\" height=\"100%\">\n"
      model.bird.parts.each do |part|
        output << SVG.svg(part)
      end
      if model.text
        output << SVG.svg(model.bubble)
        output << SVG.svg(model.text)
      end
      output << "</svg>"
    end
  end
end