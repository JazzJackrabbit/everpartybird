require 'cuba'
require_relative '../back/models/everbird'
require "cuba/render"

Cuba.plugin Cuba::Render

Cuba.define do
  on get do
    on root do
      bird = Everbird.new.config({
        scale: 30,
        color: 'bird',
        bubble: {
          static_scale: [1,1],
          color: 'bubble'
        },
        content: {
          text: '10',
          dx: 70,
          dy: 70,
          font_family: 'fantasy',
          font_size: '60',
          # font_weight: 'bold',
          color: '#eeeeee'
        }
      })
      res.write render('front/index.html.erb', bird: bird)
    end

    on "404" do
      bird = Everbird.new.config({
        scale: 30,
        color: 'bird',
        bubble: {
          static_scale: [1.5,1],
          color: 'bubble'
        },
        content: {
          text: '404',
          dx: 70,
          dy: 70,
          font_family: 'fantasy',
          font_size: '60',
          color: '#eeeeee'
        }
      })
      res.write render('front/404.html.erb', bird: bird)
    end
  end

  on post do
    on "party" do
      bird = Everbird.new.config({
        scale: 30,
        color: 'party!',
        bubble: {
          static_scale: [1.5,1],
          color: 'party!'
        },
        content: {
          text: 'Party!',
          dx: 60,
          dy: 70,
          font_family: 'fantasy',
          font_size: '60',
          font_weight: 'bold',
          color: 'party!'
        }
      })
      res.write bird.to_svg
    end

    on "tick" do
      on param("timestamp") do |timestamp|
        bird = Everbird.new.config({
          scale: 30,
          color: 'bird',
          bubble: {
            static_scale: [1,1],
            color: 'bubble'
          },
          content: {
            text: "#{timestamp.to_i - 1}",
            dx: 70,
            dy: 70,
            font_family: 'fantasy',
            font_size: '60',
            # font_weight: 'bold',
            color: '#eeeeee'
          }
        })
        res.write bird.to_svg
      end
    end
  end
end