require 'ruby2d'

#defining global variables

#variables for initial game settings
$score = 0
$score_scaled = 0
$lives = 0
$level = 1
$walk_velocity = 2
$walking_right = false
$walking_left = false
$facing_left = false
$attacking = false
$fire_health = 280
$game_music = Music.new('music/game_music.mp3')
$game_music.loop = true
game_started = false

#skeleton sprite
$skeleton_animation = Sprite.new(
  'img/skeleton_all_animations.png',
  clip_width: 128,
  time: 200,
  width: 192,
  height: 192,
  x:0, y:300, z:15,
  animations: {
    idle: 0..6,
    walk: 7..14,
    attack: 15..18,
    jump: 19..28,
    hurt: 29..31,
    dead: 32..34,
  }
)

#fire sprite
$fire_animation = Sprite.new(
  'img/fire_all_animations.png',
  clip_width: 128,
  time: 200,
  width: 192,
  height: 192,
  x:480, y:315, z:10,
  animations: {
    idle: 0..5,
    hurt: 6..8,
    explosion: 9..19,
    dead: 20..25,
    attack: 26..39,
  }
)
$fire_animation.remove

#end door
$end_door = Rectangle.new(
  x: 1000, y: 370,
  width: 80, height: 110,
  color: 'navy',
  z: 10
)
$end_door.remove

#lives
$heart1 = Image.new(
  'img/heart.png',
  x: 735, y:540, z: 5,
  width: 46, height: 43,
)
$heart2 = Image.new(
  'img/heart.png',
  x: 689, y:540, z: 5,
  width: 46, height: 43, 
)
$heart3 = Image.new(
  'img/heart.png',
  x: 643, y:540, z: 5,
  width: 46, height: 43, 
)
$heart4 = Image.new(
  'img/heart.png',
  x: 597, y:540, z: 5,
  width: 46, height: 43, 
)
$heart5 = Image.new(
  'img/heart.png',
  x: 551, y:540, z: 5,
  width: 46, height: 43, 
)
$heart1.remove
$heart2.remove
$heart3.remove
$heart4.remove
$heart5.remove


#score counter
$score_counter = Text.new(
  "score: #{$score}",
  x: 15, y: 550,
  font:'other/DigitalDisco.ttf',
  size: 25,
  color: 'white',
  z: 5
)

#game over text
$game_over_text1 = Text.new(
  'Game Over!',
  x: 200, y: 170,
  font: 'other/DigitalDisco.ttf',
  #style: 'bold',
  size: 70,
  color: 'white',
  #rotate: 90,
  z: 5
)
$game_over_text1.remove

#level text
$level_text = Text.new(
  "Level #{$level}",
  x: 40, y:400,
  font:'other/DigitalDisco.ttf',
  size: 30,
  color: 'blue',
  z: 5
)
$level_text.remove

#intro texts
$intro_text1 = Text.new(
  'The End of Day',
  x: 180, y: 115,
  font: 'other/DigitalDisco.ttf',
  #style: 'bold',
  size: 65,
  color: 'white',
  #rotate: 90,
  z: 5
)
$intro_text2 = Text.new(
  'by Klara Johansson',
  x: 250, y: 185,
  font: 'other/DigitalDisco.ttf',
  #style: 'bold',
  size: 20,
  color: 'white',
  #rotate: 90,
  z: 5
)
$intro_text3 = Text.new(
  'click to continue',
  x: 350, y: 315,
  font: 'other/DigitalDisco.ttf',
  #style: 'bold',
  size: 25,
  color: 'white',
  #rotate: 90,
  z: 5
)
$intro_text1.remove
$intro_text2.remove
$intro_text3.remove

#level cleared text
$level_cleared_text = Text.new(
  'Level Completed!',
  x: 140, y: 170,
  font: 'other/DigitalDisco.ttf',
  #style: 'bold',
  size: 70,
  color: 'white',
  #rotate: 90,
  z: 5
)
$level_cleared_text.remove


#functions

#game over screen
def game_over
  $fire_animation.x = 1000
  set background: 'navy'
  $game_over_text1.add
  $score_counter.add
  $score_counter.x = 300
  $score_counter.y = 400
  
end

#showing introduction screen, adding sprite
def game_introduction
  set background: 'navy'

  $intro_text1.add
  $intro_text2.add
  $intro_text3.add

  $skeleton_animation.add
  $skeleton_animation.play animation: :idle, loop: true

end

#initlizes the game; setting background, adding sprites
def initialize_game

  $lives = 500

  $background = Image.new(
    'img/background_real.png',
    height: 600, 
  )
  
  $skeleton_animation.add
  $fire_animation.add
  $score_counter.add
  $level_text.add
  $end_door.add

  $skeleton_animation.play animation: :idle, loop: true
  $fire_animation.play animation: :idle, loop: true

end

