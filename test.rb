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

on :key_held do |event|
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

show
