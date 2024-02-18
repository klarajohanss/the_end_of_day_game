require 'ruby2d'

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


#variables for initial game settings
$score = 0
$lives = 0
$level = 1
$walk_velocity = 2
$walking_right = false
$walking_left = false
$facing_left = false
# Define variables to track the direction of skeleton movement
$skeleton_movement_direction = nil

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

#score counter
$score_counter = Text.new(
  "score: #{$score}",
  x: 15, y: 550,
  font:'img/DigitalDisco.ttf',
  size: 25,
  color: 'white',
  z: 5
)
$score_counter.remove

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
  'press any key to start',
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

  set background: 'navy'

  $intro_text1.add
  $intro_text2.add
  $intro_text3.add

  $skeleton_animation.add
  $skeleton_animation.play animation: :idle, loop: true

end

def initialize_game
  # Initialize game settings, sprites, variables, etc.

  $lives = 5

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
  if $lives == 5
    $heart1.add
    $heart2.add
    $heart3.add
    $heart4.add
    $heart5.add
  elsif $lives == 4
    $heart1.add
    $heart2.add
    $heart3.add
    $heart4.add
    $heart5.remove
  elsif $lives == 3
    $heart1.add
    $heart2.add
    $heart3.add
    $heart4.remove
    $heart5.remove
  elsif $lives == 2
    $heart1.add
    $heart2.add
    $heart3.remove
    $heart4.remove
    $heart5.remove
  elsif $lives == 1
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
      when 'a','d','p'
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
      when 'w' #remove jumping??
        if $facing_left
          $skeleton_animation.play animation: :jump, loop: false, flip: :horizontal
        else
          $skeleton_animation.play animation: :jump, loop: false
        end
        $skeleton_animation.y -= 20
      when 'p'
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
    $fire_animation.play animation: :idle, loop: false
  end

  # Define variables to track the direction of skeleton movement
$skeleton_movement_direction = nil

# Update the skeleton movement direction based on the direction the skeleton is moving
if $walking_right
  $skeleton_movement_direction = :right
elsif $walking_left
  $skeleton_movement_direction = :left
end

# Move the skeleton based on the skeleton movement direction
case $skeleton_movement_direction
when :right
  if $skeleton_animation.x < (Window.width - 150)
    # Move the skeleton to the right
    $skeleton_animation.x += $walk_velocity
  else
    # Move the background to the left
    $background.x -= $walk_velocity if $background.x > -($background.width - Window.width)
    $level_text.x -= $walk_velocity
    $fire_animation.x -= $walk_velocity
  end
when :left
  if $skeleton_animation.x > -50
    # Move the skeleton to the left
    $skeleton_animation.x -= $walk_velocity
  else
    # Move the background to the right
    $background.x += $walk_velocity if $background.x < 0
    $level_text.x += $walk_velocity
    $fire_animation.x += $walk_velocity
  end
end




end

#def draw_game
  # Draw sprites, UI elements, text, etc.
#end

# Set up the window and other initial configurations
set title: 'The End of Day Game', resizable: false, width: 800, height: 600


# Call the initialization function to set up the game
game_introduction
on :key_down do |event|
  $intro_text1.remove
  $intro_text2.remove
  $intro_text3.remove
  initialize_game
end


# Main update loop
update do
  # Call the update function to handle game logic
  update_game

  # Call the draw function to render the game scene
  #draw_game
end

# Start the game loop
show




new_delay=""
delay="srngsrutnbgserougnesiurghseiuruhgsieug3465978263tfubnsebgw34nyt894w2n7tyf89n230t09456t2345vn6n350tyc7536y90764b5djm45789tycn7se89ny0vvt94w"
i=0
while i<delay.length
  #p "in the whiol"
  new_delay+=delay[i]
  i+=1
end