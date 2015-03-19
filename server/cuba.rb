require_relative '../lib/initializers'

Cuba.plugin Cuba::Render
Cuba.settings[:render][:template_engine] = "slim"
Cuba.settings[:render][:views] = "#{WEB_DIR}/#{PAGES_DIR}"
Cuba.settings[:render][:layout] = "layout"

Cuba.define do
  on get do
    # Routes
    on root do
      counter = "now"
      bird = Everbird.party!
      res.write view 'index', bird: bird, counter: counter
    end

    on "countdown/:counter" do |counter|
      res.redirect("/") unless counter.numeric?
      bird = Everbird.say(counter)
      res.write view 'index', bird: bird, counter: counter
    end

    on "say/:word" do |word|
      bird = Everbird.say(word)
      res.write bird.to_html
    end

    on "404" do
      bird = Everbird.say('404')
      res.write partial '404', bird: bird
    end

    # SASS & Coffee
    on STYLES_DIR, extension('css') do |file|
      res['Content-Type'] = MimeType.CSS
      filepath = File.join(WEB_DIR, STYLES_DIR, "#{File.basename(file)}.css")
      open(filepath) { |io| res.write(io.read) }
    end

    on SCRIPTS_DIR, extension('coffee') do |file|
      res['Content-Type'] = MimeType.JavaScript
      filepath = File.join(WEB_DIR, SCRIPTS_DIR, "#{File.basename(file)}.js.coffee")
      open(filepath) { |io| res.write CoffeeScript.compile(io.read) }
    end

    # Images (JPG, PNG, GIF, SVG)
    on IMAGES_DIR, extension('jpg') do |file|
      res['Content-Type'] = MimeType.JPG
      filepath = File.join(WEB_DIR, IMAGES_DIR, "#{File.basename(file)}.jpg")
      open(filepath) { |io| res.write(io.read) }
    end

    on IMAGES_DIR, extension('png') do |file|
      res['Content-Type'] = MimeType.PNG
      filepath = File.join(WEB_DIR, IMAGES_DIR, "#{File.basename(file)}.png")
      open(filepath) { |io| res.write(io.read) }
    end

    on IMAGES_DIR, extension('gif') do |file|
      res['Content-Type'] = MimeType.GIF
      filepath = File.join(WEB_DIR, IMAGES_DIR, "#{File.basename(file)}.gif")
      open(filepath) { |io| res.write(io.read) }
    end

    on IMAGES_DIR, extension('svg') do |file|
      res['Content-Type'] = MimeType.SVG
      filepath = File.join(WEB_DIR, IMAGES_DIR, "#{File.basename(file)}.svg")
      open(filepath) { |io| res.write(io.read) }
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
