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

skeleton_default = (skeleton_animation.play animation: :idle, loop: true)



def main()
  skeleton_default


end

on :key_held do |event|
  case event.key
    when 'a'
      skeleton_animation.play animation: :walk, loop: true, flip: :horizontal
    when 'd'
      skeleton_animation.play animation: :walk, loop: true
  end
end

on :key_down do |event|
  case event.key
    when 'w'
      skeleton_animation.play animation: :jump, loop: nil
    when 'p'
      skeleton_animation.play animation: :attack, loop: nil
    when 'h'
      skeleton_animation.play animation: :hurt, loop: nil
    when 'j'
      skeleton_animation.play animation: :dead, loop: nil
  end
end




show