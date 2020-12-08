local composer = require( "composer" )
local scene = composer.newScene()
 
local CW = display.contentWidth
local CH = display.contentHeight
local mainGroup = display.newGroup( )

 
function scene:create( event )
 
    local sceneGroup = self.view
    local fondo = display.newImage( sceneGroup, "portadaSnoopy.png" )
    fondo.x = CW/2; fondo.y = CH/2
    fondo.width = CW
    fondo.height = CH

    local spriteSheet = graphics.newImageSheet( "sprite_portada_Snoopy.png", {
    width = 561/3,
    height = 494/2,
    numFrames=6
    } )

    local sequenceData = {
     name = "normalRun",
        start = 1,
        count = 6,
        time = 500,
        loopCount = 0,
        loopDirection = "forward"

}

    local personaje =  display.newSprite( sceneGroup, spriteSheet, sequenceData )
    personaje:pause()
    personaje:setFrame( 1 )
    personaje:translate( CW/2, CH/1.8 )
    personaje:setSequence("normalRun")
    personaje.xScale=2 
    personaje.yScale=2
     
    --personaje.yScale = -1
    personaje:play()
  

function fondo:touch( e )
    if e.phase == "ended" or e.phase == "cancelled" then

    composer.gotoScene( "pagina1", {
        effect = "slideLeft",
        time = 500
        } )
        end
        return true
    end

    fondo:addEventListener( "touch", fondo )

end
 
function scene:show( event )
    local sceneGroup = self.view
    local phase = event.phase
    if ( phase == "will" ) then
    elseif ( phase == "did" ) then
    end
end
 
function scene:hide( event )
    local sceneGroup = self.view
    local phase = event.phase
    if ( phase == "will" ) then
    elseif ( phase == "did" ) then
    end
end
 
function scene:destroy( event )
    local sceneGroup = self.view
end
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------
 
return scene