-- Auto Arise
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

-- 🔹 Fungsi untuk mengaktifkan AutoArise
local function setAutoArise(state)
    settings:SetAttribute("AutoArise", state)
    print("AutoArise:", state and "ON" or "OFF")
end

-- 🔹 Pantau perubahan AutoArise
settings:GetAttributeChangedSignal("AutoArise"):Connect(function()
    print("⚡ AutoArise diubah menjadi:", settings:GetAttribute("AutoArise"))
end)

-- 🔹 Fungsi untuk menjalankan AutoClick
local autoClickRunning = false

local function startAutoClick(state)
    if state then
        if autoClickRunning then return end -- Cegah duplikasi loop
        autoClickRunning = true
        print("✅ AutoClick Dimulai!")

        while autoClickRunning do
            task.wait(0.5)

            local clickEvent = game:GetService("ReplicatedStorage"):FindFirstChild("ClickEvent")
            if clickEvent then
                clickEvent:FireServer()
                print("🖱 AutoClick berjalan...")
            else
                print("⚠ ClickEvent tidak ditemukan! AutoClick dihentikan.")
                autoClickRunning = false
            end
        end

        print("⛔ AutoClick Dihentikan!")
    else
        autoClickRunning = false
        print("⛔ AutoClick Dihentikan!")
    end
end

-- 🔹 Toggle AutoArise
local AutoAriseToggle = Tabs.Main:AddToggle("AutoAriseToggle", { Title = "AutoArise", Default = settings:GetAttribute("AutoArise") or false })
AutoAriseToggle:OnChanged(function(state)
    setAutoArise(state)
end)

-- 🔹 Toggle AutoClick
local AutoClickToggle = Tabs.Main:AddToggle("AutoClickToggle", { Title = "AutoClick", Default = settings:GetAttribute("AutoClick") or false })
AutoClickToggle:OnChanged(function(state)
    startAutoClick(state)
end)

-- 🔹 Pantau perubahan AutoClick
settings:GetAttributeChangedSignal("AutoClick"):Connect(function()
    startAutoClick(settings:GetAttribute("AutoClick"))
end)

-- Load UI Fluent
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
