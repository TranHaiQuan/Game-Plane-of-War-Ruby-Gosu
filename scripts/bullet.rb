require "./scripts/z_order"

class Bullet
  def initialize playerX, playerY
    @animation = init_animation
    @x = playerX
    @y = playerY
    @vel_y = @y
  end

  def update
    move
  end

  def move
    @vel_y += Gosu.offset_y(0, 0.5)
    @y += @vel_y
    @y %= 900

    @vel_y *= 0.95
  end

  def draw
    img = @animation[Gosu.milliseconds / 100 % @animation.size]
    # set position to set center star
    img.draw(@x, @y, ZOrder::BULLET, 1, 1, Gosu::Color::WHITE, :add)
  end

  private
  def init_animation
    5.times.map do |id|
      Gosu::Image.new("images/Bullet/Bullet_#{id + 1}.png", :tileable => true)
    end
  end
end
