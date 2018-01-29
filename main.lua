local composer = require("composer")
display.setStatusBar( display.HiddenStatusBar );

local options ={
  effect = "fade",
  time=200
}

delay = 3000;

composer.gotoScene( "Start" , options )
