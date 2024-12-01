local player = game.Players.LocalPlayer
local camera = game.Workspace.CurrentCamera
local character = player.Character or player.CharacterAdded:Wait()
local playerRoot = character:WaitForChild("HumanoidRootPart")
local lighting = game:GetService("Lighting")
local runService = game:GetService("RunService")

loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-flashlight-giver-23421"))()

-- Variables for intensity and effects
local intensityIncreaseRate = 0.05
local maxDistortion = 1.5
local maxBlurSize = 15  -- Reduced blur size for clearer vision
local maxShakeMagnitude = 2  -- Increased shake magnitude
local maxFogDensity = 0.5    -- Reduced fog density
local timePassed = 0
local sound1, sound2 = nil, nil
local hallucinationTime = 0
local wobbleStarted = false  -- New variable to track wobbling state

-- Sound IDs and Volume
local soundID1 = "rbxassetid://10976300369"
local soundID2 = "rbxassetid://1837075690"
local soundVolume = 0.5

-- Play the surreal sounds
local function playSounds()
    -- Check if the sounds aren't already playing
    if not sound1 then
        -- Create and configure the first sound
        sound1 = Instance.new("Sound")
        sound1.SoundId = soundID1
        sound1.Looped = true
        sound1.Volume = soundVolume
        sound1.Parent = game.Workspace
        sound1:Play()
    end

    if not sound2 then
        -- Create and configure the second sound
        sound2 = Instance.new("Sound")
        sound2.SoundId = soundID2
        sound2.Looped = true
        sound2.Volume = soundVolume
        sound2.Parent = game.Workspace
        sound2:Play()
    end
end

-- Apply Low Pitch for All Sounds (Including the New Sound)
local function applyLowPitch()
    runService.RenderStepped:Connect(function(_, dt)
        -- Loop through all sounds and change their pitch
        for _, obj in ipairs(game:GetDescendants()) do
            if obj:IsA("Sound") and obj.Playing then
                obj.Pitch = 0.2  -- Apply low pitch to all playing sounds
            end
        end
    end)
end

-- Mute Footstep Sounds
local function muteFootsteps()
    game:GetService("RunService").Heartbeat:Connect(function()
        for _, sound in ipairs(game:GetDescendants()) do
            if sound:IsA("Sound") then
                if sound.Name:lower():find("footstep") then
                    sound.Volume = 0  -- Mute the footstep sounds
                end
            end
        end
    end)
end

-- Apply Screen Flicker and Vibration Effect
local function applyScreenEffects()
    runService.RenderStepped:Connect(function(_, dt)
        local flickerChance = math.random()
        if flickerChance < 0.1 then
            -- Random flicker of the screen
            camera.CFrame = camera.CFrame * CFrame.Angles(0, math.sin(tick() * 10) * 0.1, 0)
        end
    end)
end

-- Apply Glitch Effects (distortion and visual glitches)
local function applyGlitches()
    runService.RenderStepped:Connect(function(_, dt)
        if math.random() < 0.05 then
            -- Apply random distortions to the camera
            local randomOffset = Vector3.new(math.random(-1, 1), math.random(-1, 1), math.random(-1, 1)) * 0.05
            camera.CFrame = camera.CFrame * CFrame.new(randomOffset)
        end

        -- Randomly glitch out the environment
        if math.random() < 0.03 then
            local glitch = Instance.new("Part")
            glitch.Size = Vector3.new(2, 2, 2)
            glitch.Position = camera.CFrame.Position + Vector3.new(math.random(-5, 5), 0, math.random(-5, 5))
            glitch.Anchored = true
            glitch.Transparency = 0.7
            glitch.Parent = workspace
            game:GetService("Debris"):AddItem(glitch, 0.1)  -- Remove the glitch after a short time
        end
    end)
end

-- Apply Eerie Static Effects
local function applyStaticEffects()
    runService.RenderStepped:Connect(function(_, dt)
        -- Simulate random static noise in the visual
        if math.random() < 0.1 then
            camera.CFrame = camera.CFrame * CFrame.Angles(0, math.sin(tick() * 100) * 0.05, 0)
        end
    end)
end

-- Apply Hallucinations: Floating Shadows, Shapes, etc.
local function applyHallucinations()
    runService.RenderStepped:Connect(function(_, dt)
        hallucinationTime = hallucinationTime + dt

        -- Random hallucinations: Create random shadow-like figures or invisible shapes
        if math.random() < 0.05 and hallucinationTime > 5 then
            local hallucination = Instance.new("Part")
            hallucination.Size = Vector3.new(3, 10, 3)
            hallucination.Position = Vector3.new(math.random(-30, 30), 10, math.random(-30, 30))
            hallucination.Anchored = true
            hallucination.Transparency = 0.7
            hallucination.Parent = workspace
            game:GetService("Debris"):AddItem(hallucination, 2)
        end

        -- After some time, hallucinations could flicker or vanish randomly
        if math.random() < 0.03 then
            camera.CFrame = camera.CFrame * CFrame.Angles(0, math.random() * 0.5, 0)
        end
    end)
end

-- Apply Fog and Particle Effects (Reduced Fog Density)
local function applyFogAndParticles()
    runService.RenderStepped:Connect(function(_, dt)
        local fog = lighting:FindFirstChild("Atmosphere") or Instance.new("Atmosphere")
        fog.Parent = lighting
        fog.Density = math.min(fog.Density + intensityIncreaseRate * 0.1, maxFogDensity)
        fog.Offset = math.min(fog.Offset + intensityIncreaseRate * 0.05, 1)

        -- Add random particle effects (dust, strange floating particles)
        local particle = Instance.new("ParticleEmitter")
        particle.Parent = camera
        particle.Enabled = true
        particle.Rate = math.random(1, 5)
        particle.Size = NumberSequence.new(math.random(2, 5))
    end)
