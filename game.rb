require 'gosu'
require_relative 'enemy'
require_relative 'player'

class GameWindow < Gosu::Window
  def initialize
    super 3600, 2600, false
    self.caption = "SPACE!  Er..."
    @background_image = Gosu::Image.new(self, "img/ny.jpg", true)

    @enemy_image = Gosu::Image.new(self, "img/swarm.png", true)

    @player = Player.new(self)
    @player.warp(320, 240)

    @enemy = Enemy.new(self)

    # @song = Gosu::Song.new(self, "audio/soundtrack.mp3")
    # @song.play
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
    if button_down? Gosu::Button::KbSpace then
      @player.shoot
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