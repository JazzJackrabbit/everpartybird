require_relative 'back/models/everbird'

bird = Everbird.new.config({
  scale: 30,
  color: '#46d623'
})

bird.open