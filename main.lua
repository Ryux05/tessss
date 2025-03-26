-- auto arise 
local player = game:GetService("Players").LocalPlayer
local settings = player:WaitForChild("Settings")

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local Window = Fluent:CreateWindow({
    Title = "Fluent " .. Fluent.Version,
    SubTitle = "by Myuko",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true, -- The blur may be detectable, setting this to false disables blur entirely
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl -- Used when theres no MinimizeKeybind
})

-- Tab utama
local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "gamepad-2" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}

-- Fungsi untuk mengaktifkan/mematikan fitur
local function setAutoArise(state)
    settings:SetAttribute("AutoArise", state)
    print("AutoArise:", state and "ON" or "OFF")
end

local function setAutoClick(state)
    settings:SetAttribute("AutoClick", state)
    print("AutoClick:", state and "ON" or "OFF")
end

-- Toggle AutoArise
local AutoAriseToggle = Tabs.Main:AddToggle("AutoAriseToggle", { Title = "AutoArise", Default = settings:GetAttribute("AutoArise") or false })
AutoAriseToggle:OnChanged(function(state)
    setAutoArise(state)
end)


local running = false -- Menyimpan status loop AutoClick

-- Fungsi untuk menjalankan AutoClick
local function startAutoClick()
    if running then return end -- Cegah duplikasi loop
    running = true
    print("✅ AutoClick Dimulai!")
    
    while settings:GetAttribute("AutoClick") do
        task.wait(0.5)
        game:GetService("ReplicatedStorage"):WaitForChild("ClickEvent"):FireServer()
        print("🖱 AutoClick berjalan...")
    end

    running = false
    print("⛔ AutoClick Dihentikan!")
end

-- Pantau perubahan AutoClick
settings:GetAttributeChangedSignal("AutoClick"):Connect(function()
    if settings:GetAttribute("AutoClick") then
        startAutoClick() -- Mulai loop
    else
        running = false -- Hentikan loop
    end
end)


--loadstring(game:HttpGet("https://raw.githubusercontent.com/Ryux05/tessss/refs/heads/main/main.lua"))()

SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)
SaveManager:IgnoreThemeSettings()
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
