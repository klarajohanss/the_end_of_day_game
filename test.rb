require 'ruby2d'
p "program starting"

#defining global variables

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
p "here"


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


#score counter updates
$score_counter = Text.new(
  "score: #{$score}",
  x: 15, y: 550,
  font:'img/DigitalDisco.ttf',
  size: 25,
  color: 'white',
  z: 5
)

#level
$level_text = Text.new(
  "Level #{$level}",
  x: 40, y:400,
  font:'img/DigitalDisco.ttf',
  size: 30,
  color: 'blue',
  z: 5
)
$level_text.remove

#intro texts
$intro_text1 = Text.new(
  'The End of Day',
  x: 180, y: 115,
  font: 'img/DigitalDisco.ttf',
  #style: 'bold',
  size: 65,
  color: 'white',
  #rotate: 90,
  z: 5
)
$intro_text2 = Text.new(
  'by Klara Johansson',
  x: 250, y: 185,
  font: 'img/DigitalDisco.ttf',
  #style: 'bold',
  size: 20,
  color: 'white',
  #rotate: 90,
  z: 5
)
$intro_text3 = Text.new(
  'click to continue',
  x: 350, y: 315,
  font: 'img/DigitalDisco.ttf',
  #style: 'bold',
  size: 25,
  color: 'white',
  #rotate: 90,
  z: 5
)
$intro_text1.remove
$intro_text2.remove
$intro_text3.remove

# Define functions for different aspects of your game

def game_introduction

  p "gamwe introducinm???"
  set background: 'navy'

  $intro_text1.add
  $intro_text2.add
  $intro_text3.add

  $skeleton_animation.add
  $skeleton_animation.play animation: :idle, loop: true

end

def initialize_game
  # Initialize game settings, sprites, variables, etc.
  p "ititilize??"

  $lives = 500

  $background = Image.new(
    'img/background_real.png',
    height: 600, 
  )
  
  #add sprites and text
  $skeleton_animation.add
  $fire_animation.add
  $score_counter.add
  $level_text.add

  $skeleton_animation.play animation: :idle, loop: true
  $fire_animation.play animation: :idle, loop: true

end

#def movements
#end

def update_game
  # Update game state, handle input, move sprites, check collisions, etc.

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

  #skeleton default mode
  on :key_up do |event|
    case event.key
      when 'a','d'
        #p "225"
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
        #p "240"
        $skeleton_animation.play animation: :walk, loop: true, flip: :horizontal 
        $walking_left = true
        $facing_left = true
      when 'd'
        #p "245"
        $skeleton_animation.play animation: :walk, loop: true
        $walking_right = true
        $facing_left = false
      when 'w' #remove jumping??
        if $facing_left
          $skeleton_animation.play animation: :jump, loop: false, flip: :horizontal
        else
          $skeleton_animation.play animation: :jump, loop: false
        end
        $skeleton_animation.y -= 20
      when 'p'
        $attacking = true
        if $facing_left
          $skeleton_animation.play animation: :attack, loop: false, flip: :horizontal
        else
          $skeleton_animation.play animation: :attack, loop: false
        end
      when 'h' #remove hurt when key pressed, add other condition
        $skeleton_animation.play animation: :hurt, loop: false
      when 'j'#same as hurt
        $skeleton_animation.play animation: :dead, loop: nil
      when 'e' #for testing
        $fire_animation.play animation: :explosion, loop: true
    end
  end

  #fire exploding when close to skeleton
  if (($skeleton_animation.x - $fire_animation.x).abs < 190)
    #p "in the if"
    $fire_animation.play animation: :explosion, loop: true
  else
    $fire_animation.play animation: :idle, loop: true
  end

  #skeleton takes damage when too close to fire
  if (($skeleton_animation.x - $fire_animation.x).abs < 50)

    p "skeleton hurt"
    $lives-=2
    i=0
  end

  #fire takes damage 
  if ((($skeleton_animation.x - $fire_animation.x).abs < 100) && $attacking)
    p "fire hurt"
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
      font:'img/DigitalDisco.ttf',
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

  #skeleton movements
  if $walking_right && $skeleton_animation.x < (Window.width - 150)#skeleton_animation.width)
    # Move the character horizontally according to its walking velocity
    #p "283"
    $skeleton_animation.x += $walk_velocity
    background_moving_right = false
  elsif $walking_right && $skeleton_animation.x >= (Window.width - 150) && (($background.x - Window.width) > -$background.width)
    #p "286"
    background_moving_right = true
    $level_text.x -= $walk_velocity
    $fire_animation.x -= $walk_velocity
  end

  if $walking_left && $skeleton_animation.x > -50
    #p "293"
    # Move the character horizontally according to its walking velocity
    $skeleton_animation.x -= $walk_velocity
    background_moving_left = false
  elsif $walking_left && $skeleton_animation.x <= -50 && ($background.x <= -3)
    #p "298"
    background_moving_left = true
    $level_text.x += $walk_velocity
    $fire_animation.x += $walk_velocity
  end

  #background movements
  if background_moving_right
    #p "306"
    $background.x -= $walk_velocity
  elsif background_moving_left
    #p "309"
    $background.x += $walk_velocity
  end


end

#def draw_game
  # Draw sprites, UI elements, text, etc.
#end

# Set up the window and other initial configurations
set title: 'The End of Day Game', resizable: false, width: 800, height: 600
game_started = false


# Call the initialization function to set up the game
game_introduction
if !game_started
  p "inly once"
  on :mouse_down do |event|
    p "whateve"
    $intro_text1.remove
    $intro_text2.remove
    $intro_text3.remove
    initialize_game
    game_started = true
  end
  
end


# Main update loop
update do
  #p "in the main update do"
  # Call the update function to handle game logic
  update_game

  # Call the draw function to render the game scene
  #draw_game
end

# Start the game loop
show