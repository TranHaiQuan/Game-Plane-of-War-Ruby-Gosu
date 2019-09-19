require "gosu"
require "./scripts/player"
require "./scripts/star"
require "./scripts/z_order"


class GameManager < Gosu::Window
  def initialize
    super 1200, 900
    self.caption = "Cuộc Chiến Không Trung"
    @backgroud_image = Gosu::Image.new("images/BG.png", :tileable => true)

    @player = Player.new
    @player.wrap(600, 450)

    @star_anim = Gosu::Image.load_tiles("images/Plane/star.png", 25, 25)
    @stars = Array.new
  end

  def update
    if Gosu.button_down?(Gosu::KB_LEFT) || Gosu::button_down?(Gosu::GP_LEFT)
      @player.back
    end

    if Gosu.button_down?(Gosu::KB_RIGHT) || Gosu::button_down?(Gosu::GP_RIGHT)
      @player.front
    end

    if Gosu.button_down?(Gosu::KB_UP) || Gosu::button_down?(Gosu::GP_BUTTON_0)
      @player.up
    end

    if Gosu.button_down?(Gosu::KB_DOWN) || Gosu::button_down?(Gosu::GP_BUTTON_0)
      @player.down
    end
    @player.move

    @player.collect_stars @stars

    @stars.push(Star.new(@star_anim)) if rand(100) < 3 && @stars.size < 25
  end

  def draw
    @backgroud_image.draw(0, 0, 0)
    @player.draw
    @stars.each(&:draw)
  end

  def button_down id
    return close if id == Gosu::KB_ESCAPE
    super
  end
end

GameManager.new.show

