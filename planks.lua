local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local localPlayer = game:GetService("Players").LocalPlayer
local camera = workspace.CurrentCamera
local headOff = Vector3.new(0, 0.5, 0)
local legOff = Vector3.new(0, 3, 0)
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local Settings = {
    Enabled = true,
    ShowBox = true,
    ShowHeadCircle = true,
    ShowOutlines = true,
    BoxColor = Color3.new(1, 1, 1),
    HeadCircleColor = Color3.new(1, 1, 1),
    OutlineColor = Color3.new(0, 0, 0),
    BoxThickness = 1,
    HeadCircleThickness = 1,
    OutlineThickness = 3,
    BoxWidth = 20,
    BoxHeight = 1.5,
    HeadCircleSize = 3,
    MaxDistance = 1000,
    TeamCheck = true,
    AimbotEnabled = false,
    ShowFOV = true,
    ShowFOVOutline = true,
    FOVRadius = 100,
    AimbotSmoothing = 0.5,
    AimbotMaxDistance = 1000,
    FOVColor = Color3.new(1, 1, 1),
    FOVOutlineColor = Color3.new(0, 0, 0),
    FOVThickness = 1,
    FOVOutlineThickness = 2
}

local Window = Rayfield:CreateWindow({
    Name = "Aceware: Planks",
    LoadingTitle = "Aceware: Planks",
    LoadingSubtitle = "by Yazz",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "AcewarePlanks",
        FileName = "Config"
    },
    Discord = {
        Enabled = false,
        Invite = "",
        RememberJoins = true
    },
    KeySystem = false
})

local VisualsTab = Window:CreateTab("Visuals", "rewind")
local GeneralTab = Window:CreateTab("General", "shield")
local ConfigsTab = Window:CreateTab("Configs", "save")
local AimbotTab = Window:CreateTab("Aimbot", "crosshair")

VisualsTab:CreateToggle({
    Name = "Enabled",
    CurrentValue = Settings.Enabled,
    Flag = "Enabled",
    Callback = function(Value)
        Settings.Enabled = Value
    end
})

VisualsTab:CreateToggle({
    Name = "Show Box",
    CurrentValue = Settings.ShowBox,
    Flag = "ShowBox",
    Callback = function(Value)
        Settings.ShowBox = Value
    end
})

VisualsTab:CreateToggle({
    Name = "Show Head Circle",
    CurrentValue = Settings.ShowHeadCircle,
    Flag = "ShowHeadCircle",
    Callback = function(Value)
        Settings.ShowHeadCircle = Value
    end
})

VisualsTab:CreateToggle({
    Name = "Show Outlines",
    CurrentValue = Settings.ShowOutlines,
    Flag = "ShowOutlines",
    Callback = function(Value)
        Settings.ShowOutlines = Value
    end
})

VisualsTab:CreateColorPicker({
    Name = "Box Color",
    Color = Settings.BoxColor,
    Flag = "BoxColor",
    Callback = function(Value)
        Settings.BoxColor = Value
    end
})

VisualsTab:CreateColorPicker({
    Name = "Head Circle Color",
    Color = Settings.HeadCircleColor,
    Flag = "HeadCircleColor",
    Callback = function(Value)
        Settings.HeadCircleColor = Value
    end
})

VisualsTab:CreateColorPicker({
    Name = "Outline Color",
    Color = Settings.OutlineColor,
    Flag = "OutlineColor",
    Callback = function(Value)
        Settings.OutlineColor = Value
    end
})

VisualsTab:CreateSlider({
    Name = "Box Thickness",
    Range = {0, 10},
    Increment = 0.1,
    CurrentValue = Settings.BoxThickness,
    Flag = "BoxThickness",
    Callback = function(Value)
        Settings.BoxThickness = Value
    end
})

VisualsTab:CreateSlider({
    Name = "Head Circle Thickness",
    Range = {0, 10},
    Increment = 0.1,
    CurrentValue = Settings.HeadCircleThickness,
    Flag = "HeadCircleThickness",
    Callback = function(Value)
        Settings.HeadCircleThickness = Value
    end
})

VisualsTab:CreateSlider({
    Name = "Outline Thickness",
    Range = {0, 10},
    Increment = 0.1,
    CurrentValue = Settings.OutlineThickness,
    Flag = "OutlineThickness",
    Callback = function(Value)
        Settings.OutlineThickness = Value
    end
})

