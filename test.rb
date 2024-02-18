require 'ruby2d'


# Define functions for different aspects of your game

def initialize_game
  # Initialize game settings, sprites, variables, etc.

  #variables for initial game settings
  score = 0
  lives = 5
  level = 1
  walk_velocity = 2
  walking_right = false
  walking_left = false
  facing_left = false

  #skeleton sprite
  skeleton_animation = Sprite.new(
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
  fire_animation = Sprite.new(
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





end

def update_game
  # Update game state, handle input, move sprites, check collisions, etc.
end

def draw_game
  # Draw sprites, UI elements, text, etc.
end

# Set up the window and other initial configurations
set title: 'The End of Day Game', background: 'navy', resizable: false, width: 800, height: 600


# Call the initialization function to set up the game
initialize_game

# Main update loop
update do
  # Call the update function to handle game logic
  update_game

  # Call the draw function to render the game scene
  draw_game
end

# Start the game loop
show












#game not started
game_started = false

#fire sprite variables
fire_default = true


#intro screen
intro_text1 = Text.new(
  'The End of Day',
  x: 180, y: 115,
  font: 'img/DigitalDisco.ttf',
  #style: 'bold',
  size: 65,
  color: 'white',
  #rotate: 90,
  z: 5
)
intro_text2 = Text.new(
  'by Klara Johansson',
  x: 250, y: 185,
  font: 'img/DigitalDisco.ttf',
  #style: 'bold',
  size: 20,
  color: 'white',
  #rotate: 90,
  z: 5
)
intro_text3 = Text.new(
  'press any key to start',
  x: 350, y: 315,
  font: 'img/DigitalDisco.ttf',
  #style: 'bold',
  size: 25,
  color: 'white',
  #rotate: 90,
  z: 5
)

#lives
heart1 = Image.new(
  'img/heart.png',
  x: 735, y:540, z: 5,
  width: 46, height: 43,
)
heart2 = Image.new(
  'img/heart.png',
  x: 689, y:540, z: 5,
  width: 46, height: 43, 
)
heart3 = Image.new(
  'img/heart.png',
  x: 643, y:540, z: 5,
  width: 46, height: 43, 
)
heart4 = Image.new(
  'img/heart.png',
  x: 597, y:540, z: 5,
  width: 46, height: 43, 
)
heart5 = Image.new(
  'img/heart.png',
  x: 551, y:540, z: 5,
  width: 46, height: 43, 
)

#hearts are not shown
heart1.remove
heart2.remove
heart3.remove
heart4.remove
heart5.remove

fire_start = true


#main update loop
update do
  if !game_started
    #skeleton initially idles
    skeleton_animation.play animation: :idle, loop: true
    on :key_down do |event|
      intro_text1.remove
      intro_text2.remove
      intro_text3.remove
      game_started = true
    end
  else
    #fire_animation.play animation: :explosion, loop: true

    if fire_start
      fire_animation.add
      #fire_animation.play animation: :explosion, loop: true
      fire_start = false
    end




    
    background = Image.new(
      'img/background_real.png',
      height: 600,
    )

    level = Text.new(
      "Level #{level}",
      x: 40, y:400,
      font:'img/DigitalDisco.ttf',
      size: 30,
      color: 'blue',
      z: 5
    )

    #tracking score
    score_counter = Text.new(
      "score: #{score}",
      x: 15, y: 550,
      font:'img/DigitalDisco.ttf',
      size: 25,
      color: 'white',
      z: 5
    )

    #printing skeleton coordinates
    on :key_down do |event|
      case event.key
        when 'l'
          p skeleton_animation.x
          #p fire_animation.x 
          p (skeleton_animation.x - fire_animation.x).abs
      end
    end



    #tracking lives
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
    elsif lives == 3
      heart1.add
      heart2.add
      heart3.add
      heart4.remove
      heart5.remove
    elsif lives == 2
      heart1.add
      heart2.add
      heart3.remove
      heart4.remove
      heart5.remove
    elsif lives == 1
      heart1.add
      heart2.remove
      heart3.remove
      heart4.remove
      heart5.remove
    else 
      heart1.remove
      heart2.remove
      heart3.remove
      heart4.remove
      heart5.remove
    end

    on :key_up do |event|
      walking_left = false
      walking_right = false
      if facing_left
        skeleton_animation.play animation: :idle, loop: true, flip: :horizontal
      else
        skeleton_animation.play animation: :idle, loop: true
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
        when 'e'
          fire_animation.play animation: :explosion, loop: true
      end
    end

    p skeleton_animation.x
    update do
      if 1>0
        p "in this stiupoid if"
        fire_animation.play animation: :explosion, loop: true
      end
      if ((skeleton_animation.x - fire_animation.x).abs < 190)
        p "in the if"
        fire_animation.play animation: :explosion, loop: true
      else
        fire_animation.play animation: :idle, loop: false
      end
      p "iun the update do first"
    
      #fire sprite explode when close to skeleton
      

    end

    update do
      "in the seconmd update do"

      if walking_right && skeleton_animation.x < (Window.width - 150)#skeleton_animation.width)
        p "iun the wlaking right if"
        # Move the character horizontally according to its walking velocity
        skeleton_animation.x += walk_velocity
      elsif walking_right && skeleton_animation.x >= (Window.width - 150) && ((background.x - Window.width) > -background.width)
        background.x -= walk_velocity
        level.x -= walk_velocity
      end
      if walking_left && skeleton_animation.x > -50
        # Move the character horizontally according to its walking velocity
        skeleton_animation.x -= walk_velocity
      elsif walking_left && skeleton_animation.x <= -50 && (background.x <= -3)
        background.x += walk_velocity
        level.x += walk_velocity
      end
    end

    update do
      if 1>0
        p "stupid testoing"
      end

    end



    

  end

end







show