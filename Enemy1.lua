local composer = require( "composer" )
local scene = composer.newScene()
local widget = require( "widget" )
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
local resetBtn= display.newImage("restart.png")
resetBtn.x=display.contentCenterX
resetBtn.y=display.contentCenterY
resetBtn:scale(.15,.15)
resetBtn.isVisible=false

local nextBtn= display.newImage("next.png")
nextBtn.x=display.contentCenterX
nextBtn.y=display.contentCenterY
nextBtn:scale(.15,.15)
nextBtn.isVisible=false



-- "scene:create()"
function scene:create( event )

   local sceneGroup = self.view

   -- Initialize the scene here.
   -- Example: add display objects to "sceneGroup", add touch listeners, etc.
   AlexText = display.newText("Satvik: ",
   display.contentCenterX-95, display.contentCenterY-200,
    native.systemFont, 20)
   AlexText:setTextColor(255, 255, 255)

   EnemyText = display.newText("Enemy: ",
   display.contentCenterX+70, display.contentCenterY-200,
    native.systemFont, 20)
   AlexText:setTextColor(255, 255, 255)

   local progressView = widget.newProgressView(
       {

           left = display.contentCenterX-100,
           top = display.contentCenterY-150,
           width = 200,
           isAnimated = true,

       }
   )
   progressView.height=30
   progressView.isVisible=false



local level=display.newText("Level:1", display.contentCenterX-10,display.contentCenterY-200,
native.systemFont,20)
level:setTextColor(255, 255, 255)

   -----------------------------background--------------------------------
   local options =
   {
      frames = {
         { x = 0, y = 0, width = 256, height = 192}, --bg1
         { x = 0, y = 192, width = 256, height = 192}, -- bg2
         { x = 256, y = 192, width = 256, height = 192}, -- bg3

      }
   };
   local sheet = graphics.newImageSheet( "bg.png", options );
   local bg = display.newImage(sheet,1);
   bg.x = display.contentWidth / 2;
   bg.y= display.contentHeight / 2;



  local bubble = {}
  local widget = require('widget')
  choice = 0;
  enemy_choice = 0;
  winstate=0;
