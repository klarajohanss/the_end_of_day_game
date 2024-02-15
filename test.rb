require 'ruby2d'
set title: 'The End of Day Game', background: 'navy'
set resizable: false
set width: 800
set height: 600

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

lives = 5

heart1 = Image.new(
  'img/heart.png',
  x: 735, y:540, z: 5,
  width: 46, height: 43,
)
heart2 = Image.new(
  'img/heart.png',
  x: 689, y:540, z: 1,
  width: 46, height: 43, 
)
heart3 = Image.new(
  'img/heart.png',
  x: 643, y:540, z: 1,
  width: 46, height: 43, 
)
heart4 = Image.new(
  'img/heart.png',
  x: 597, y:540, z: 1,
  width: 46, height: 43, 
)
heart5 = Image.new(
  'img/heart.png',
  x: 551, y:540, z: 1,
  width: 46, height: 43, 
)
update do 
  if lives == 5
    heart1.add
    heart2.add
    heart3.add
    heart4.add
    heart5.add
  elsif lives == 4
    heart1.add
    heart2.add
    heart3.add
    heart4.add
    heart5.remove
  end

end




show 