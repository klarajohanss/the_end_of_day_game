require 'ruby2d'
set title: "The End of Day Game"

set resizable: true


Image.new('img/background_og.png')

coin = Sprite.new(
  'img/coin_test.png',
  clip_width: 84,
  time: 300,
  loop: true
)
coin.play


show

