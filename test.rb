require 'ruby2d'
set title: 'The End of Day Game', background: 'navy'
set resizable: true

skeleton_animation = Sprite.new(
  'img/skeleton_all_animations.png',
  clip_width: 128,
  time: 200,
  width: 128,
  height: 128,
  x: 0, y: 300,
  animations: {
    idle: 1..6,
    walk: 7..14,
    attack: 15..18,
    jump: 19..28,
    hurt: 29..31,
    dead: 32..34,
  }
)

# Set the initial x velocity when walking
walk_velocity = 2

# Variable to track whether the character is currently walking
walking_right = false
walking_left = false

on :key_down do |event|
  case event.key
  
  end
end

on :key_up do |event|
  case event.key
  when 'a', 'd'
    skeleton_animation.play animation: :idle, loop: true
    walking_left = false
    walking_right = false
  end
end

update do
  if walking_right
    # Move the character horizontally according to its walking velocity
    skeleton_animation.x += walk_velocity
  end
  if walking_left
    # Move the character horizontally according to its walking velocity
    skeleton_animation.x -= walk_velocity
  end
end

show
