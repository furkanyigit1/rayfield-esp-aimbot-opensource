local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Sense = loadstring(game:HttpGet("https://raw.githubusercontent.com/your-repo/SenseESP.lua"))()

-- UI Penceresi
local Window = Rayfield:CreateWindow({
    Name = "🔥 Ultra ESP & Aimbot 🔥",
    LoadingTitle = "ESP & Aimbot Ultimate",
    LoadingSubtitle = "by YourName",
    Theme = "Amethyst",
    ConfigurationSaving = { Enabled = true, FolderName = "ESP_Aimbot_Pro", FileName = "settings" },
    KeySystem = false,
})

-- ESP Sekmesi
local ESPTab = Window:CreateTab("ESP", "eye")

-- ESP Aç/Kapat
local ToggleESP = ESPTab:CreateToggle({
    Name = "ESP Aç/Kapat",
    CurrentValue = false,
    Flag = "ESP_Toggle",
    Callback = function(value)
        Sense:SetESP(value)
    end,
})

-- Box ESP
local ToggleBox = ESPTab:CreateToggle({
    Name = "Box ESP",
    CurrentValue = false,
    Flag = "BoxESP",
    Callback = function(value)
        Sense:SetBox(value)
    end,
})

-- Tracer ESP
local ToggleTracer = ESPTab:CreateToggle({
    Name = "Tracer ESP",
    CurrentValue = false,
    Flag = "TracerESP",
    Callback = function(value)
        Sense:SetTracer(value)
    end,
})

-- Kullanıcı Adlarını Göster
local ToggleUsernames = ESPTab:CreateToggle({
    Name = "Kullanıcı Adlarını Göster",
    CurrentValue = false,
    Flag = "UsernamesESP",
    Callback = function(value)
        Sense:SetUsernames(value)
    end,
})

-- Can Barı
local ToggleHealth = ESPTab:CreateToggle({
    Name = "Can Barı Göster",
    CurrentValue = false,
    Flag = "HealthESP",
    Callback = function(value)
        Sense:SetHealthBars(value)
    end,
})

-- Mesafe Göstergesi
local ToggleDistance = ESPTab:CreateToggle({
    Name = "Mesafe Göster",
    CurrentValue = false,
    Flag = "DistanceESP",
    Callback = function(value)
        Sense:SetDistance(value)
    end,
})

-- Duvar Arkası Görme (Chams)
local ToggleWallhack = ESPTab:CreateToggle({
    Name = "Wallhack (Chams)",
    CurrentValue = false,
    Flag = "WallhackESP",
    Callback = function(value)
        Sense:SetWallhack(value)
    end,
})

-- ESP Renk Seçici
local ESPColorPicker = ESPTab:CreateColorPicker({
    Name = "ESP Rengi",
    Color = Color3.fromRGB(255, 0, 0),
    Flag = "ESP_Color",
    Callback = function(value)
        Sense:SetESPColor(value)
    end,
})

-- Aimbot Sekmesi
local AimbotTab = Window:CreateTab("Aimbot", "target")

-- Aimbot Aç/Kapat
local ToggleAimbot = AimbotTab:CreateToggle({
    Name = "Aimbot Aç/Kapat",
    CurrentValue = false,
    Flag = "Aimbot_Toggle",
    Callback = function(value)
        _G.AimbotActive = value
    end,
})

-- Aimbot FOV Ayarı
local AimbotFOV = AimbotTab:CreateSlider({
    Name = "Aimbot FOV",
    Range = {10, 300},
    Increment = 10,
    Suffix = "px",
    CurrentValue = 100,
    Flag = "Aimbot_FOV",
    Callback = function(value)
        _G.AimbotFOV = value
    end,
})

-- Aimbot Hassasiyet (Smoothness)
local AimbotSmooth = AimbotTab:CreateSlider({
    Name = "Aimbot Hassasiyet",
    Range = {1, 10},
    Increment = 1,
    Suffix = "x",
    CurrentValue = 5,
    Flag = "Aimbot_Smoothness",
    Callback = function(value)
        _G.AimbotSmoothness = value
    end,
})

-- Hitbox Expander (Büyük Kafalar)
local ToggleHitbox = AimbotTab:CreateToggle({
    Name = "Hitbox Büyütme",
    CurrentValue = false,
    Flag = "HitboxExpand",
    Callback = function(value)
        Sense:SetHitboxSize(value and 2 or 1)
    end,
})

-- Crosshair Sekmesi
local CrosshairTab = Window:CreateTab("Crosshair", "crosshair")

-- Crosshair Aç/Kapat
local ToggleCrosshair = CrosshairTab:CreateToggle({
    Name = "Crosshair Aç/Kapat",
    CurrentValue = false,
    Flag = "Crosshair",
    Callback = function(value)
        Sense:SetCrosshair(value)
    end,
})

-- FOV Çemberi Aç/Kapat
local ToggleFOVCircle = CrosshairTab:CreateToggle({
    Name = "FOV Çemberi Göster",
    CurrentValue = false,
    Flag = "FOVCircle",
    Callback = function(value)
        Sense:SetFOVCircle(value)
    end,
})

-- Hareket Sekmesi (Speed Hack & Jump Hack)
local MovementTab = Window:CreateTab("Movement", "run")

-- Speed Hack
local SpeedHack = MovementTab:CreateSlider({
    Name = "Hız Arttırma",
    Range = {16, 100},
    Increment = 1,
    Suffix = "WalkSpeed",
    CurrentValue = 16,
    Flag = "SpeedHack",
    Callback = function(value)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value
    end,
})

-- Jump Hack
local JumpHack = MovementTab:CreateSlider({
    Name = "Zıplama Yüksekliği",
    Range = {50, 300},
    Increment = 10,
    Suffix = "JumpPower",
    CurrentValue = 50,
    Flag = "JumpHack",
    Callback = function(value)
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = value
    end,
})

-- Aimbot Fonksiyonu
local function Aimbot()
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer

    game:GetService("RunService").RenderStepped:Connect(function()
        if _G.AimbotActive then
            local closestPlayer
            local shortestDistance = math.huge

            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    local enemyPos = player.Character.HumanoidRootPart.Position
                    local distance = (enemyPos - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude

                    if distance < shortestDistance and distance <= _G.AimbotFOV then
                        shortestDistance = distance
                        closestPlayer = player
                    end
                end
            end

            if closestPlayer then
                local aimPos = closestPlayer.Character.HumanoidRootPart.Position
                local aimSpeed = _G.AimbotSmoothness / 10
                LocalPlayer.Character.HumanoidRootPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame:Lerp(CFrame.new(LocalPlayer.Character.HumanoidRootPart.Position, aimPos), aimSpeed)
            end
        end
    end)
end

Aimbot()
