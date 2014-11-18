require 'gosu'

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


class Player
  def initialize(window)
    @image = Gosu::Image.new(window, "img/twitter.png", false)
    @x = @y = @vel_x = @vel_y = 0.0 
    @angle = 90.0
    @score = 0
  end

  def warp(x, y)
    @x, @y = x, y
  end

  def turn_left
    @angle -= 4.5
  end

  def turn_right
    @angle += 4.5
  end

  def accelerate
    @vel_x += Gosu::offset_x(@angle, 0.9)
    @vel_y += Gosu::offset_y(@angle, 0.5)
  end

  def move
    @x += @vel_x
    @y += @vel_y
    @x %= 3600
    @y %= 2600

    @vel_x *= 0.95
    @vel_y *= 0.95
  end

  def draw
    @image.draw_rot(@x, @y, 1, @angle)
  end
end

class GameWindow < Gosu::Window
  def initialize
    super 3600, 2600, false
    self.caption = "SPACE!  Er..."
    @background_image = Gosu::Image.new(self, "img/ny.jpg", true)

    @enemy_image = Gosu::Image.new(self, "img/swarm.png", true)

    @player = Player.new(self)
    @player.warp(320, 240)

    @enemy = Enemy.new(self)

    @song = Gosu::Song.new(self, "audio/soundtrack.mp3")
    @song.play
  end

  def update
    if button_down? Gosu::KbLeft or button_down? Gosu::GpLeft then
      @player.turn_left
    end
    if button_down? Gosu::KbRight or button_down? Gosu::GpRight then
      @player.turn_right
    end
    if button_down? Gosu::KbUp or button_down? Gosu::GpButton0 then
      @player.accelerate
    end
    @player.move
    @enemy.move
  end

  def draw
    @player.draw
    @enemy.draw
    @background_image.draw(0, 0, 0)
  end

  def button_down(id)
    if id == Gosu::KbEscape
      close
    end
  end
end

window = GameWindow.new
window.show