#main function for updating the game; checking collisions, keyboard interaction, updating variables, etc.
def update_game
  #tracking amount of lives
  if $lives > 400
    $heart1.add
    $heart2.add
    $heart3.add
    $heart4.add
    $heart5.add
  elsif $lives > 300
    $heart1.add
    $heart2.add
    $heart3.add
    $heart4.add
    $heart5.remove
  elsif $lives > 200
    $heart1.add
    $heart2.add
    $heart3.add
    $heart4.remove
    $heart5.remove
  elsif $lives > 100
    $heart1.add
    $heart2.add
    $heart3.remove
    $heart4.remove
    $heart5.remove
  elsif $lives > 0
    $heart1.add
    $heart2.remove
    $heart3.remove
    $heart4.remove
    $heart5.remove
  else 
    $heart1.remove
    $heart2.remove
    $heart3.remove
    $heart4.remove
    $heart5.remove
  end

  #skeleton default mode, and flipping horizontally if nessecary
  on :key_up do |event|
    case event.key
      when 'a','d'
        $walking_left = false
        $walking_right = false
        if $facing_left
          $skeleton_animation.play animation: :idle, loop: true, flip: :horizontal
        else
          $skeleton_animation.play animation: :idle, loop: true
        end
      when 'p'
        $attacking = false
        $walking_left = false
        $walking_right = false
        if $facing_left
          $skeleton_animation.play animation: :idle, loop: true, flip: :horizontal
        else
          $skeleton_animation.play animation: :idle, loop: true
        end
    end
  end

  #skeleton movements when pressed keys
  on :key_down do |event|
    case event.key
      when 'a'
        $skeleton_animation.play animation: :walk, loop: true, flip: :horizontal 
        $walking_left = true
        $facing_left = true
      when 'd'
        $skeleton_animation.play animation: :walk, loop: true
        $walking_right = true
        $facing_left = false
      when 'p'
        $attacking = true
        if $facing_left
          $skeleton_animation.play animation: :attack, loop: false, flip: :horizontal
        else
          $skeleton_animation.play animation: :attack, loop: false
        end
    end
  end

  #fire exploding when close to skeleton
  if (($skeleton_animation.x - $fire_animation.x).abs < 190)
    $fire_animation.play animation: :explosion, loop: true
  else
    $fire_animation.play animation: :idle, loop: true
  end

  #skeleton takes damage when too close to fire
  if (($skeleton_animation.x - $fire_animation.x).abs < 50)
    if !$attacking
      $skeleton_animation.play animation: :hurt, loop: false
    end
    $lives-=2
    i=0
  end

  #fire takes damage 
  if ((($skeleton_animation.x - $fire_animation.x).abs < 110) && $attacking)
    $fire_health -= 1
    $score_scaled +=1
  end

  #updating score
  if $score_scaled >= 50
    $score += 50
    $score_counter.remove
    $score_counter = Text.new(
      "score: #{$score}",
      x: 15, y: 550,
      font:'other/DigitalDisco.ttf',
      size: 25,
      color: 'white',
    	z: 5
    )
    $score_scaled = 0
  end

  #fire dies
  if $fire_health<1
    $fire_animation.remove
    $fire_animation.x = 1000
    $fire_animation.y = -1000
  end

  #skeleton dies
  if $lives<0
    $game_music.stop
    $skeleton_animation.play animation: :dead, loop: true
    $skeleton_animation.stop
    $skeleton_animation.remove
    clear
    $game_over_music = Music.new('music/game_over_music.mp3')
    $game_over_music.play
    $game_over_music.loop = true
    skeleton_dead = Image.new(
      'img/skeleton_dead.png',
      height: (49*1.75), width: (93*1.75),
      x: 300, y: 280,
    )
    update do
      game_over
    end
  end

  #skeleton wins
  if $skeleton_animation.x == ($end_door.x - 50) && ($fire_animation.x == 1000)#|| $level_cleared
    clear
    $lives = 0
    $skeleton_animation.add
    $skeleton_animation.play animation: :idle, loop: true
    set background: 'navy'
    $level_cleared_text.remove
    $level_cleared_text.add
    $score_counter.add
    $score_counter.x = 300
    $score_counter.y = 400
  end

  #updating skeleton movements
  if $walking_right && $skeleton_animation.x < (Window.width - 150)
    $skeleton_animation.x += $walk_velocity
    background_moving_right = false
  elsif $walking_right && $skeleton_animation.x >= (Window.width - 150) && (($background.x - Window.width) > -$background.width)
    background_moving_right = true
    $level_text.x -= $walk_velocity
    $fire_animation.x -= $walk_velocity
    $end_door.x -= $walk_velocity
  end

  if $walking_left && $skeleton_animation.x > -50
    $skeleton_animation.x -= $walk_velocity
    background_moving_left = false
  elsif $walking_left && $skeleton_animation.x <= -50 && ($background.x <= -3)
    background_moving_left = true
    $level_text.x += $walk_velocity
    $fire_animation.x += $walk_velocity
    $end_door.x += $walk_velocity
  end

  #background movements
  if background_moving_right
    $background.x -= $walk_velocity
  elsif background_moving_left
    $background.x += $walk_velocity
  end

end

#setting window and other initial configurations
set title: 'The End of Day Game', resizable: false, width: 800, height: 600

#calling the game introduction function
game_introduction

#starting the game by calling the initialize game function, playing music, removing introdction screen
if !game_started
  $game_music.play
  on :mouse_down do |event|
    $intro_text1.remove
    $intro_text2.remove
    $intro_text3.remove
    $score_counter.remove
    $game_over_text1.remove
    $skeleton_animation.x = 0
    $skeleton_animation.y = 300
    $level_cleared_text.remove
    initialize_game
    game_started = true
  end
end

#main update loop, calling the update game function
update do
  update_game
end

#showing the window
show