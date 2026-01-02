-- [[ EDINOE GLITCH - FISH IT PREMIUM GUI ]] --
local player = game.Players.LocalPlayer
local HttpService = game:GetService("HttpService")

-- Variables Toggle
_G.AutoNotify = true
_G.AutoReel = true

-- 1. BIKIN GUI SIMPLE (KHUSUS HP)
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local NotifyBtn = Instance.new("TextButton")
local ReelBtn = Instance.new("TextButton")

ScreenGui.Name = "EdinoeGui"
ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.Position = UDim2.new(0.05, 0, 0.4, 0)
MainFrame.Size = UDim2.new(0, 150, 0, 180)
MainFrame.Active = true
MainFrame.Draggable = true -- Biar bisa digeser-geser di HP

Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Text = "EDINOE HUB"
Title.TextColor3 = Color3.fromRGB(255, 255, 0)
Title.BackgroundColor3 = Color3.fromRGB(45, 45, 45)

-- Tombol Notif
NotifyBtn.Parent = MainFrame
NotifyBtn.Position = UDim2.new(0.1, 0, 0.25, 0)
NotifyBtn.Size = UDim2.new(0.8, 0, 0, 35)
NotifyBtn.Text = "Discord: ON"
NotifyBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)

NotifyBtn.MouseButton1Click:Connect(function()
    _G.AutoNotify = not _G.AutoNotify
    NotifyBtn.Text = _G.AutoNotify and "Discord: ON" or "Discord: OFF"
    NotifyBtn.BackgroundColor3 = _G.AutoNotify and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(170, 0, 0)
end)

-- Tombol Auto Reel
ReelBtn.Parent = MainFrame
ReelBtn.Position = UDim2.new(0.1, 0, 0.55, 0)
ReelBtn.Size = UDim2.new(0.8, 0, 0, 35)
ReelBtn.Text = "Auto Reel: ON"
ReelBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)

ReelBtn.MouseButton1Click:Connect(function()
    _G.AutoReel = not _G.AutoReel
    ReelBtn.Text = _G.AutoReel and "Auto Reel: ON" or "Auto Reel: OFF"
    ReelBtn.BackgroundColor3 = _G.AutoReel and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(170, 0, 0)
end)

-- 2. LOGIKA AUTO REEL & NOTIFIER
task.spawn(function()
    while task.wait(0.1) do
        -- Cari Remote Event secara dinamis (contek skrip premium)
        for _, v in pairs(game:GetDescendants()) do
            if v:IsA("RemoteEvent") and v.Name == "CaughtFishVisual" then
                v.OnClientEvent:Connect(function(user, pos, fishName, data)
                    if tostring(user) == player.Name then
                        local weight = (type(data) == "table" and data.Weight) or "N/A"
                        
                        -- Kirim Notif kalau ON
                        if _G.AutoNotify and _G.Notifier then
                            _G.Notifier.Send(fishName, weight)
                        end
                        
                        -- Langsung Selesaiin Minigame kalau AutoReel ON
                        if _G.AutoReel then
                            local reelEvent = game:GetService("ReplicatedStorage"):FindFirstChild("ReelFinished", true)
                            if reelEvent then reelEvent:FireServer(100, true) end
                        end
                    end
                end)
                break
            end
        end
    end
end)

print("🔥 Edinoe Premium Loaded!")