alex_score=0;
enemy_score=0;

  ---------- ALEX KIDD ---------------------------------
  local options =
  {
  frames = {
    { x = 1, y = 2, width = 16, height = 25}, --frame 1
    { x = 18, y = 2, width = 16, height = 25}, --frame 2
    { x = 35, y = 2, width = 16, height = 25}, --frame 3
    { x = 52, y = 2, width = 16, height = 25}, --frame 4
    { x = 1, y = 54, width = 16, height = 24}, --ready1
    { x = 19, y = 54, width = 16, height = 24}, --ready2
    { x = 37, y = 54, width = 29, height = 24}, -- rock
    { x = 67, y = 54, width = 33, height = 24}, -- scissor
    { x = 101, y = 54, width = 33, height = 24}, -- paper
    { x = 1, y = 79, width= 32, height= 32}, -- bubblerock
    { x = 35, y = 79, width= 32, height= 32}, -- bubblescissor
    { x = 69, y = 79, width= 32, height= 32}, -- bubblepaper
  }
  };
  local sheet = graphics.newImageSheet( "alex.png", options );

  local seqData = {
   {name = "alex_normal", start=1 , count = 4, time = 800},
   {name = "alex_faster", frames={1,2,3,4}, time = 400},
   {name = "alex_shake", frames={5,6}, time = 500},
   {name = "alex_rock", frames={7}},
   {name = "alex_paper", frames={9}},
   {name = "alex_scissor", frames={8}},

  }
  local alex = display.newSprite(sheet, seqData);
  alex.x = display.contentCenterX-80;
  alex.y = display.contentCenterY+66;
  alex.anchorX = 0;
  alex.anchorY = 1;
  alex:setSequence("alex_shake");
  alex:play();


  local bubbleSeqData = {
   {name = "bubble_rock", frames={10}},
   {name = "bubble_scissor", frames={11}},
   {name = "bubble_paper", frames={12}},
  }

  local bubble = display.newSprite (sheet, bubbleSeqData);
   bubble.x = display.contentCenterX-90;
   bubble.y = display.contentCenterY+26;
   bubble.anchorX = 0;
   bubble.anchorY = 1;
   bubble.xScale = 1.2
   bubble.yScale = 1.2
   bubble:setSequence("bubble_rock");
   --choice = 0;

  ---------- JANKEN ---------------------------------
  local jankenOpt =
  {
   frames = {
     {x= 154, y= 13, width= 39, height= 48 }, -- 1. boss_shake1
     {x= 195, y= 13, width= 39, height= 48 }, -- 2. boss_shake2
     {x= 236, y= 13, width= 32, height= 48 }, -- 3. boss_set
     {x= 305, y= 13, width= 15, height= 48 }, -- 4. boss_rock
     {x= 270, y= 13, width= 16, height= 48 }, -- 5. boss_paper
     {x= 287, y= 13, width= 16, height= 48 }, -- 6. boss_scissor


     {x= 153, y= 62, width= 23, height= 31 }, -- 7. enemy1_shake1
     {x= 178, y= 62, width= 23, height= 31 }, -- 8. enemy1_shake2
     {x= 236, y= 62, width= 15, height= 31 }, -- 9. enemy1_set
     {x= 270, y= 62, width= 16, height= 31 }, -- 10. enemy1_rock
     {x= 287, y= 62, width= 16, height= 31 }, -- 11. enemy1_paper
     {x= 304, y= 62, width= 16, height= 31 }, -- 12. enemy1_scissor


     {x= 153, y= 96, width= 23, height= 31 }, -- 13. enemy2_shake1
     {x= 178, y= 96, width= 23, height= 31 }, -- 14. enemy2_shake2
     {x= 236, y= 96, width= 15, height= 31 }, -- 15. enemy2_set
     {x= 270, y= 96, width= 16, height= 31 }, -- 16. enemy2_rock
     {x= 287, y= 96, width= 16, height= 31 }, -- 17. enemy2_paper
     {x= 304, y= 96, width= 16, height= 31 }, -- 18. enemy2_scissor
   }
  };
  local jankenSheet = graphics.newImageSheet( "enemy.png", jankenOpt );

  -- Create animation sequence janken
  local seqDataJanken = {
   --{name = "boss_flap", frames={7,8}, time = 500},
   {name = "boss_shake", frames={1,2}, time = 500},
   {name = "boss_set", frames={3}, time = 10, loopCount=1},
   {name = "boss_rock", frames={4}, time = 10, loopCount=1},
   {name = "boss_paper", frames={5}, time = 10, loopCount=1},
   {name = "boss_scissor", frames={6}, time = 10, loopCount=1},

   --{name = "enemy1_flap", frames={7,8}, time = 500},
   {name = "enemy1_shake", frames={7,8}, time = 500},
   {name = "enemy1_set", frames={9}, time = 10, loopCount=1},
   {name = "enemy1_rock", frames={10}, time = 10, loopCount=1},
   {name = "enemy1_scissor", frames={11}, time = 10, loopCount=1},
   {name = "enemy1_paper", frames={12}, time = 10, loopCount=1},

   --{name = "enemy2_flap", frames={7,8}, time = 500},
   {name = "enemy2_shake", frames={13,14}, time = 500},
   {name = "enemy2_set", frames={15}, time = 10, loopCount=1},
   {name = "enemy2_rock", frames={16}, time = 10, loopCount=1},
   {name = "enemy2_scissor", frames={17}, time = 10, loopCount=1},
   {name = "enemy2_paper", frames={18}, time = 10, loopCount=1},
  }
  local janken = display.newSprite (jankenSheet, seqDataJanken);
  janken.x = display.contentCenterX+78;
  janken.y = display.contentCenterY+66;
  janken.anchorX = 1;
  janken.anchorY = 1;
  janken:setSequence("enemy1_shake");

  local function chooseHandler(event)
    if (choice==0) then
      choice = 1;
      bubble:setSequence("bubble_paper");
      bubble:play();
      local bubsound = audio.loadSound("Bubble.mp3")
      audio.play(bubsound);
      return
    end
    if (choice == 1) then
      choice = 2;
      bubble:setSequence("bubble_scissor");
      bubble:play();
      local bubsound = audio.loadSound("Bubble.mp3")
      audio.play(bubsound);
      return
    end
    if (choice == 2) then
      choice = 0;
      bubble:setSequence("bubble_rock");
      bubble:play();
      local bubsound = audio.loadSound("Bubble.mp3")
      audio.play(bubsound);
    end

  end

  local function checkWin()
    if (choice == enemy_choice) then
      return 0;
    end
    if (choice == ((enemy_choice+1)%3)) then
      return 1;
    end
    if (((choice+1)%3) == enemy_choice) then
      return 2;
    end
  end

  local function enemyChoice()
    return math.random(0,2);
  end

  local function alexShoot()
    if (choice%3==0) then
      alex:setSequence("alex_rock");
    end
    if (choice%3==1) then
      alex:setSequence("alex_paper")
    end
    if (choice%3==2) then
      alex:setSequence("alex_scissor")
    end
    alex:play();
  end