VisualsTab:CreateSlider({
    Name = "Box Width",
    Range = {0, 50},
    Increment = 1,
    CurrentValue = Settings.BoxWidth,
    Flag = "BoxWidth",
    Callback = function(Value)
        Settings.BoxWidth = Value
    end
})

VisualsTab:CreateSlider({
    Name = "Box Height",
    Range = {0.5, 3},
    Increment = 0.1,
    CurrentValue = Settings.BoxHeight,
    Flag = "BoxHeight",
    Callback = function(Value)
        Settings.BoxHeight = Value
    end
})

VisualsTab:CreateSlider({
    Name = "Head Circle Size",
    Range = {0, 10},
    Increment = 0.1,
    CurrentValue = Settings.HeadCircleSize,
    Flag = "HeadCircleSize",
    Callback = function(Value)
        Settings.HeadCircleSize = Value
    end
})

GeneralTab:CreateToggle({
    Name = "Team Check",
    CurrentValue = Settings.TeamCheck,
    Flag = "TeamCheck",
    Callback = function(Value)
        Settings.TeamCheck = Value
    end
})

GeneralTab:CreateSlider({
    Name = "Max Distance",
    Range = {0, 5000},
    Increment = 10,
    CurrentValue = Settings.MaxDistance,
    Flag = "MaxDistance",
    Callback = function(Value)
        Settings.MaxDistance = Value
    end
})

local configFolder = "AcewarePlanks/Configs"
if not isfolder(configFolder) then
    makefolder(configFolder)
end

local function getConfigList()
    local configs = {}
    for _, file in ipairs(listfiles(configFolder)) do
        if isfile(file) then
            table.insert(configs, file:match(".+/(.-)%.json$"))
        end
    end
    return configs
end

ConfigsTab:CreateInput({
    Name = "Config Name",
    PlaceholderText = "Enter config name",
    Flag = "ConfigName",
    Callback = function(Value)
    end
})

ConfigsTab:CreateButton({
    Name = "Save Config",
    Callback = function()
        local configName = Rayfield:GetFlag("ConfigName")
        if configName and configName ~= "" then
            writefile(configFolder .. "/" .. configName .. ".json", game:GetService("HttpService"):JSONEncode(Settings))
            Rayfield:Notify({
                Title = "Config Saved",
                Content = "Saved config: " .. configName,
                Duration = 3
            })
        else
            Rayfield:Notify({
                Title = "Error",
                Content = "Please enter a valid config name",
                Duration = 3
            })
        end
    end
})

local configDropdown = ConfigsTab:CreateDropdown({
    Name = "Load Config",
    Options = getConfigList(),
    CurrentOption = "",
    Flag = "LoadConfig",
    Callback = function(Value)
        if Value and isfile(configFolder .. "/" .. Value .. ".json") then
            local configData = game:GetService("HttpService"):JSONDecode(readfile(configFolder .. "/" .. Value .. ".json"))
            for key, value in pairs(configData) do
                Settings[key] = value
                Rayfield:SetFlag(key, value)
            end
            Rayfield:Notify({
                Title = "Config Loaded",
                Content = "Loaded config: " .. Value,
                Duration = 3
            })
        end
    end
})

ConfigsTab:CreateButton({
    Name = "Refresh Config List",
    Callback = function()
        configDropdown:Refresh(getConfigList(), "")
        Rayfield:Notify({
            Title = "Config List Updated",
            Content = "Config dropdown has been refreshed",
            Duration = 3
        })
    end
})

AimbotTab:CreateToggle({
    Name = "Aimbot Enabled",
    CurrentValue = Settings.AimbotEnabled,
    Flag = "AimbotEnabled",
    Callback = function(Value)
        Settings.AimbotEnabled = Value
    end
})

AimbotTab:CreateToggle({
    Name = "Show FOV",
    CurrentValue = Settings.ShowFOV,
    Flag = "ShowFOV",
    Callback = function(Value)
        Settings.ShowFOV = Value
    end
})

AimbotTab:CreateToggle({
    Name = "Show FOV Outline",
    CurrentValue = Settings.ShowFOVOutline,
    Flag = "ShowFOVOutline",
    Callback = function(Value)
        Settings.ShowFOVOutline = Value
    end
})

AimbotTab:CreateSlider({
    Name = "FOV Radius",
    Range = {0, 1000},
    Increment = 1,
    CurrentValue = Settings.FOVRadius,
    Flag = "FOVRadius",
    Callback = function(Value)
        Settings.FOVRadius = Value
    end
})

