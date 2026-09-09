-- Steal an Egg - Roblox Exploit Loadstring
-- Game ID: 107778070777162
-- Repository: https://github.com/ShortcakeMaker/StealAnEgg
-- Features: Speed Hack, Egg Grabber, Monster Bypass, Auto Complete

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local humanoid = character:WaitForChild("Humanoid")

-- Exploit Settings
local config = {
    speedMultiplier = 1,
    enabled = true,
    godMode = false,
    noClip = false,
    autoComplete = false
}

-- ========== SPEED HACK ==========
local function setSpeed(speed)
    config.speedMultiplier = speed
    humanoid.WalkSpeed = 16 * speed
    print("⚡ Speed: " .. speed .. "x (Walk Speed: " .. (16 * speed) .. ")")
end

-- ========== TELEPORTATION ==========
local function teleport(position)
    if humanoidRootPart then
        humanoidRootPart.CFrame = CFrame.new(position + Vector3.new(0, 3, 0))
        print("📍 Teleported to: " .. tostring(position))
    end
end

-- ========== FIND EGG ==========
local function findEgg()
    print("🔍 Searching for egg...")
    
    -- Common egg part names
    local eggNames = {
        "Egg", "egg", "EggModel", "StealEgg", "EggPart", 
        "MainEgg", "EggSpawn", "EggObject", "FakeEgg",
        "Egg1", "EggPart1", "Part", "EggSpawner"
    }
    
    -- Search in Workspace
    for _, name in ipairs(eggNames) do
        local egg = Workspace:FindFirstChild(name)
        if egg and egg:IsA("BasePart") then
            print("✅ Egg found: " .. name .. " at " .. tostring(egg.Position))
            return egg
        end
    end
    
    -- Deep search through all descendants
    for _, obj in ipairs(Workspace:GetDescendants()) do
        if obj:IsA("BasePart") then
            local objName = obj.Name:lower()
            if string.find(objName, "egg") then
                print("✅ Egg found: " .. obj.Name .. " at " .. tostring(obj.Position))
                return obj
            end
        end
    end
    
    print("❌ Egg not found! Try searching manually.")
    return nil
end

-- ========== GRAB EGG ==========
local function grabEgg()
    print("🥚 Attempting to grab egg...")
    local egg = findEgg()
    
    if egg then
        -- Make egg grabbable
        if egg:FindFirstChild("BodyVelocity") then
            egg:FindFirstChild("BodyVelocity"):Destroy()
        end
        
        -- Teleport to egg
        teleport(egg.Position)
        wait(0.3)
        
        -- Pull egg to player
        egg.CFrame = humanoidRootPart.CFrame + humanoidRootPart.CFrame.LookVector * 5
        egg.CanCollide = false
        
        print("✨ Egg grabbed successfully!")
        return true
    end
    
    return false
end