local function as()   --function for updating alex's score
  alex_score = alex_score + 1;
  scoreText.text=alex_score
end

local function es()     --function for updating enemy score
  enemy_score = enemy_score + 1;
  enemscoreText.text=enemy_score
end

local function shoot ()
  enemy_choice = enemyChoice()
 janken:setSequence("enemy1_set");
 hand = display.newImage (jankenSheet, 4+enemy_choice, -- boss_rock
 display.contentCenterX+55,
 display.contentCenterY+49);
  alexShoot();
  local shootsound = audio.loadSound("result.wav")
  audio.play(shootsound);
  local winstate = checkWin();
  if (winstate == 1) then
    as();
  end
  if (winstate == 2) then
    es();
  end
  print("Alex Score: " .. alex_score);
  print("Enemy Score: " .. enemy_score);

  if (enemy_score~=2 and alex_score~=2) then
    local t5 = timer.performWithDelay( delay, play, 1)

  else
    if(alex_score<enemy_score) then
      print("Enemy wins")
      local enimsound = audio.loadSound("lost.mp3")
      audio.play(enimsound)
      resetBtn.isVisible=true
      local function button4(event)
        composer.removeScene( "Enemy1", options )
        composer.gotoScene( "Enemy1" , options )
        resetBtn.isVisible=false

      end
      resetBtn:addEventListener("tap", button4 )


    elseif(alex_score>enemy_score) then
     print("Alex wins")
     local alexsound = audio.loadSound("win.mp3")
     audio.play(alexsound)
     nextBtn.isVisible=true
     local function button3(event)
      composer.removeScene( "Enemy1", options )
      composer.gotoScene( "Enemy2" , options )
      nextBtn.isVisible=false

     end
     nextBtn:addEventListener("tap", button3 )
    end
    enemy_score = 0;
    alex_score = 0;

  end
end

  scoreText = display.newText(alex_score,
  display.contentCenterX-60, display.contentCenterY-200,
   native.systemFont, 20)
  scoreText:setTextColor(255, 255, 255)

   enemscoreText = display.newText(enemy_score,
   display.contentCenterX+110, display.contentCenterY-200,
    native.systemFont, 20)
  enemscoreText:setTextColor(255, 255, 255)




  function play()
     alex:setSequence ("alex_shake");
     alex:play();

     janken:setSequence("enemy1_shake");
     janken:play();
     display.remove( hand )
     bubble:addEventListener("tap", chooseHandler);
     local t = timer.performWithDelay (delay, shoot, 1);

     progressView:setProgress(0)
     progressView.isVisible=true

     local inc = 0
     local function progressIncrement()
        inc = inc +.20
        progressView:setProgress( inc )
     end
     timer.performWithDelay( 500, progressIncrement, 6 )



  end


  play();
sceneGroup:insert(bg)
sceneGroup:insert(alex)
sceneGroup:insert(janken)
sceneGroup:insert(bubble)
sceneGroup:insert(scoreText)
sceneGroup:insert(enemscoreText)
sceneGroup:insert(level)
sceneGroup:insert(AlexText)
sceneGroup:insert(EnemyText)
sceneGroup:insert(progressView)
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
      -- Create animation sequence for animation

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
