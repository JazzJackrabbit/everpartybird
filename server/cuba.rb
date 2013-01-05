require 'cuba'
require_relative '../back/models/everbird'
require "cuba/render"

Cuba.plugin Cuba::Render
# Cuba.settings[:render][:template_engine] = "erb"

Cuba.define do
  on get do
    on root do
      bird = Everbird.new.config({
        scale: 30,
        color: '#46d623'
      })
      res.write render('front/index.html.erb', bird: bird)
    end
  end
end