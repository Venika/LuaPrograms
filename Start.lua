local composer = require( "composer" )
local scene = composer.newScene()

local options ={
  effect = "fade",
  time=200
}
---------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE
-- unless "composer.removeScene()" is called.
---------------------------------------------------------------------------------

-- local forward references should go here

---------------------------------------------------------------------------------

-- "scene:create()"
function scene:create( event )

   local sceneGroup = self.view

   -- Initialize the scene here.
   -- Example: add display objects to "sceneGroup", add touch listeners, etc.
   -- Create the widget

   ----------------------------background--------------------------------
   local bg=display.newImage("tittle.png")
   bg.x= display.contentWidth/2
   bg.y= display.contentHeight/2
   bg:scale(.50,.60)
   local myText = display.newText("Rock-Paper-Scissor", display.contentCenterX, display.contentCenterY-200, native.systemFont, 25)
         myText:setFillColor(1,1,0)

   local myText1 = display.newText("Venika Gaur", display.contentCenterX, display.contentCenterY-150, native.systemFont, 25)
               myText:setFillColor(1,1,0)



   local startBtn= display.newImage("Startbutton.png")
   startBtn.x=display.contentCenterX-70
   startBtn.y=display.contentCenterY+150
   startBtn:scale(.15,.15)



   local function button1(event)
    -- composer.removeScene( "Start" )
    audio.pause(startsound);
     composer.gotoScene( "Enemy1" , options )
   end
   startBtn:addEventListener("tap", button1 )

   local setBtn= display.newImage("Setbutton.png")
   setBtn.x=display.contentCenterX+62
   setBtn.y=display.contentCenterY+150
   setBtn:scale(.14,.13)

   local function button2(event)

     composer.gotoScene( "Settings" , options )
   end
   setBtn:addEventListener("tap", button2 )



sceneGroup:insert(bg)
sceneGroup:insert(myText1)
sceneGroup:insert(myText)
sceneGroup:insert(startBtn)
sceneGroup:insert(setBtn)

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
      local startsound = audio.loadSound("Startmusic.mp3")
                audio.play(startsound);

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
