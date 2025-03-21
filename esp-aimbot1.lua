local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Sense = loadstring(game:HttpGet("https://raw.githubusercontent.com/your-repo/SenseESP.lua"))()

-- Arayüz penceresi oluştur
local Window = Rayfield:CreateWindow({
    Name = "Gelişmiş ESP & Aimbot",
    LoadingTitle = "ESP & Aimbot Pro",
    LoadingSubtitle = "by YourName",
    Theme = "DarkBlue",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "ESP_Aimbot",
        FileName = "settings"
    },
    KeySystem = false,
})

-- ESP sekmesi
local ESPTab = Window:CreateTab("ESP", "eye")

-- ESP Aç/Kapat
local ToggleESP = ESPTab:CreateToggle({
    Name = "ESP Aç/Kapat",
    CurrentValue = false,
    Flag = "ESP_Toggle",
    Callback = function(value)
        if value then
            Sense:EnableESP()
        else
            Sense:DisableESP()
        end
    end,
})

-- Tracer Aç/Kapat
local ToggleTracer = ESPTab:CreateToggle({
    Name = "Tracer Aç/Kapat",
    CurrentValue = false,
    Flag = "Tracer_Toggle",
    Callback = function(value)
        Sense:SetTracer(value)
    end,
})

-- Kullanıcı Adlarını Göster
local ToggleUsernames = ESPTab:CreateToggle({
    Name = "Kullanıcı Adlarını Göster",
    CurrentValue = false,
    Flag = "Usernames_Toggle",
    Callback = function(value)
        Sense:SetUsernames(value)
    end,
})

-- Can Barı Göster
local ToggleHealth = ESPTab:CreateToggle({
    Name = "Can Barını Göster",
    CurrentValue = false,
    Flag = "Health_Toggle",
    Callback = function(value)
        Sense:SetHealthBars(value)
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

-- Aimbot sekmesi
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

-- Aimbot Smoothness (Yumuşaklık) Ayarı
local AimbotSmoothness = AimbotTab:CreateSlider({
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

-- Aimbot hedefleme fonksiyonu
local function Aimbot()
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local Mouse = LocalPlayer:GetMouse()

    game:GetService("RunService").RenderStepped:Connect(function()
        if _G.AimbotActive then
            local closestPlayer
            local shortestDistance = math.huge

            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    local enemyPos = player.Character.HumanoidRootPart.Position
                    local distance = (enemyPos - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude

                    if distance < shortestDistance then
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