end

-- Apply Motion Blur and Warping Effects
local function applyMotionBlurAndWarping()
    runService.RenderStepped:Connect(function(_, dt)
        local blur = lighting:FindFirstChild("BlurEffect") or Instance.new("BlurEffect")
        blur.Parent = lighting
        blur.Size = math.min(blur.Size + intensityIncreaseRate * 0.5, maxBlurSize)
        
        -- Warp the screen with random displacements
        local warp = CFrame.new(math.random(-0.1, 0.1), math.random(-0.1, 0.1), 0)
        camera.CFrame = camera.CFrame * warp
    end)
end

-- Apply Distorted Gravity and Out-of-Body Effects
local function applyGravityAndOutOfBody()
    runService.RenderStepped:Connect(function(_, dt)
        -- Randomly affect gravity
        if math.random() < 0.05 then
            workspace.Gravity = math.random(20, 100)  -- Unpredictable gravity changes
        end
        
        -- Out-of-body effect (camera floats slightly above or below normal view)
        camera.CFrame = camera.CFrame + Vector3.new(0, math.sin(tick()) * 0.05, 0)
    end)
end

-- Apply Camera Shake Effect
local function applyCameraShake()
    local shakeMagnitude = 0.1
    runService.RenderStepped:Connect(function(_, dt)
        if math.random() < 0.05 then
            -- Shake the camera randomly
            local shake = CFrame.new(math.random(-shakeMagnitude, shakeMagnitude), math.random(-shakeMagnitude, shakeMagnitude), math.random(-shakeMagnitude, shakeMagnitude))
            camera.CFrame = camera.CFrame * shake
        end
    end)
end

-- Apply Wobble Effect (Camera Shake and Distortion)
local function applyWobbleEffect()
    wait(30)  -- Delay before wobbling starts (30 seconds)
    wobbleStarted = true  -- Enable wobble

    runService.RenderStepped:Connect(function(_, dt)
        if wobbleStarted then
            -- Random small displacements to simulate wobble
            local wobble = CFrame.new(math.random(-0.5, 0.5), math.random(-0.5, 0.5), 0)
            camera.CFrame = camera.CFrame * wobble
        end
    end)
end

-- Apply Nighttime and Eerie Lighting
local function applyNighttimeEffects()
    lighting.TimeOfDay = "00:00"  -- Set to midnight
    lighting.Brightness = 0.2     -- Dim the brightness
    lighting.Ambient = Color3.fromRGB(10, 10, 10) -- Very dark ambient lighting
    lighting.OutdoorAmbient = Color3.fromRGB(10, 10, 10) -- Darken outdoor lighting
end

-- GUI for displaying messages (Flicker and Shake)
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player.PlayerGui
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local messageLabel = Instance.new("TextLabel")
messageLabel.Parent = screenGui
messageLabel.Size = UDim2.new(0, 600, 0, 100)
messageLabel.Position = UDim2.new(0.5, -300, 0.4, -50)
messageLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
messageLabel.TextSize = 32
messageLabel.TextStrokeTransparency = 0.8
messageLabel.TextTransparency = 0

messageLabel.BackgroundTransparency = 1
messageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255) 

-- Random disturbing messages
local messages = {
    "YOU CAN'T ESCAPE.",
    "IT'S TOO LATE.",
    "WHAT DO YOU SEE?",
    "I'M WATCHING.",
    "DON'T LOOK AWAY.",
    "I WANNA KILL MYSELF",
	"YOU SHOULD DO IT.",
	"THE DRUGS HELPED",
	"NOTHING HELPED",
	"EVERYONE IS FALSE",
"STOP TALKING",
"MY SMILE IS FAKE",
"I WANNA HURT MYSELF"
}

-- Function to show a new message
local function showMessage()
    local message = messages[math.random(1, #messages)]
    messageLabel.Text = message

    -- Flicker Effect
    local flickerTime = 0
    runService.Heartbeat:Connect(function()
        flickerTime = flickerTime + 0.1
        if flickerTime % 0.1 < 0.05 then
            messageLabel.TextTransparency = 1  -- Make text invisible
        else
            messageLabel.TextTransparency = 0  -- Make text visible
        end
    end)

    -- Shake Effect
    local shakeMagnitude = 10
    local shakeTime = 0
    runService.RenderStepped:Connect(function(_, dt)
        shakeTime = shakeTime + dt
        if shakeTime % 0.1 < 0.05 then
            messageLabel.Position = UDim2.new(0.5, math.random(-shakeMagnitude, shakeMagnitude), 0.4, math.random(-shakeMagnitude, shakeMagnitude))
        end
    end)

    -- Remove message after a certain duration
    wait(5)
    messageLabel.Text = ""
end

-- Loop to show messages every 5 seconds
spawn(function()
    while true do
        showMessage()
        wait(5)
    end
end)

-- Main function to start surreal effects
local function startEffects()
    playSounds()  -- Start the sounds
    applyLowPitch()
    muteFootsteps()  -- Mute footstep sounds
    applyScreenEffects()
    applyGlitches()  -- Add visual glitches
    applyStaticEffects()  -- Add eerie static
    applyHallucinations()  -- Hallucination effects
    applyCameraShake()  -- Add camera shake
    applyMotionBlurAndWarping()
    applyFogAndParticles()
    applyGravityAndOutOfBody()  -- Unpredictable gravity
    applyNighttimeEffects()  -- Make it night time
    applyWobbleEffect()  -- Add wobble effect after some time
end

-- Start the effects when the player enters the game
startEffects()

-- Reset the environment when the player respawns
player.CharacterAdded:Connect(function()
    wait(1)  -- Wait for respawn
    startEffects()  -- Restart effects
end)