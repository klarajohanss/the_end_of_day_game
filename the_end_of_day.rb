require 'ruby2d'
set title: 'The End of Day Game', background: 'navy'
set resizable: true
#Image.new('img/background_og.png')

skeleton_idle = Sprite.new(
  'img/Idle.png',
  clip_width: 128,
  time: 300,
  x:0, y:300,
  loop: true
)


skeleton_walk = Sprite.new(
  'img/Walk.png',
  clip_width: 128,
  time: 300,
  x:0, y:300,
  loop: true
)

skeleton_idle.play

on :key_down do |event|
  if event.key == 'd'
    # Hide Idle sprite and show Walk sprite when 'd' key is pressed
    skeleton_idle.remove
    skeleton_walk.play
  end
end

# Key release event handler
on :key_up do |event|
  if event.key == 'd'
    # Hide Walk sprite and show Idle sprite when 'd' key is released
    skeleton_walk.remove
    skeleton_idle.play
  end
end


show

