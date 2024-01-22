require 'ruby2d'

# Set up the window
set width: 800, height: 600

# Create a sprite with Idle image
character_sprite = Sprite.new(
  'img/Idle.png',   # Path to Idle image
  x: 0,             # Initial x-coordinate
  y: 300,           # Initial y-coordinate
  width: 128        # Clipping width
)

# Key press event handler
on :key_down do |event|
  if event.key == 'd'
    # Change sprite to Walk image when 'd' key is pressed
    character_sprite.path = 'img/Walk.png'  # Path to Walk image
  end
end

# Key release event handler
on :key_up do |event|
  if event.key == 'd'
    # Change sprite back to Idle image when 'd' key is released
    character_sprite.path = 'img/Idle.png'  # Path to Idle image
  end
end

# Show the window
show
