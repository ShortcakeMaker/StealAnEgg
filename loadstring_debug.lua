-- Steal an Egg - Debug Version (Better Error Handling)
-- Game ID: 107778070777162

print("═══════════════════════════════════════════")
print("STEAL AN EGG - EXPLOIT LOADED")
print("═══════════════════════════════════════════")

local success, err = pcall(function()
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local UserInputService = game:GetService("UserInputService")
    local Workspace = game:GetService("Workspace")

    local player = Players.LocalPlayer
    print("✅ Player Found: " .. player.Name)

    local character = player.Character or player.CharacterAdded:Wait()
    print("✅ Character Found")

    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    print("✅ HumanoidRootPart Found")

    local humanoid = character:WaitForChild("Humanoid")
    print("✅ Humanoid Found")

    -- Config
    local config = {
        speedMultiplier = 1,
        enabled = true,
        godMode = false,
        noClip = false
    }

    print("\n" .. "═══════════════════════════════════════════")
    print("LOADING FUNCTIONS...")
    print("═══════════════════════════════════════════\n")

    -- SPEED HACK
    local function setSpeed(speed)
        config.speedMultiplier = speed
        humanoid.WalkSpeed = 16 * speed
        print("⚡ SPEED SET TO: " .. speed .. "x (Walk Speed: " .. (16 * speed) .. ")")
    end

    -- TELEPORT
    local function teleport(position)
        if humanoidRootPart then
            humanoidRootPart.CFrame = CFrame.new(position + Vector3.new(0, 3, 0))
            print("📍 TELEPORTED TO: " .. tostring(position))
        end
    end

    -- FIND EGG
    local function findEgg()
        print("��� SEARCHING FOR EGG...")
        
        local eggNames = {
            "Egg", "egg", "EggModel", "StealEgg", "EggPart", 
            "MainEgg", "EggSpawn", "EggObject"
        }
        
        for _, name in ipairs(eggNames) do
            local egg = Workspace:FindFirstChild(name)
            if egg and egg:IsA("BasePart") then
                print("✅ EGG FOUND: " .. name)
                print("📍 LOCATION: " .. tostring(egg.Position))
                return egg
            end
        end
        
        for _, obj in ipairs(Workspace:GetDescendants()) do
            if obj:IsA("BasePart") then
                if string.find(obj.Name:lower(), "egg") then
                    print("✅ EGG FOUND: " .. obj.Name)
                    print("📍 LOCATION: " .. tostring(obj.Position))
                    return obj
                end
            end
        end
        
        print("❌ EGG NOT FOUND")
        return nil
    end

    -- GRAB EGG
    local function grabEgg()
        print("🥚 GRABBING EGG...")
        local egg = findEgg()
        
        if egg then
            teleport(egg.Position)
            wait(0.5)
            egg.CFrame = humanoidRootPart.CFrame + humanoidRootPart.CFrame.LookVector * 5
            egg.CanCollide = false
            print("✨ EGG GRABBED!")
            return true
        end
        
        return false
    end

    -- FIND MONSTERS
    local function findMonsters()
        print("🔍 SEARCHING FOR MONSTERS...")
        local monsters = {}
        
        for _, obj in ipairs(Workspace:GetDescendants()) do
            if obj:FindFirstChild("Humanoid") and obj ~= character then
                local objName = obj.Name:lower()
                if string.find(objName, "monster") or string.find(objName, "enemy") then
                    table.insert(monsters, obj)
                    print("✅ MONSTER FOUND: " .. obj.Name)
                end
            end
        end
        
        print("📊 TOTAL MONSTERS FOUND: " .. #monsters)
        return monsters
    end

    -- BYPASS MONSTERS
    local function bypassMonsters()
        print("☠️ DEFEATING MONSTERS...")
        local monsters = findMonsters()
        
        for _, monster in ipairs(monsters) do
            if monster:FindFirstChild("Humanoid") then
                monster.Humanoid.Health = 0
                print("💀 DEFEATED: " .. monster.Name)
            end
        end
        
        print("✅ ALL MONSTERS DEFEATED!")
    end

    -- GOD MODE
    local function enableGodMode()
        config.godMode = true
        humanoid.MaxHealth = math.huge
        humanoid.Health = math.huge
        print("🛡️ GOD MODE ENABLED!")
    end

    -- NO-CLIP
    local function enableNoClip()
        config.noClip = true
        print("👻 NO-CLIP ENABLED!")
        
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

    -- AUTO COMPLETE
    local function autoComplete()
        print("\n" .. "═══════════════════════════════════════════")
        print("🎯 AUTO-COMPLETE STARTING!")
        print("═══════════════════════════════════════════\n")
        
        print("[1/5] ENABLING GOD MODE...")
        enableGodMode()
        wait(1)
        
        print("\n[2/5] SETTING SPEED TO 3x...")
        setSpeed(3)
        wait(1)
        
        print("\n[3/5] DEFEATING MONSTERS...")
        bypassMonsters()
        wait(2)
        
        print("\n[4/5] GRABBING EGG...")
        grabEgg()
        wait(2)
        
        print("\n[5/5] AUTO-COMPLETE FINISHED!")
        print("═══════════════════════════════════════════\n")
    end

    -- INPUT HANDLER
    print("✅ Setting up keybinds...\n")

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
            print("\n╔═══════════════════════════════════════════╗")
            print("║   STEAL AN EGG - KEYBINDS              ║")
            print("╠═══════════════════════════════════════════╣")
            print("║  E - Speed 1.5x       R - Speed 3x       ║")
            print("║  T - Speed 5x         Y - Speed 10x      ║")
            print("║  N - Normal Speed     F - Find Egg       ║")
            print("║  G - Grab Egg         H - Defeat Monsters║")
            print("║  J - God Mode         K - No-Clip        ║")
            print("║  L - Auto Complete    U - Show Menu      ║")
            print("╚═══════════════════════════════════════════╝\n")
        end
    end)

    print("╔═══════════════════════════════════════════╗")
    print("║   ✅ EXPLOIT READY TO USE!             ║")
    print("╚═══════════════════════════════════════════╝\n")
    print("KEYBINDS:")
    print("  L - AUTO COMPLETE LEVEL ⚡")
    print("  E/R/T/Y - SPEED HACKS")
    print("  F - FIND EGG")
    print("  G - GRAB EGG")
    print("  H - DEFEAT MONSTERS")
    print("  J - GOD MODE")
    print("  K - NO-CLIP")
    print("  U - SHOW MENU\n")

end)

if not success then
    print("\n❌ ERROR OCCURRED:")
    print(err)
    print("\nPlease report this error!")
end
