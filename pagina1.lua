local composer = require( "composer" )
local scene = composer.newScene()
local CW = display.contentWidth
local CH = display.contentHeight
local page1
local backgroup, background
local actualcasilla = 0
local numero=0
local canMove = true
local transformadas = {
    
    {x = 0,y = 30, xScale = 0.6, yScale = 1},
    {x = -1200,y = 30, xScale = 0.8, yScale = 1},
    {x = 0,y = -700, xScale = 0.6, yScale = 1},
    {x = -1200,y = -700, xScale = 0.8, yScale = 1},
    {x = 0,y = -1430, xScale = 0.6, yScale = 1},
    {x = -1200,y = -1430, xScale = 0.8, yScale = 1},
  
}

local ss1 = graphics.newImageSheet( "animacion1.png", {
    width = 1280,
    height = 720,
    numFrames=48
    } )



local sequenceData ={
    {
        name=1,
        frames = {41,42,43,44,45,46,47,48},
        time=700,
        sheet = ss1,
        loopCount = 1
    },
    {
        name=2,
        frames = {33,34,35,36,37,38,39,40},
        time=700,
        sheet = ss1,
        loopCount = 1
    },
     {
        name=3,
        frames = {25,26,27,28,29,30,31,32},
        time=700,
        sheet = ss1,
        loopCount = 1
    },
     {
        name=4,
        frames = {17,18,19,20,21,22,23,24},
        time=700,
        sheet = ss1,
        loopCount = 1
    },
     {
        name=5,
        frames = {9,10,11,12,13,14,15,16},
        time=700,
        sheet = ss1,
        loopCount = 1
    },
{        name=6,
        frames = {1,2,3,4,5,6,7,8},
        time=700,
        sheet = ss1,
        loopCount = 1
    },{
          name=7,
        frames = {},
        time=200,
        sheet = ss1,
        loopCount = 1
    }



}



function changeMoveValue( ... )
    canMove = true
end

function scene:create( event )
    local sceneGroup = self.view
    backgroup = display.newGroup( )
    sceneGroup:insert( backgroup)
    background = display.newRect( backgroup, CW/2, CH/2, CW, CH )
    background:setFillColor(0)
    page1 = display.newImage( sceneGroup, "page1.png" )
    page1.anchorX = 0; page1.anchorY = 0
    page1.xScale=0.31
    page1.yScale=0.475

 



end 


function scene:show( event )
    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "did" ) then
        function siguiente( e )
            if canMove and transformadas[actualcasilla+1] ~= nil then   
                canMove = false
                actualcasilla = actualcasilla + 1 
                  numero=numero+1
                transition.to( page1, { xScale = transformadas[actualcasilla].xScale, 
                    yScale = transformadas[actualcasilla].yScale, 
                    x = transformadas[actualcasilla].x,
                    y = transformadas[actualcasilla].y,
                    time = 500, 
                    onComplete = changeMoveValue } )  


                
                
                local function swapSheet()
                    local p1 =  display.newSprite( sceneGroup, ss1, sequenceData )
                   p1:pause()
                   p1:setFrame( 1 )
                p1.xScale=0.63
                p1.yScale=1
                p1:translate( 400, 380 )
                p1:setSequence(numero)
                p1:play() 
                    end
                    timer.performWithDelay( 500, swapSheet )
            else
                composer.gotoScene( "pagina2", {
            effect = "slideLeft",
            time = 500
            } )

        

                    

            end
            return true
        end

        function anterior( e )
            if canMove and transformadas[actualcasilla-1] ~= nil then
                canMove = false
                actualcasilla = actualcasilla - 1
                numero=numero-1
                transition.to( page1, { xScale = transformadas[actualcasilla].xScale, 
                    yScale = transformadas[actualcasilla].yScale, 
                    x = transformadas[actualcasilla].x,
                    y = transformadas[actualcasilla].y,
                    time = 500, 
                    onComplete = changeMoveValue } )
                local function swapSheet()
                    local p1 =  display.newSprite( sceneGroup, ss1, sequenceData )
                   p1:pause()
                p1:setFrame( 1 )

                p1.xScale=0.63
                p1.yScale=1
                p1:translate( 400, 380 )
                p1:setSequence(numero)
                p1:play() 
              
                    end
                    timer.performWithDelay( 200, swapSheet )
                  else
                composer.gotoScene( "pagina_portada", {
            effect = "slideLeft",
            time = 500
            } )

            end


            return true
        end
        function moveTo(e )
            if e.phase == "ended" or e.phase == "cancelled" then
            if e.x < CW/2 then
                anterior(e)
            else 
                siguiente(e)
            end
        end
        return true
    end
    page1:addEventListener( "touch", moveTo )

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
    botonVolver:removeSelf( )
    local sceneGroup = self.view
end 
    -- -----------------------------------------------------------------------------------
    scene:addEventListener( "create", scene )
    scene:addEventListener( "show", scene )
    scene:addEventListener( "hide", scene )
    scene:addEventListener( "destroy", scene )
    -- -----------------------------------------------------------------------------------
    return scene