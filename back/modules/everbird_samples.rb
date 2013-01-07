module EverbirdSamples
  def party!
    Everbird.new.config({
      scale: 30,
      color: 'party!',
      bubble: {
        color: 'party!'
      },
      content: {
        text: "Party!",
        font_weight: 'bold',
        color: 'party!'
      }
    })
  end

  def lab!
    Everbird.new.config({
      scale: 30,
      color: 'bird',
      bubble: {
        color: 'bubble'
      },
      content: {
        text: "lab!",
        font_weight: 'bold',
        color: 'party!'
      }
    })
  end

  def say(text)
    Everbird.new.config({
      scale: 30,
      color: 'bird',
      bubble: {
        color: 'bubble'
      },
      content: {
        text: text,
        color: '#eeeeee'
      }
    })
  end
end