class Color
  def self.color(color)
    case color
      when 'party!'
        random 
      when 'bird'
        '#46d623'
      when 'bubble'
        '#a0d2d8'
      when 'red'
        '#ff0000'
      when 'green'
        '#00ff00'
      when 'blue'
        '#0000ff'
      when 'lightgrey'
        '#eeeeee'
      when 'white'
        '#ffffff'
      when 'black'
        '#000000'
      else
        color
    end
  end

  def self.random
    "#" << ( "%06x" % (rand * 0xffffff) )
  end
end