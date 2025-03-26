-- auto arise 
local player = game:GetService("Players").LocalPlayer
local settings = player:WaitForChild("Settings")

-- Fungsi untuk mengaktifkan AutoArise
local function enableAutoArise()
    if settings:GetAttribute("AutoArise") ~= true then
        settings:SetAttribute("AutoArise", true) -- Aktifkan AutoArise
        print("✅ AutoArise telah diaktifkan!")
    else
        print("⚠ AutoArise sudah aktif.")
    end
end

-- Aktifkan AutoArise saat script dimulai
task.wait(1) -- Tunggu sebentar agar Settings siap
enableAutoArise()

-- Pantau perubahan pada atribut AutoArise
settings:GetAttributeChangedSignal("AutoArise"):Connect(function()
    if settings:GetAttribute("AutoArise") then
        print("🔄 AutoArise tetap aktif.")
    end
end)

-- auto click
local player = game:GetService("Players").LocalPlayer
local settings = player:WaitForChild("Settings")

-- Fungsi untuk mengaktifkan AutoClick
local function enableAutoClick()
    if settings:GetAttribute("AutoClick") ~= true then
        settings:SetAttribute("AutoClick", true) -- Aktifkan AutoClick
        print("✅ AutoClick telah diaktifkan!")
    else
        print("⚠ AutoClick sudah aktif.")
    end
end

-- Jalankan AutoClick otomatis setiap 0.5 detik
task.spawn(function()
    while true do
        task.wait(0.5) -- Jeda waktu antar klik
        if settings:GetAttribute("AutoClick") then
            game:GetService("ReplicatedStorage"):WaitForChild("ClickEvent"):FireServer()
            print("🖱 AutoClick berjalan...")
        end
    end
end)

-- Aktifkan AutoClick saat script dimulai
task.wait(1) -- Tunggu sebentar agar Settings siap
enableAutoClick()

-- Pantau perubahan pada atribut AutoClick
settings:GetAttributeChangedSignal("AutoClick"):Connect(function()
    if settings:GetAttribute("AutoClick") then
        print("🔄 AutoClick tetap aktif.")
    end
end)


-- auto attack
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local LocalHumanoidRootPart = Character:WaitForChild("HumanoidRootPart")


coroutine.resume(coroutine.create(function()
    RunService.RenderStepped:Connect(function()
        if not attack then return end
        pcall(function()
            --- sc nyaa auto attack dengan pet
        end)
    end)
end))

SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({})
SaveManager:SetIgnoreIndexes({})

InterfaceManager:SetFolder("FluentScriptHub")
SaveManager:SetFolder("FluentScriptHub/specific-game")

InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)


Window:SelectTab(1)

Fluent:Notify({
    Title = "Fluent",
    Content = "The script has been loaded.",
    Duration = 8
})


SaveManager:LoadAutoloadConfig()