-- ========== FIND MONSTERS ==========
local function findMonsters()
    print("🔍 Searching for monsters...")
    local monsters = {}
    
    local monsterNames = {
        "Monster", "monster", "Enemy", "enemy", "Boss", "Guardian",
        "Mob", "EnemyModel", "MonsterSpawn", "NPC"
    }
    
    -- Search by common names
    for _, name in ipairs(monsterNames) do
        local monster = Workspace:FindFirstChild(name)
        if monster and monster:FindFirstChild("Humanoid") then
            table.insert(monsters, monster)
            print("✅ Monster found: " .. name)
        end
    end
    
    -- Deep search
    for _, obj in ipairs(Workspace:GetDescendants()) do
        if obj:FindFirstChild("Humanoid") and obj ~= character then
            local objName = obj.Name:lower()
            if string.find(objName, "monster") or string.find(objName, "enemy") then
                table.insert(monsters, obj)
                print("✅ Monster found: " .. obj.Name)
            end
        end
    end
    
    print("Found " .. #monsters .. " monster(s)")
    return monsters
end

-- ========== BYPASS MONSTERS ==========
local function bypassMonsters()
    print("☠️ Bypassing monsters...")
    local monsters = findMonsters()
    
    for _, monster in ipairs(monsters) do
        if monster:FindFirstChild("Humanoid") then
            monster.Humanoid.Health = 0
            print("💀 Defeated: " .. monster.Name)
        end
    end
    
    print("✅ All monsters defeated!")
end

-- ========== GOD MODE ==========
local function enableGodMode()
    config.godMode = true
    humanoid.MaxHealth = math.huge
    humanoid.Health = math.huge
    
    humanoid.HealthChanged:Connect(function()
        if config.godMode then
            humanoid.Health = math.huge
        end
    end)
    
    print("🛡️ God Mode Enabled!")
end

-- ========== NO-CLIP ==========
local function enableNoClip()
    config.noClip = true
    print("👻 No-Clip Enabled!")
    
    RunService.RenderStepped:Connect(function()
        if config.noClip then
            for _, part in ipairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    end)
end

-- ========== FIND FINISH/SAFE ZONE ==========
local function findFinishZone()
    print("🔍 Searching for finish/safe zone...")
    
    local zoneNames = {
        "Finish", "SafeZone", "Safe", "End", "EndZone",
        "WinZone", "Goal", "SpawnZone", "Base"
    }
    
    for _, name in ipairs(zoneNames) do
        local zone = Workspace:FindFirstChild(name)
        if zone then
            print("✅ Finish zone found: " .. name)
            return zone
        end
    end
    
    -- Search for any zone with "finish" or "safe" in name
    for _, obj in ipairs(Workspace:GetDescendants()) do
        if obj:IsA("BasePart") then
            local objName = obj.Name:lower()
            if string.find(objName, "finish") or string.find(objName, "safe") or string.find(objName, "end") then
                print("✅ Finish zone found: " .. obj.Name)
                return obj
            end
        end
    end
    
    print("❌ Finish zone not found!")
    return nil
end

-- ========== AUTO COMPLETE LEVEL ==========
local function autoComplete()
    config.autoComplete = true
    print("\n🎯 Starting Auto-Complete Sequence...\n")
    
    -- Step 1: Enable God Mode
    print("[1/5] Enabling God Mode...")
    enableGodMode()
    wait(0.5)
    
    -- Step 2: Increase Speed
    print("[2/5] Setting Speed to 3x...")
    setSpeed(3)
    wait(0.5)
    
    -- Step 3: Defeat Monsters
    print("[3/5] Defeating Monsters...")
    bypassMonsters()
    wait(1)
    
    -- Step 4: Grab Egg
    print("[4/5] Grabbing Egg...")
    grabEgg()
    wait(1.5)
    
    -- Step 5: Escape to Finish Zone
    print("[5/5] Escaping to Finish Zone...")
    local finishZone = findFinishZone()
    
    if finishZone then
        teleport(finishZone.Position)
        wait(1)
        print("\n✅ LEVEL COMPLETE! ✅\n")
    else
        print("\n⚠️ Finish zone not found. Manually escape!\n")
    end
    
    config.autoComplete = false
end

-- ========== INPUT CONTROLS ==========
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == Enum.KeyCode.E then
        setSpeed(1.5)
    elseif input.KeyCode == Enum.KeyCode.R then
        setSpeed(3)
    elseif input.KeyCode == Enum.KeyCode.T then
        setSpeed(5)
    elseif input.KeyCode == Enum.KeyCode.Y then
        setSpeed(10)
    elseif input.KeyCode == Enum.KeyCode.N then
        setSpeed(1)
    elseif input.KeyCode == Enum.KeyCode.F then
        findEgg()
    elseif input.KeyCode == Enum.KeyCode.G then
        grabEgg()
    elseif input.KeyCode == Enum.KeyCode.H then
        bypassMonsters()
    elseif input.KeyCode == Enum.KeyCode.J then
        enableGodMode()
    elseif input.KeyCode == Enum.KeyCode.K then
        enableNoClip()
    elseif input.KeyCode == Enum.KeyCode.L then
        autoComplete()
    elseif input.KeyCode == Enum.KeyCode.U then
        displayMenu()
    end
end)

-- ========== DISPLAY MENU ==========
function displayMenu()
    print("\n╔═══════════════════════════════════════════╗")
    print("║   STEAL AN EGG - EXPLOIT MENU          ║")
    print("║   Game ID: 107778070777162             ║")
    print("╠═══════════════════════════════════════════╣")
    print("║  SPEED HACKS:                             ║")
    print("║    E - 1.5x Speed                         ║")
    print("║    R - 3x Speed                           ║")
    print("║    T - 5x Speed                           ║")
    print("║    Y - 10x Speed                          ║")
    print("║    N - Normal Speed (1x)                  ║")
    print("║                                           ║")
    print("║  EGG & MONSTERS:                          ║")
    print("║    F - Find Egg Location                  ║")
    print("║    G - Grab Egg                           ║")
    print("║    H - Defeat All Monsters                ║")
    print("║                                           ║")
    print("║  SPECIAL ABILITIES:                       ║")
    print("║    J - God Mode (Invincible)              ║")
    print("║    K - No-Clip (Walk Through Walls)       ║")
    print("║                                           ║")
    print("║  AUTO FEATURES:                           ║")
    print("║    L - Auto Complete Level                ║")
    print("║    U - Show This Menu                     ║")
    print("╚═══════════════════════════════════════════╝\n")
end

-- Initialize
print("\n✅ Exploit Loaded Successfully!\n")
displayMenu()

return config
