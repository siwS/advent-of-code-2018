class Point
  attr_accessor :x, :y, :vel_x, :vel_y

  def initialize(position, velocity)
    @x = position.split(",")[1].to_i
    @y = position.split(",")[0].to_i
    @vel_x = velocity.split(",")[1].to_i
    @vel_y = velocity.split(",")[0].to_i
    @initial_x = @x
    @initial_y = @y
  end

  def move(t)
    @x = @initial_x + t * @vel_x
    @y = @initial_y + t * @vel_y
  end

end