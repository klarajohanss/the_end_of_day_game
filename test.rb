require 'ruby2d'
set title: 'The End of Day Game', background: 'navy'
set resizable: true
set width: 800
set height: 600

#fire sprite
fire_animation = Sprite.new(
  'img/fire_all_animations.png',
  clip_width: 128,
  time: 200,
  width: 192,
  height: 192,
  x:200, y:300, z:10,
  animations: {
    idle: 0..5,
    hurt: 6..8,
    explosion: 9..19,
    dead: 20..25,
    attack: 26..39,
  }
)


on :key_down do |event|
  case event.key
    when 'up'
       fire_animation.play animation: :idle, loop: true
    when 'down'
      fire_animation.play animation: :hurt, loop: true
    when 'right'
      fire_animation.play animation: :explosion, loop: true
    when 'left'
      fire_animation.play animation: :dead, loop: true
    when 'm'
      fire_animation.play animation: :attack, loop: true
  end
end



show 