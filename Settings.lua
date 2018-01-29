local composer = require( "composer" )
local scene = composer.newScene()
local widget = require( "widget" )
---------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE
-- unless "composer.removeScene()" is called.
---------------------------------------------------------------------------------

-- local forward references should go here

---------------------------------------------------------------------------------
local options ={
  effect = "fade",
  time=200
}


-- "scene:create()"
function scene:create( event )

   local sceneGroup = self.view

   -- Initialize the scene here.
   -- Example: add display objects to "sceneGroup", add touch listeners, etc.
   local bg1=display.newImage("tittle.png")
   bg1.x= display.contentWidth/2
   bg1.y= display.contentHeight/2
   bg1:scale(.50,.60)
   local myText3 = display.newText("Rock-Paper-Scissor", display.contentCenterX, display.contentCenterY-200, native.systemFont, 25)
         myText3:setFillColor(1,1,0)

--Slider listener
local function sliderListener( event )

  if(event.phase=="ended") then
  print( "Slider at " .. event.value.. "%" )
  delay = 100*event.value
  print( "Delay is at " .. delay .. " ms")

end
end
--Create the widget
local slider = widget.newSlider({top = 235,left = 20,width = display.contentWidth- 40,value = 30,  --Start slider at 10% (optional)
listener = sliderListener})

local myText = display.newText("Adjust the slider \nto change the delay", display.contentCenterX,
      display.contentCenterY-150, native.systemFont, 20)
      myText:setFillColor(1,1,1)

local myText1 = display.newText("0", 20, display.contentCenterY+145, native.systemFont, 25)
            myText1:setFillColor(1,1,0)

local myText2 = display.newText("100", 220, display.contentCenterY+145, native.systemFont, 25)
            myText2:setFillColor(1,1,0)



local goBtn= display.newImage("Goback.png")
      goBtn.x=display.contentCenterX
      goBtn.y=display.contentCenterY+200
      goBtn:scale(.15,.15)

local function buttons(event)
      --composer.removeScene( "Settings" )
      composer.gotoScene( "Start" , options )
end
goBtn:addEventListener("tap", buttons )

sceneGroup:insert(slider)
sceneGroup:insert(bg1)
sceneGroup:insert(myText)
sceneGroup:insert(myText1)
sceneGroup:insert(myText2)
sceneGroup:insert(myText3)
sceneGroup:insert(goBtn)

end




-- "scene:show()"
function scene:show( event )

   local sceneGroup = self.view
   local phase = event.phase

   if ( phase == "will" ) then
      -- Called when the scene is still off screen (but is about to come on screen).
   elseif ( phase == "did" ) then
      -- Called when the scene is now on screen.
      -- Insert code here to make the scene come alive.
      -- Example: start timers, begin animation, play audio, etc.
   end
end

-- "scene:hide()"
function scene:hide( event )

   local sceneGroup = self.view
   local phase = event.phase

   if ( phase == "will" ) then
      -- Called when the scene is on screen (but is about to go off screen).
      -- Insert code here to "pause" the scene.
      -- Example: stop timers, stop animation, stop audio, etc.
   elseif ( phase == "did" ) then
      -- Called immediately after scene goes off screen.
   end
end

-- "scene:destroy()"
function scene:destroy( event )

   local sceneGroup = self.view

   -- Called prior to the removal of scene's view ("sceneGroup").
   -- Insert code here to clean up the scene.
   -- Example: remove display objects, save state, etc.
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

---------------------------------------------------------------------------------

return scene
