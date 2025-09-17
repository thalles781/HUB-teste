-- Carrega Rayfield
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Serviços
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")

-- Cria janela principal
local Window = Rayfield:CreateWindow({
    Name = "Universal Hub",
    LoadingTitle = "Carregando Universal Hub...",
    LoadingSubtitle = "by thalles456u",
    Theme = "Dark",
    ToggleUIKeybind = "K",
    ConfigurationSaving = {Enabled = true, FolderName = "UniversalHub"}
})

-- Aba Menu
local MenuTab = Window:CreateTab("Menu", 4483362458)

-- Variáveis do jogador
local Humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
local HRP = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
local WalkSpeed = 16
local JumpPower = 50

-- Funções para atualizar
local function UpdateSpeed(speed)
    if Humanoid then
        Humanoid.WalkSpeed = speed
    end
end

local function UpdateJump(jump)
    if Humanoid then
        Humanoid.JumpPower = jump
    end
end

-- Sliders Rayfield
MenuTab:CreateSlider({
    Name = "WalkSpeed",
    Min = 16,
    Max = 100,
    Default = 16,
    Callback = function(value)
        WalkSpeed = value
        UpdateSpeed(WalkSpeed)
    end
})

MenuTab:CreateSlider({
    Name = "JumpForce",
    Min = 50,
    Max = 300,
    Default = 50,
    Callback = function(value)
        JumpPower = value
        UpdateJump(JumpPower)
    end
})

-- Infinity Jump
local InfinityJumpEnabled = false
MenuTab:CreateToggle({
    Name = "Infinity Jump",
    CurrentValue = false,
    Callback = function(state)
        InfinityJumpEnabled = state
    end
})

UIS.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and InfinityJumpEnabled then
        if input.UserInputType == Enum.UserInputType.Keyboard then
            if input.KeyCode == Enum.KeyCode.Space then
                if Humanoid and HRP then
                    Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                end
            end
        end
    end
end)

-- ESP
local ESPTab = Window:CreateTab("ESP", 4483362458)
local ESPObjects = {}

local function CreateESP(player)
    if player == LocalPlayer then return end
    if ESPObjects[player] then return end

    local box = Instance.new("BillboardGui")
    box.Name = "ESP"
    box.Adornee = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    box.Size = UDim2.new(0,100,0,50)
    box.AlwaysOnTop = true

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1,0,1,0)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.fromRGB(255,0,0)
    label.Text = player.Name
    label.TextScaled = true
    label.Parent = box

    box.Parent = game.CoreGui
    ESPObjects[player] = box
end

local function RemoveESP(player)
    if ESPObjects[player] then
        ESPObjects[player]:Destroy()
        ESPObjects[player] = nil
    end
end

RunService.RenderStepped:Connect(function()
    for _, player in pairs(Players:GetPlayers()) do
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            if not ESPObjects[player] then
                CreateESP(player)
            end
        else
            RemoveESP(player)
        end
    end
end)

Players.PlayerRemoving:Connect(function(player)
    RemoveESP(player)
end)

-- Teleport
local TeleportTab = Window:CreateTab("Teleport", 4483362458)
local PlayerList = {}
local SelectedPlayer = nil

local function UpdatePlayerList()
    PlayerList = {}
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            table.insert(PlayerList, player.Name)
        end
    end
end

local PlayerDropdown = TeleportTab:CreateDropdown({
    Name = "Escolha um Player",
    Options = PlayerList,
    Callback = function(value)
        SelectedPlayer = value
    end
})

TeleportTab:CreateButton({
    Name = "Atualizar lista de players",
    Callback = function()
        UpdatePlayerList()
        PlayerDropdown:UpdateOptions(PlayerList)
    end
})

TeleportTab:CreateButton({
    Name = "Teleportar para Player",
    Callback = function()
        if SelectedPlayer then
            local targetPlayer = Players:FindFirstChild(SelectedPlayer)
            if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
                LocalPlayer.Character.HumanoidRootPart.CFrame = targetPlayer.Character.HumanoidRootPart.CFrame
            end
        end
    end
})

----------------------------------------------------
-- Aba Créditos
----------------------------------------------------
local CreditsTab = Window:CreateTab("Créditos", 4483362458)
CreditsTab:CreateLabel("Criador: thalles456u")
CreditsTab:CreateLabel("Interface: Rayfield")
CreditsTab:CreateLabel("Qualquer dúvida sobre o Hub entre no discord, apenas clique no botão abaixo!")

CreditsTab:CreateButton({
    Name = "Clique aqui para entrar no discord do Hub!",
    Callback = function()
        if setclipboard then
            setclipboard("https://discord.gg/WAGqyEfGJe")
        else
            warn("Seu executor não suporta setclipboard, entre em contato com o suporte do Hub!")
        end
    end
})