AimbotTab:CreateSlider({
    Name = "Smoothing",
    Range = {0, 1},
    Increment = 0.001,
    CurrentValue = Settings.AimbotSmoothing,
    Flag = "AimbotSmoothing",
    Callback = function(Value)
        Settings.AimbotSmoothing = Value
    end
})

AimbotTab:CreateSlider({
    Name = "Max Distance",
    Range = {0, 5000},
    Increment = 10,
    CurrentValue = Settings.AimbotMaxDistance,
    Flag = "AimbotMaxDistance",
    Callback = function(Value)
        Settings.AimbotMaxDistance = Value
    end
})

AimbotTab:CreateSlider({
    Name = "FOV Thickness",
    Range = {0, 10},
    Increment = 0.1,
    CurrentValue = Settings.FOVThickness,
    Flag = "FOVThickness",
    Callback = function(Value)
        Settings.FOVThickness = Value
    end
})

AimbotTab:CreateSlider({
    Name = "FOV Outline Thickness",
    Range = {0, 10},
    Increment = 0.1,
    CurrentValue = Settings.FOVOutlineThickness,
    Flag = "FOVOutlineThickness",
    Callback = function(Value)
        Settings.FOVOutlineThickness = Value
    end
})

AimbotTab:CreateColorPicker({
    Name = "FOV Color",
    Color = Settings.FOVColor,
    Flag = "FOVColor",
    Callback = function(Value)
        Settings.FOVColor = Value
    end
})

AimbotTab:CreateColorPicker({
    Name = "FOV Outline Color",
    Color = Settings.FOVOutlineColor,
    Flag = "FOVOutlineColor",
    Callback = function(Value)
        Settings.FOVOutlineColor = Value
    end
})

local fovCircle = Drawing.new("Circle")
fovCircle.Visible = Settings.ShowFOV
fovCircle.Color = Settings.FOVColor
fovCircle.Thickness = Settings.FOVThickness
fovCircle.Radius = Settings.FOVRadius
fovCircle.NumSides = 64

local fovCircleOutline = Drawing.new("Circle")
fovCircleOutline.Visible = Settings.ShowFOV and Settings.ShowFOVOutline
fovCircleOutline.Color = Settings.FOVOutlineColor
fovCircleOutline.Thickness = Settings.FOVOutlineThickness
fovCircleOutline.Radius = Settings.FOVRadius + 2
fovCircleOutline.NumSides = 64

local function getMousePosition()
    local mousePos = UserInputService:GetMouseLocation()
    return Vector2.new(mousePos.X, mousePos.Y)
end

local function getClosestPlayerToMouse()
    local closestPlayer = nil
    local closestDistance = Settings.FOVRadius
    local mousePos = getMousePosition()

    for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
        if player ~= localPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character:FindFirstChild("Head") then
            local humanoid = player.Character.Humanoid
            local rootPart = player.Character.HumanoidRootPart
            local head = player.Character.Head
            local distance = (localPlayer.Character and localPlayer.Character.HumanoidRootPart and (rootPart.Position - localPlayer.Character.HumanoidRootPart.Position).Magnitude) or math.huge
            local sameTeam = Settings.TeamCheck and player.Team == localPlayer.Team

            if humanoid.Health > 0 and distance <= Settings.AimbotMaxDistance and not sameTeam then
                local headPos, onScreen = camera:WorldToViewportPoint(head.Position)
                if onScreen then
                    local headScreenPos = Vector2.new(headPos.X, headPos.Y)
                    local screenDistance = (headScreenPos - mousePos).Magnitude
                    if screenDistance <= closestDistance then
                        closestDistance = screenDistance
                        closestPlayer = player
                    end
                end
            end
        end
    end

    return closestPlayer
end

local isRightMouseHeld = false
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if input.UserInputType == Enum.UserInputType.MouseButton2 and not gameProcessed then
        isRightMouseHeld = true
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton2 then
        isRightMouseHeld = false
    end
end)

