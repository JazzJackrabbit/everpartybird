require 'rubygems'
require 'launchy'
require 'fileutils'
require './modules/smart_shapes'

class Everbird
  include SmartShapes

  attr_accessor :bird

  def initialize  
    a = Point.new(0.2, 11)
    b = Point.new(1.8, 12.6)
    c = Point.new(0.5, 13.6)
    d = Point.new(0.8, 12.8)
    e = Point.new(4.4, 9.3)
    f = Point.new(6.1, 12.6)
    g = Point.new(5.3, 12.8)
    h = Point.new(4.8, 10.5) 
    i = Point.new(9.6, 4.8)
    j = Point.new(16.1, 7.1)
    k = Point.new(17.2, 9.3)
    l = Point.new(16.3, 6.2)
    m = Point.new(10.2, 11.4)
    n = Point.new(10.6, 12.8)
    o = Point.new(8.8, 11.8)
    p = Point.new(8.9, 4.4)
    q = Point.new(13.6, 1.4)
    r = Point.new(12.6, 13.15)
    s = Point.new(13.6, 13.8)
    t = Point.new(13.2, 14.4)
    u = Point.new(11, 14.4)
    v = Point.new(18.2, 1.1)
    w = Point.new(17.2, 0.4)
    x = Point.new(19.2, 2.8)
    y = Point.new(19.5, 3.8)
    z = Point.new(17.5, 3)

    tp1 = SmartPolygon.new(a,b,d)
    tp2 = SmartPolygon.new(d,b,c)
    tp3 = SmartPolygon.new(c,h,g)
    tp4 = SmartPolygon.new(e,f,g)
    bp1 = SmartPolygon.new(e,i,j,k,f)
    bp2 = SmartPolygon.new(o,n,m)
    bp3 = SmartPolygon.new(i,p,l,j)
    lp1 = SmartPolygon.new(m,k,u)
    lp2 = SmartPolygon.new(r,s,t)
    lp3 = SmartPolygon.new(r,t,u)
    hp1 = SmartPolygon.new(p,q,v,l)
    hp2 = SmartPolygon.new(q,w,v)
    hp3 = SmartPolygon.new(v,x,z)
    hp4 = SmartPolygon.new(x,y,z)

    tail = SmartMultiPolygon.new('tail', tp1, tp2, tp3, tp4)
    body = SmartMultiPolygon.new('body', bp1, bp2, bp3)
    leg = SmartMultiPolygon.new('leg', lp1, lp2, lp3)
    head = SmartMultiPolygon.new('head', hp1, hp2, hp3, hp4)

    @bird = SmartMultiPolygonGroup.new(tail, body, leg, head)
  end

  def scale(lvl)
    dup.tap do |result|
      result.bird = @bird.scale(lvl)
    end
  end

  def to_svg
    output = "<svg xmlns=\"http://www.w3.org/2000/svg\" version=\"1.1\">\n"
    @bird.parts.each do |part|
      output << part.to_svg
    end
    output << "</svg>\n"
  end

  def to_html
    "<html>\n<body>\n#{to_svg}\n</body>\n</html>"
  end

  def save(filename='everbird.html')
    File.open(filename, 'w') do |f|
      f.write to_html
    end
  end

  def open
    dir = '../tmp'
    filename = 'everbird.html'
    path = "#{dir}/#{filename}"
    FileUtils.mkdir_p(dir)
    save(path)
    Launchy.open(path)
    sleep 5
    FileUtils.rm_rf(dir)
  end

  def color(color)
    dup.tap do |result|
      result.bird = @bird.color(color)
    end
  end
end