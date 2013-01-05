require_relative '../modules/smart_shapes'
require_relative 'svg'
require_relative 'html_worker'

class Everbird
  include SmartShapes
  include Editable
  include Configurable

  attr_accessor :bird, :bubble, :text

  def initialize(text=nil)
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
    leg  = SmartMultiPolygon.new('leg', lp1, lp2, lp3)
    head = SmartMultiPolygon.new('head', hp1, hp2, hp3, hp4)

    @bird = SmartMultiPolygonGroup.new(tail, body, leg, head)

    a1 = Point.new(0, 0)
    b1 = Point.new(2.4, 1.4)
    c1 = Point.new(4.6, 1.7)
    d1 = Point.new(5.3, 2.7)
    e1 = Point.new(6.3, 3.2)
    f1 = Point.new(6.3, 4.6)
    g1 = Point.new(3.2, 7.1)
    h1 = Point.new(1.3, 6.6)
    i1 = Point.new(0, 4.2)

    bb1 = SmartPolygon.new(a1,g1,h1,i1)
    bb2 = SmartPolygon.new(a1,b1,c1,d1,g1)
    bb3 = SmartPolygon.new(g1,d1,e1,f1)

    @bubble = SmartMultiPolygon.new('bubble', bb1, bb2, bb3).shift(20,5)
   end

  def say!(options={})
    p = Point.between(@bubble.top_left_point, @bubble.points[3])
    x,y = p.x + options[:dx].to_i, p.y+options[:dy].to_i
    @text = SmartText.new(options[:text], 
      x: x,
      y: y,
      font_family: options[:font_family],
      font_size: options[:font_size],
      font_weight: options[:font_weight],
      color: Color.color(options[:color]))
  end

  def to_svg
    SVG.svg(self)
  end

  def to_html
    style = "html{
      background-color: white;
    }
    #main {
      padding: 115px 0 0 235px;
    }"
    content = "<section id=\"main\">\n
      #{to_svg}\n
    </section>"
    HTMLWorker.wrap(content, style)
  end

  def save(filename='everbird.html', dir='../saved')
    HTMLWorker.save(filename, dir, to_html)
  end

  def open
    HTMLWorker.open(to_html)
  end
end