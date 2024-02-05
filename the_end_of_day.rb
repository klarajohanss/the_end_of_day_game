require 'ruby2d'
set title: 'The End of Day Game', background: 'navy'
set resizable: true
#Image.new('img/background_og.png')


skeleton_animation = Sprite.new(
  'img/skeleton_all_animations.png',
  clip_width: 128,
  time: 200,
  width: 128,
  height: 128,
  x:0, y:300,
  animations: {
    idle: 1..6,
    walk: 7..14,
    attack: 15..18,
    jump: 19..28,
    hurt: 29..31,
    dead: 32..34,
  }
)

skeleton_animation.play animation: :idle, loop: true

# Set the initial x velocity when walking
walk_velocity = 2
# Variable to track whether the character is currently walking
walking_right = false
walking_left = false
facing_left = false

on :key_up do |event|
  case event.key
    when 'w'
      skeleton_animation.play animation: :idle, loop: true
    when'p','h'
      skeleton_animation.play animation: :idle, loop: true
    when 'j'
      skeleton_animation.play animation: :dead, loop: nil #fix animation for dead dead
    when 'a', 'd'
      skeleton_animation.play animation: :idle, loop: true
      walking_left = false
      walking_right = false
  end
end


on :key_down do |event|
  case event.key
    when 'a'
      skeleton_animation.play animation: :walk, loop: true, flip: :horizontal
      walking_left = true
      facing_left = true
    when 'd'
      skeleton_animation.play animation: :walk, loop: true
      walking_right = true
      facing_left = false
    when 'w'
      if facing_left
        skeleton_animation.play animation: :jump, loop: false, flip: :horizontal
      else
        skeleton_animation.play animation: :jump, loop: false
      end
      skeleton_animation.y -= 20
    when 'p'
      if facing_left
        skeleton_animation.play animation: :attack, loop: false, flip: :horizontal
      else
        skeleton_animation.play animation: :attack, loop: false
      end
    when 'h'
      skeleton_animation.play animation: :hurt, loop: false
    when 'j'
      skeleton_animation.play animation: :dead, loop: nil
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