require "./scripts/z_order"

class Star
  attr_reader :x, :y

  def initialize animation
    @animation = animation

    # init color star
    @color = Gosu::Color::BLACK.dup
    @color.red = rand(256 - 40) + 40
    @color.green = rand(256 - 40) + 40
    @color.blue = rand(256 - 40) + 40

    # random position of star in 1200 x 900
    @x = rand * 1200
    @y = rand * 900
  end

  def draw
    img = @animation[Gosu.milliseconds / 100 % @animation.size]
    # set position to set center star
    img.draw(@x - img.width / 2.0, @y - img.height / 2.0, ZOrder::STARS, 1, 1, @color, :add)
  end
end
