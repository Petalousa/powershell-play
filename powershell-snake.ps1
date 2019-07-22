#key definitions
$keyD1 = "DownArrow"
$keyU1 = "UpArrow"
$keyL1 = "LeftArrow"
$keyR1 = "RightArrow"
$keyU2 = "W"
$keyL2 = "A"
$keyD2 = "S"
$keyR2 = "D"

#takes a string and draws it at x, y
#returns cursor to original position
function drawData([string]$str, [int]$x, [int]$y)
{
    $oldY = [console]::cursorTop
    [console]::setcursorposition($x, $y)
    Write-Host $str -NoNewLine
    [console]::setcursorposition(0, $oldY)
}

#called once at game start
#draws a border for the game(default size 64x36)
function drawBorder()
{
    $width = 64
    $height = 36
    $wall_char = '#'

    #set cursor to bottom
    cls
    [console]::setcursorposition(0, $height + 1)
    
    #print walls
    $h_wall = $wall_char * $width
    drawData $h_wall 1 0
    drawData $h_wall 1 $height
    for($i = 0; $i -le $height; $i++)
    {
        drawData $wall_char 0 $i
        drawData $wall_char ($width) $i
    }
}

#main game function
#call to play snake
function main
{
    $width = 64
    $height = 36
    
    #snake with a tail of size 10
    $snake = @{'x'=@(40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40); 
                'y'=@(20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20); 'direction' = 'r'}
    $pelletsX = New-Object System.Collections.ArrayList
    $pelletsY = New-Object System.Collections.ArrayList
    
    $alive = $true
    drawBorder
    
    #main loop
    while($alive)
    {
        $startTime = (Get-Date).ToFileTime()
        
        #get key input without waiting for key
        if([console]::KeyAvailable)
        {
            $keyIn = [console]::ReadKey("noecho").Key
            if($keyIn -eq $keyU1 -or $keyIn -eq $keyU2){
                if($snake['direction'] -ne 'd'){ $snake['direction'] = 'u' }
            }elseif($keyIn -eq $keyD1 -or $keyIn -eq $keyD2){
                if($snake['direction'] -ne 'u'){ $snake['direction'] = 'd' }
            }elseif($keyIn -eq $keyL1 -or $keyIn -eq $keyL2){
                if($snake['direction'] -ne 'r'){ $snake['direction'] = 'l' }
            }elseif($keyIn -eq $keyR1 -or $keyIn -eq $keyR2){
                if($snake['direction'] -ne 'l'){ $snake['direction'] = 'r' }
            }
        }
        
        #erase location of last tail segment
        $snakeSize = $snake['x'].count
        drawData ' ' $snake['x'][$snakeSize - 1] $snake['y'][$snakeSize - 1]
        
        #update tail positions and draw tail segments
        for ($i = $snakeSize - 1; $i -gt 0; $i--)
        {        
            $snake['x'][$i] = $snake['x'][$i - 1]
            $snake['y'][$i] = $snake['y'][$i - 1]
            drawData '¤' $snake['x'][$i] $snake['y'][$i]
        }
        
        #move the head
        if($snake['direction'] -eq 'u'){
            $snake['y'][0] -= 1
        }
        if($snake['direction'] -eq 'd'){
            $snake['y'][0] += 1
        }
        if($snake['direction'] -eq 'l'){
            $snake['x'][0] -= 1
        }
        if($snake['direction'] -eq 'r'){
            $snake['x'][0] += 1
        }
        
        #draw snake head
        drawData '☺' $snake['x'][0] $snake['y'][0]
        
        #check if snake left border
        if(($snake['x'][0] -le 0) -or ($snake['y'][0] -le 0) -or ($snake['x'][0] -gt 63) -or ($snake['y'][0] -gt 35))
        {
            $alive = $false
        }
        
        #check if snake collided with tail
        for($i = 1; $i -lt $snakeSize - 1; $i++){
            if($snake['x'][0] -eq $snake['x'][$i]){
                if($snake['y'][0] -eq $snake['y'][$i]){
                    $alive = $false
                    break
                }
            }
        }
        
        #check if snake touched pellet
        for($i = 0; $i -lt $pelletsX.count - 1; $i++){
            if($snake['x'][0] -eq $pelletsX[$i]){
                if($snake['y'][0] -eq $pelletsY[$i]){
                    $pelletsX.removeAt($i)
                    $pelletsY.removeAt($i)
                    $snake['x'] += ($snake['x'][0])
                    $snake['y'] += ($snake['y'][0])
                    break
                }
            }
        }

        #5% chance each tick to spawn a pellet
        if ((get-random -max 100) -gt 95){
            $x = get-random -minimum 1 -maximum ($width - 1)
            $y = get-random -minimum 1 -maximum ($height - 1)
            [void]$pelletsX.add($x)
            [void]$pelletsY.add($y)
            #cast to void to avoid printing index
            drawData '♫' $x $y
        }
        
        #deltaTime, not implemented
        $endTime = (Get-Date).ToFileTime()
        $deltaTime = $endTime - $startTime
        
        #
        start-sleep -milliseconds 70
    }
    
    #scoring is messed up somehow.
    Write-Host "GAME OVER. SCORE:" ($snake['x'].count - 1)
}

main
