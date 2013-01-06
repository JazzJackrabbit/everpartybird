require_relative 'back/models/everbird'

bird = Everbird.new.config({
  # order matters
  scale: 30,
  color: 'bird',
  bubble: {
    static_scale: [1.5,1],
    color: 'bubble'
  },
  content: {
    text: 'lab!',
    dx: 70,
    dy: 70,
    font_family: 'fantasy',
    font_size: '60',
    font_weight: 'bold',
    color: '#eeeeee'
  }
})

bird.open