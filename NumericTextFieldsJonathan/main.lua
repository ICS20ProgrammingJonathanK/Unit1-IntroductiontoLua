-----------------------------------------------------------------------------------------
-- Title: Numeric Textfield
-- Name: Jonathan Kene
-- Course ICS2O/3C
-- This program displays a math question and asks the user to answer in a numeric textfields\.
-- terminal.
-----------------------------------------------------------------------------------------

-- hide the status bar
display.setStatusBar(display.HiddenStatusBar)

-- sets the background colour
display.setDefault("background", 124/255, 249/255, 199/255)

---------------------------------------------------
--LOCAL VARIABLES
-------------------------------------------------

local questionObject

local correctObject
local incorrectObject

local numericField

local randomNumber1
local randomNumber2
local userAnswer
local correctAnswer

local pointsTextObject
local numberPoints = 0

local randomOperator
local gameOver

-- variables for the timer
local totalSeconds = 15
local secondsLeft = 15
local totalSeconds = 10
local secondsLeft = 10
local clockText
local countDownTimer

local lives = 4
local heart1
local heart2
local heart3
local heart4


---------------------------------------------------
-- SOUNDS
-------------------------------------------------


-- Correct sound
local correctSound = audio.loadSound( "Sounds/correctSound.mp3" ) -- Setting a variable to an mp3 file
local correctSoundChannel
local wrongSound = audio.loadSound( "Sounds/wrongSound.mp3" ) -- Setting a variable to an mp3 file
local correctSoundChannel
local wrongSoundChannel

 

---------------------------------------------------
--LOCAL FUNCTIONS
-------------------------------------------------

local function UpdateLives()
	if (lives == 3) then
    	heart4.isVisible = false	
    elseif (lives == 2) then
        heart3.isVisible = false
    elseif (lives == 1) then
        heart2.isVisible = false
    elseif (lives == 0) then
    	heart1.isVisible = false
        gameOver.isVisible = true
        timer.cancel(countDownTimer)
        numericField.isVisible = false
        wrongSoundChannel = audio.play(wrongSound)
    end 
end

local function UpdateTime()

	-- decrement the number of seconds left
	secondsLeft = secondsLeft -1

	-- display the number of seconds left in the clock object
	clockText.text = secondsLeft .. ""
    
    if (secondsLeft == 0) then
    	-- reset the number of seconds left in the clock object
    	secondsLeft = totalSeconds
    	lives = lives - 1

    	UpdateLives()
    end
end

-- function that calls the timer
local function StartTimer()
	-- create countdown timer that loops infinitely
	countDownTimer = timer.performWithDelay(1000, UpdateTime, 0)
end


 local function AskQuestion()
	-- generate 2 random numbers between a max. and a min. number
	randomOperator = math.random(1, 3)
	randomNumber1 = math.random(0, 12)
	randomNumber2 = math.random(0, 11)

	if (randomOperator == 1) then
		correctAnswer = randomNumber1 + randomNumber2

    	-- create question in the text object
    	questionObject.text = randomNumber1 .. " + " .. randomNumber2 .. " = "

	elseif (randomOperator == 2) then
		correctAnswer = randomNumber1 - randomNumber2

    	-- create question in the text object
    	questionObject.text = randomNumber1 .. " - " .. randomNumber2 .. " = "
 	
     elseif (randomOperator == 3) then
 		correctAnswer = randomNumber1 * randomNumber2

    	-- create question in the text object
    	questionObject.text = randomNumber1 .. " * " .. randomNumber2 .. " = "
    end
end

local function hideCorrect()
	correctObject.isVisible = false
	AskQuestion()
end 

local function hideIncorrect()
	incorrectObject.isVisible = false
	AskQuestion()
end

local function NumericFieldListener(event)

	-- User begins editing "numericField"
	if ( event.phase == "began" ) then

		-- clear text field
		event.target.text = ""

	elseif event.phase == "submitted" then

		-- when the answer is submitted (enter key is pressed) set user input to user's answer
		userAnswer = tonumber(event.target.text)

		-- if the user answer and the correct answer are the same:
		if (userAnswer == correctAnswer) then
			correctObject.isVisible = true
			incorrectObject.isVisible = false
			correctSoundChannel = audio.play(correctSound)
			timer.performWithDelay(1000, hideCorrect, 0)
			timer.performWithDelay(2000, hideCorrect, 0)
			numberPoints = numberPoints + 1
			secondsLeft = totalSeconds + 1

		     -- create increasing points in the text object
			 pointsTextObject.text = "Points = ".. numberPoints
	    else
	    	correctObject.isVisible = false
	    	incorrectObject.isVisible = true
	    	wrongSoundChannel = audio.play(wrongSound)
	    	timer.performWithDelay(2000, hideIncorrect)
	    	lives = lives - 1
	    	secondsLeft = totalSeconds + 1

	    -- call the function to decrease lives
	    	UpdateLives()
	    end

	    	event.target.text = ""

	end
end

---------------------------------------------------
-- OBJECT CREATION
-------------------------------------------------

-- create points box and make it visible
pointsTextObject = display.newText( "Points = ".. numberPoints, 800, 385, nil, 50 )
pointsTextObject:setTextColor(155/255, 42/255, 198/255)


-- displays a question and sets the colour
questionObject = display.newText( "", display.contentWidth/3, display.contentHeight/2, nil, 50 )
questionObject:setTextColor(155/255, 42/255, 198/255)

-- create the correct text object and make it invisble
correctObject = display.newText( "Correct!", display.contentWidth/2, display.contentHeight*2/3, nil, 50 )
correctObject:setTextColor(155/255, 42/255, 198/255)
correctObject.isVisible = false

-- create the incorrect text object and make it invisble
incorrectObject = display.newText( "Incorrect!", display.contentWidth/2, display.contentHeight*2/3, nil, 50 )
incorrectObject:setTextColor(155/255, 42/255, 198/255)
incorrectObject.isVisible = false

-- create the incorrect text object and make it invisble
clockText = display.newText( "", display.contentWidth/2, display.contentHeight*2/3, nil, 100 )
clockText:setTextColor(155/255, 42/255, 198/255)
clockText.isVisible = true
clockText.x = 200
clockText.y = 600

-- Create numeric field
numericField = native.newTextField( 520, 380, 150, 90 )
numericField.inputType = "number"

-- add the event listener for the numeric field
numericField:addEventListener( "userInput", NumericFieldListener )

-- add background image
gameOver = display.newImageRect("Images/gameOver.png", 1350, 900)
gameOver.x = 520
gameOver.y = 348
gameOver.isVisible = false

-- create the lives to display on the screen
heart1 = display.newImageRect("Images/heart.png", 100, 100)
heart1.x = display.contentWidth * 7 / 8
heart1.y = display.contentHeight * 1 / 7

heart2 = display.newImageRect("Images/heart.png", 100, 100)
heart2.x = display.contentWidth * 6 / 8
heart2.y = display.contentHeight * 1 / 7

heart3 = display.newImageRect("Images/heart.png", 100, 100)
heart3.x = display.contentWidth * 5 / 8
heart3.y = display.contentHeight * 1 / 7

heart4 = display.newImageRect("Images/heart.png", 100, 100)
heart4.x = display.contentWidth * 4 / 8
heart4.y = display.contentHeight * 1 / 7

---------------------------------------------------
-- FUNCTION CALLS
-------------------------------------------------

-- call the function to ask the question
StartTimer()

-- call the function to ask the question
AskQuestion()