--// Universal Rayfield Script
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Serviços
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

--// Janela
local Window = Rayfield:CreateWindow({
    Name = "Moon Hub | Universal",
    LoadingTitle = "Carregando...",
    LoadingSubtitle = "Aguarde um tempo...",
    Theme = "Ocean",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "UniversalHub",
        FileName = "Settings"
    },
    Discord = {
        Enabled = false
    },
    KeySystem = false
})

--// Variáveis de Controle
local WalkSpeedEnabled = false
local JumpForceEnabled = false
local ESPEnabled = false
local WalkSpeedValue = 16
local JumpForceValue = 50

--// Função ESP
local function createESP()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and not player.Character:FindFirstChild("ESPBox") then
            local box = Instance.new("BoxHandleAdornment")
            box.Name = "ESPBox"
            box.Adornee = player.Character:FindFirstChild("HumanoidRootPart")
            box.Size = Vector3.new(4, 6, 2)
            box.Transparency = 0.5
            box.Color3 = Color3.fromRGB(0, 255, 0)
            box.ZIndex = 10
            box.AlwaysOnTop = true
            box.Parent = workspace
        end
    end
end

local function removeESP()
    for _, v in pairs(workspace:GetChildren()) do
        if v:IsA("BoxHandleAdornment") and v.Name == "ESPBox" then
            v:Destroy()
        end
    end
end

-- Atualizar ESP a cada frame
RunService.RenderStepped:Connect(function()
    if ESPEnabled then
        createESP()
    else
        removeESP()
    end
end)

--// Aba Menu
local MenuTab = Window:CreateTab("Menu", 4483362458)
MenuTab:CreateSlider({
    Name = "WalkSpeed",
    Range = {16, 500},
    Increment = 1,
    Suffix = "WalkSpeed",
    CurrentValue = WalkSpeedValue,
    Flag = "WalkSpeed",
    Callback = function(value)
        WalkSpeedValue = value
        if WalkSpeedEnabled then
            LocalPlayer.Character.Humanoid.WalkSpeed = WalkSpeedValue
        end
    end
})

MenuTab:CreateToggle({
    Name = "Ativar WalkSpeed",
    CurrentValue = false,
    Flag = "WalkSpeedToggle",
    Callback = function(value)
        WalkSpeedEnabled = value
        if WalkSpeedEnabled then
            LocalPlayer.Character.Humanoid.WalkSpeed = WalkSpeedValue
        else
            LocalPlayer.Character.Humanoid.WalkSpeed = 16
        end
    end
})

MenuTab:CreateSlider({
    Name = "JumpForce",
    Range = {50, 300},
    Increment = 1,
    Suffix = "JumpForce",
    CurrentValue = JumpForceValue,
    Flag = "JumpForce",
    Callback = function(value)
        JumpForceValue = value
        if JumpForceEnabled then
            LocalPlayer.Character.Humanoid.JumpPower = JumpForceValue
        end
    end
})

MenuTab:CreateToggle({
    Name = "Ativar JumpForce",
    CurrentValue = false,
    Flag = "JumpForceToggle",
    Callback = function(value)
        JumpForceEnabled = value
        if JumpForceEnabled then
            LocalPlayer.Character.Humanoid.JumpPower = JumpForceValue
        else
            LocalPlayer.Character.Humanoid.JumpPower = 50
        end
    end
})

--// Aba ESP
local ESPTab = Window:CreateTab("ESP", 4483362458)
ESPTab:CreateToggle({
    Name = "Ativar ESP",
    CurrentValue = false,
    Flag = "ESPToggle",
    Callback = function(value)
        ESPEnabled = value
        if not ESPEnabled then
            removeESP()
        end
    end
})

--// Aba Teleport
local TeleportTab = Window:CreateTab("Teleport", 4483362458)
local PlayerDropdown = TeleportTab:CreateDropdown({
    Name = "Selecionar Player",
    Options = {},
    CurrentOption = "",
    Flag = "PlayerDropdown",
    Callback = function(option)
        local targetPlayer = Players:FindFirstChild(option)
        if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character.HumanoidRootPart.CFrame = targetPlayer.Character.HumanoidRootPart.CFrame
        end
    end
})

TeleportTab:CreateButton({
    Name = "Atualizar Lista",
    Callback = function()
        local playersList = {}
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                table.insert(playersList, player.Name)
            end
        end
        PlayerDropdown:Refresh(playersList, true)
    end
})

--// Aba Créditos
local CreditsTab = Window:CreateTab("Créditos", 4483362458)

CreditsTab:CreateLabel("Criador: thalles456u")
CreditsTab:CreateLabel("Interface: Rayfield")
CreditsTab:CreateLabel("Qualquer dúvida sobre o Hub entre no discord, apenas clique no botão abaixo!")

CreditsTab:CreateButton({
  Name = "Clique aqui para entrar no discord do Hub!",
  Callback = function()
      setclipboard("https://discord.gg/WAGqyEfGJe")
    end
})
  
--// Atualizar lista de players ao iniciar
local playersListInit = {}
for _, player in pairs(Players:GetPlayers()) do
    if player ~= LocalPlayer then
        table.insert(playersListInit, player.Name)
    end
end
PlayerDropdown:Refresh(playersListInit, true)