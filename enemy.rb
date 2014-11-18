class Enemy
  def initialize(window)
    @image = Gosu::Image.new(window, "img/swarm.png", false)
    @x = @y = @vel_x = @vel_y = 20
  end
 
  def move
    @x += @vel_x
    @y += @vel_y
    @x %= 3600
    @y %= 2600

    @vel_x *= 1.0
    @vel_y *= 1.0
  end

  def draw
    @image.draw(@x, @y, 1)
  end

end