require "./scripts/bullet"

class Player
  def initialize
    @flying_anim = init_animation_for "Fly", 2
    @shoot_anim = init_animation_for "Shoot", 5
    @player = Gosu::Image.new("images/Plane/Fly_1.png", :tileable => true)

    # Gosu::Sample to play effect sound
    @beep_audio = Gosu::Sample.new("sounds/beep.wav")
    @x = @y = @vel_x = @vel_y = @angle = 0.0
    @score = 0
    @bullets = Array.new
  end

  def wrap x, y
    puts "Warping..."
    @x, @y = x, y
  end

  def turn_left
    puts "turning left..."
    @angle -= 4.5
  end

  def turn_right
    puts "turning right..."
    @angle += 4.5
  end

  def up
    puts "up ..."
    @vel_y += Gosu.offset_y(0, 0.5)
  end

  def down
    puts "down ..."
    @vel_y -= Gosu.offset_y(0, 0.5)
  end

  def front
    puts "front"
    @vel_x += Gosu.offset_x(90, 0.5)
  end

  def back
    puts "back"
    @vel_x -= Gosu.offset_x(90, 0.5)
  end

  def move
    @x += @vel_x
    @y += @vel_y
    @x %= 1200
    @y %= 900

    @vel_x *= 0.95
    @vel_y *= 0.95
  end

  def score
    @score
  end

  def collect_stars stars
    stars.reject! do |star|
      next false if Gosu.distance(@x, @y, star.x, star.y) >= 35
      @score += 10
      @beep_audio.play
      true
    end
  end

  def shoot
    @bullets.push(Bullet.new(@x, @y))
  end

  def draw
    @player = @flying_anim[Gosu.milliseconds / 100 % @flying_anim.size]
    @player.draw_rot(@x, @y, 1, @angle)
    @bullets.each(&:draw)
  end

  private
  def init_animation_for name, max_length
    max_length.times.map do |id|
      Gosu::Image.new("images/Plane/#{name}_#{id + 1}.png", :tileable => true)
    end
  end
end