local function createBoxESP(player)
    local boxOutline = Drawing.new("Square")
    boxOutline.Visible = false
    boxOutline.Color = Settings.OutlineColor
    boxOutline.Thickness = Settings.OutlineThickness

    local box = Drawing.new("Square")
    box.Visible = false
    box.Color = Settings.BoxColor
    box.Thickness = Settings.BoxThickness

    local circleOutline = Drawing.new("Circle")
    circleOutline.Visible = false
    circleOutline.Color = Settings.OutlineColor
    circleOutline.Thickness = Settings.OutlineThickness

    local circle = Drawing.new("Circle")
    circle.Visible = false
    circle.Color = Settings.HeadCircleColor
    circle.Thickness = Settings.HeadCircleThickness

    RunService.RenderStepped:Connect(function()
        if not Settings.Enabled then
            boxOutline.Visible = false
            box.Visible = false
            circleOutline.Visible = false
            circle.Visible = false
            return
        end

        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character:FindFirstChild("Head") and player ~= localPlayer then
            local humanoid = player.Character.Humanoid
            local rootPart = player.Character.HumanoidRootPart
            local head = player.Character.Head
            local distance = (localPlayer.Character and localPlayer.Character.HumanoidRootPart and (rootPart.Position - localPlayer.Character.HumanoidRootPart.Position).Magnitude) or math.huge
            local sameTeam = Settings.TeamCheck and player.Team == localPlayer.Team
            if humanoid.Health > 0 and distance <= Settings.MaxDistance and not sameTeam then
                local rootPos, onScreen = camera:WorldToViewportPoint(rootPart.Position)
                local headPos = camera:WorldToViewportPoint(head.Position)
                local circlePos = camera:WorldToViewportPoint(head.Position + headOff)
                local legPos = camera:WorldToViewportPoint(rootPart.Position - legOff)
                if onScreen then
                    local height = (headPos.Y - legPos.Y) * Settings.BoxHeight
                    local width = (Settings.BoxWidth * 100) / rootPos.Z
                    local radius = (Settings.HeadCircleSize * 100) / rootPos.Z

                    boxOutline.Size = Vector2.new(width, height)
                    boxOutline.Position = Vector2.new(rootPos.X - width/2, legPos.Y)
                    boxOutline.Visible = Settings.ShowBox and Settings.ShowOutlines
                    boxOutline.Color = Settings.OutlineColor
                    boxOutline.Thickness = Settings.OutlineThickness

                    box.Size = Vector2.new(width, height)
                    box.Position = Vector2.new(rootPos.X - width/2, legPos.Y)
                    box.Visible = Settings.ShowBox
                    box.Color = Settings.BoxColor
                    box.Thickness = Settings.BoxThickness

                    circleOutline.Position = Vector2.new(headPos.X, headPos.Y)
                    circleOutline.Radius = radius
                    circleOutline.Visible = Settings.ShowHeadCircle and Settings.ShowOutlines
                    circleOutline.Color = Settings.OutlineColor
                    circleOutline.Thickness = Settings.OutlineThickness

                    circle.Position = Vector2.new(headPos.X, headPos.Y)
                    circle.Radius = radius
                    circle.Visible = Settings.ShowHeadCircle
                    circle.Color = Settings.HeadCircleColor
                    circle.Thickness = Settings.HeadCircleThickness

                    return
                end
            end
        end
        boxOutline.Visible = false
        box.Visible = false
        circleOutline.Visible = false
        circle.Visible = false
    end)
end

for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
    if player ~= localPlayer then
        createBoxESP(player)
    end
end

game:GetService("Players").PlayerAdded:Connect(function(player)
    createBoxESP(player)
end)

RunService.RenderStepped:Connect(function()
    local mousePos = getMousePosition()
    fovCircle.Position = mousePos
    fovCircle.Radius = Settings.FOVRadius
    fovCircle.Color = Settings.FOVColor
    fovCircle.Thickness = Settings.FOVThickness
    fovCircle.Visible = Settings.ShowFOV

    fovCircleOutline.Position = mousePos
    fovCircleOutline.Radius = Settings.FOVRadius + 2
    fovCircleOutline.Color = Settings.FOVOutlineColor
    fovCircleOutline.Thickness = Settings.FOVOutlineThickness
    fovCircleOutline.Visible = Settings.ShowFOV and Settings.ShowFOVOutline

    if Settings.AimbotEnabled and isRightMouseHeld then
        local target = getClosestPlayerToMouse()
        if target and target.Character and target.Character:FindFirstChild("Head") then
            local headPos, onScreen = camera:WorldToViewportPoint(target.Character.Head.Position)
            if onScreen then
                local targetScreenPos = Vector2.new(headPos.X, headPos.Y)
                local delta = targetScreenPos - mousePos
                local smoothDelta = delta * (1 - Settings.AimbotSmoothing)
                mousemoverel(smoothDelta.X, smoothDelta.Y)
            end
        end
    end
end)
