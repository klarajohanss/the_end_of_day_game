require 'ruby2d'
set title: 'The End of Day Game', background: 'navy'
set resizable: false
set width: 800
set height: 600

#tracking facing and walking 
walk_velocity = 2
walking_right = false
walking_left = false
facing_left = false

#game not started
game_started = false

#sprites not existing

#skeleton sprite
skeleton_animation = Sprite.new(
  'img/skeleton_all_animations.png',
  clip_width: 128,
  time: 200,
  width: 192,
  height: 192,
  x:0, y:300, z:10,
  animations: {
    idle: 1..6,
    walk: 7..14,
    attack: 15..18,
    jump: 19..28,
    hurt: 29..31,
    dead: 32..34,
  }
)

#skeleton initially idles
skeleton_animation.play animation: :idle, loop: true

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


#main update loop
update do
  if !game_started
    on :key_down do |event|
      intro_text1.remove
      intro_text2.remove
      intro_text3.remove
      game_started = true
    end
  elsif game_started
    
    background = Image.new(
      'img/background_real.png',
      height: 600,
     #y: ,
    )


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
      end
    end

    update do
      if walking_right && skeleton_animation.x < (Window.width - 150)#skeleton_animation.width)
        # Move the character horizontally according to its walking velocity
        skeleton_animation.x += walk_velocity
      elsif walking_right && skeleton_animation.x >= (Window.width - 150) && ((background.x - Window.width) > -background.width)
        background.x -= walk_velocity
      end
      if walking_left && skeleton_animation.x > -50
        # Move the character horizontally according to its walking velocity
        skeleton_animation.x -= walk_velocity
      elsif walking_left && skeleton_animation.x <= -50 && (background.x <= -3)
        background.x += walk_velocity
      end
    end
    
  end

end









show