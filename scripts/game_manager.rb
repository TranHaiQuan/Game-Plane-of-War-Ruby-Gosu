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
    @font = Gosu::Font.new(20)

    # Gosu::Song to play background sound
    @bg_sound = Gosu::Song.new("sounds/bg_sound.mp3")
    @bg_sound.play(true)
    @is_shooted = false
  end

  def update
    if Gosu.button_down?(Gosu::KB_SPACE)
      puts "shotting"
      @player.shoot
      @is_shooted = true
    end

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
    @font.draw("SCORE: #{@player.score}", 10, 10, ZOrder::UI, 1.0, 1.0, Gosu::Color::YELLOW)
  end

  def button_down id
    return close if id == Gosu::KB_ESCAPE
    super
  end

  def button_up id
    return close if id == Gosu::KB_ESCAPE
    super
  end
end

GameManager.new.show

