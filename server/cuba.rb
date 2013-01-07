require 'cuba'
require_relative '../back/models/everbird'
require "cuba/render"
require 'sass'
require 'coffee-script'

Cuba.plugin Cuba::Render

Cuba.define do
  on get do
    on root do
      counter = "now"
      bird = Everbird.party!
      res.write render('front/index.html.erb', bird: bird, counter: counter)
    end

    on "countdown/:counter" do |counter|
      res.redirect("/") unless counter.numeric?
      bird = Everbird.say(counter)
      res.write render('front/index.html.erb', bird: bird, counter: counter)
    end

    on "styles", extension('css') do |file|
      res['Content-Type'] = 'text/css'
      res.write render("front/styles/#{File.basename(file)}.scss")
    end

    on "scripts", extension('coffee') do |file|
      res.write render("front/scripts/#{File.basename(file)}.js.coffee")
    end

    on "404" do
      bird = Everbird.say('404')
      res.write render('front/404.html.erb', bird: bird)
    end

    on ":anything_else" do
      res.redirect '/404'
    end
  end

  on post do
    on "party" do
      bird = Everbird.party!
      res.write bird.to_svg
    end

    on "say" do
      on param("word") do |word| 
        bird = Everbird.say(word)
        res.write bird.to_svg
      end
    end
  end
end

class String
  def numeric?
    Integer(self) != nil rescue false
  end
end