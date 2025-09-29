--// Moon Hub Final Unificado
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "Moon Hub | Brookhaven",
    LoadingTitle = "Carregando...",
    LoadingSubtitle = "Aguarde alguns segundos...",
    Theme = "Ocean",
    ToggleUIKeybind = "K",
    ConfigurationSaving = {Enabled = true, FolderName = nil, FileName = "Talos Hub"},
    
    Discord = {
        Enabled = false, 
        Invite = "WY2Q4dS88N", 
        RememberJoins = true
    },
    
    KeySystem = false,
    KeySettings = {
      Title = "Talos Key",
      Subtitle = "Key System",
      Note = "Entre no site para conseguir a key! É simples e fácil de conseguir!",
      FileName = "Key",
      SaveKey = false,
      GrabKeyFromSite = true,
      Key = {"K9D3-MQ7Z-T4L2", "L2C8-BJ8N-XAS7", "R8F6-V1XK-P0Z3", "H3Y9-CA4M-N7Q8", "W2Z5-JL8R-K6T1", "M7P2-QX9D-F4G5", "T1N6-BV3Y-Z8H4", "C5X8-L0P3-R9K7", "D9J2-KF5L-H8R0", "Z4M1-GT7Q-V2S6"}
   }
})   

-- =========================
-- ABA DE CRÉDITOS
-- =========================
local CreditsTab = Window:CreateTab("Créditos", 4483362458)

CreditsTab:CreateLabel("Feito por: thalles456u")
CreditsTab:CreateLabel("Interface por: Rayfield")
CreditsTab:CreateLabel("Alguma dúvida? Entre no nosso discord! Apenas clique na mensagem abaixo!")

CreditsTab:CreateButton({
    Name = "Clique aqui para copiar o link do Discord!",
    Callback = function()
        setclipboard("https://discord.gg/WAGqyEfGJe")
    end
})

-- =========================
-- ABA LOCALPLAYER
-- =========================
local LocalPlayerTab = Window:CreateTab("LocalPlayer", 4483362458)

LocalPlayerTab:CreateSection("Mudanças no Player")

-- Speed
LocalPlayerTab:CreateInput({
    Name = "Velocidade",
    PlaceholderText = "Digite a velocidade",
    RemoveTextAfterFocusLost = false,
    Callback = function(Value)
        local speed = tonumber(Value)
        local player = game.Players.LocalPlayer
        if speed and player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.WalkSpeed = speed
        end
    end
})

-- Infinity Jump
local InfinityJumpEnabled = false
LocalPlayerTab:CreateToggle({
    Name = "Pulo Infinito",
    CurrentValue = false,
    Callback = function(Value)
        InfinityJumpEnabled = Value
    end
})
game:GetService("UserInputService").JumpRequest:Connect(function()
    if InfinityJumpEnabled then
        local player = game.Players.LocalPlayer
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)

-- Noclip
local NoclipEnabled = false
LocalPlayerTab:CreateToggle({
    Name = "Noclip",
    CurrentValue = false,
    Callback = function(Value)
        NoclipEnabled = Value
    end
})
game:GetService("RunService").Stepped:Connect(function()
    if NoclipEnabled then
        local player = game.Players.LocalPlayer
        if player.Character then
            for _, part in pairs(player.Character:GetChildren()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    end
end)

-- Fly
local FlyEnabled = false
local FlySpeed = 50
local BodyVelocity

LocalPlayerTab:CreateToggle({
    Name = "Voar (PC & Mobile)",
    CurrentValue = false,
    Callback = function(Value)
        FlyEnabled = Value
        local player = game.Players.LocalPlayer
        if FlyEnabled and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = player.Character.HumanoidRootPart
            BodyVelocity = Instance.new("BodyVelocity")
            BodyVelocity.MaxForce = Vector3.new(4000, 4000, 4000)
            BodyVelocity.Velocity = Vector3.new(0,0,0)
            BodyVelocity.Parent = hrp

            game:GetService("RunService").Heartbeat:Connect(function()
                if FlyEnabled and BodyVelocity and hrp then
                    local moveDir = player.Character.Humanoid.MoveDirection
                    BodyVelocity.Velocity = Vector3.new(moveDir.X * FlySpeed, 0, moveDir.Z * FlySpeed)
                elseif BodyVelocity then
                    BodyVelocity:Destroy()
                end
            end)
        elseif BodyVelocity then
            BodyVelocity:Destroy()
        end
    end
})

-- =========================
-- ABA TELEPORT
-- =========================
local TeleportTab = Window:CreateTab("Teleport", 4483362458)

TeleportTab:CreateSection("Teleport Players")
TeleportTab:CreateInput({
    Name = "Teleporte por Nick",
    PlaceholderText = "Digite o Nick do jogador",
    RemoveTextAfterFocusLost = false,
    Callback = function(Nick)
        local target = game.Players:FindFirstChild(Nick)
        local player = game.Players.LocalPlayer
        if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                player.Character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame + Vector3.new(0,3,0)
            end
        else
            warn("Jogador não encontrado ou sem personagem")
        end
    end
})

-- Lista de lugares fixos
TeleportTab:CreateSection("Lugares Fixos")

local Lugares = {
    ["Praça"] = Vector3.new(-0.57, 2.71, -1.05),
    ["Escola"] = Vector3.new(-312, 3.01, 211.61)
}

local LugarSelecionado = "Praça"

TeleportTab:CreateDropdown({
    Name = "Escolha o lugar",
    Options = {"Praça", "Escola"},
    CurrentOption = {"Praça"},
    MultipleOptions = false,
    Callback = function(Option)
        LugarSelecionado = Option[1]
    end
})

TeleportTab:CreateButton({
    Name = "Teleportar",
    Callback = function()
        local player = game.Players.LocalPlayer
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            if LugarSelecionado and Lugares[LugarSelecionado] then
                player.Character.HumanoidRootPart.CFrame = CFrame.new(Lugares[LugarSelecionado])
            else
                Rayfield:Notify({
                    Title = "Teleport",
                    Content = "Nenhum lugar selecionado!",
                    Duration = 5,
                    Image = 4483362458
                })
            end
        end
    end
})

-- =========================
-- ABA SPECT
-- =========================
local SpectTab = Window:CreateTab("Spect", 4483362458)

SpectTab:CreateSection("Spect Player")
SpectTab:CreateInput({
    Name = "Spectar por Nick",
    PlaceholderText = "Digite o Nick do jogador",
    RemoveTextAfterFocusLost = false,
    Callback = function(Nick)
        local target = game.Players:FindFirstChild(Nick)
        local cam = workspace.CurrentCamera
        if target and target.Character and target.Character:FindFirstChild("Humanoid") then
            cam.CameraSubject = target.Character.Humanoid
        else
            warn("Jogador não encontrado ou sem personagem")
        end
    end
})

-- =========================
-- ABA CASA
-- =========================
local CasaTab = Window:CreateTab("Casa", 4483362458)

CasaTab:CreateSection("Unban casa")
CasaTab:CreateButton({
    Name = "Unban All",
    Callback = function()
        local count = 0
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj.Name == "BannedBlock" then
                obj:Destroy()
                count = count + 1
            end
        end
        Rayfield:Notify({
            Title = "Unban All",
            Content = tostring(count).." BannedBlocks removidos!",
            Duration = 5,
            Image = 4483362458
        })
    end
})

local AutoUnban = false
local AutoUnbanConnection

CasaTab:CreateToggle({
    Name = "Auto Unban",
    CurrentValue = false,
    Callback = function(Value)
        AutoUnban = Value
        if AutoUnban then
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj.Name == "BannedBlock" then
                    obj:Destroy()
                end
            end
            AutoUnbanConnection = workspace.DescendantAdded:Connect(function(obj)
                if obj.Name == "BannedBlock" then
                    obj:Destroy()
                end
            end)
            Rayfield:Notify({
                Title = "Auto Unban",
                Content = "Ativado! Todos os BannedBlocks serão removidos automaticamente.",
                Duration = 5,
                Image = 4483362458
            })
        else
            if AutoUnbanConnection then
                AutoUnbanConnection:Disconnect()
                AutoUnbanConnection = nil
            end
            Rayfield:Notify({
                Title = "Auto Unban",
                Content = "Desativado!",
                Duration = 5,
                Image = 4483362458
            })
        end
    end
})

-- =========================
-- ABA TOOLS
-- =========================
local ToolsTab = Window:CreateTab("Tools", 4483362458)
ToolsTab:CreateLabel("Essas funções ainda estão sendo desenvolvidas!")

-- =========================
-- ESP
-- =========================
local ESPTab = Window:CreateTab("ESP", 4483362458)

local ESPEnabled = false
local ESPBoxes = {}
local ESPConnections = {}

ESPTab:CreateSection("ESP Players")
ESPTab:CreateToggle({
    Name = "Ativar ESP",
    CurrentValue = false,
    Callback = function(Value)
        ESPEnabled = Value
        for _, gui in pairs(ESPBoxes
            ) do
            gui:Destroy()
        end
        ESPBoxes = {}
        for _, conn in pairs(ESPConnections) do
            conn:Disconnect()
        end
        ESPConnections = {}
        if ESPEnabled then
            local function AddESP(p)
                if p == game.Players.LocalPlayer then return end
                if not p.Character or not p.Character:FindFirstChild("HumanoidRootPart") then return end
                local bill = Instance.new("BillboardGui")
                bill.Name = "ESP"
                bill.Adornee = p.Character.HumanoidRootPart
                bill.Size = UDim2.new(0,100,0,50)
                bill.AlwaysOnTop = true
                bill.Parent = p.Character
                local text = Instance.new("TextLabel")
                text.Size = UDim2.new(1,0,1,0)
                text.BackgroundTransparency = 1
                text.TextColor3 = Color3.fromRGB(255,0,0)
                text.TextStrokeTransparency = 0
                text.TextScaled = true
                text.Text = p.Name
                text.Parent = bill
                ESPBoxes[p] = bill
            end
            for _, p in pairs(game.Players:GetPlayers()) do
                AddESP(p)
            end
            local conn = game.Players.PlayerAdded:Connect(AddESP)
            table.insert(ESPConnections, conn)
        end
    end
})

-- =========================
-- ABA VISUAL
-- =========================
local VisualTab = Window:CreateTab("Visual", 4483362458)

VisualTab:CreateSection("Funções visuais")
VisualTab:CreateLabel({
    Name = "Em breve..."
})

-- =========================
-- ABA CONFIG
-- =========================
local ConfigTab = Window:CreateTab("Configurações", 4483362458)

ConfigTab:CreateDropdown({
    Name = "Idioma",
    Options = {"English", "Português", "Español"},
    CurrentOption = {"Português"},
    MultipleOptions = false,
    Callback = function(Option)
        Rayfield:Notify({
            Title = "Idioma",
            Content = "Mudança de idioma ainda não implementada nesta versão!",
            Duration = 5,
            Image = 4483362458
        })
    end
})

-- =========================
-- FIM DO SCRIPT
-- =========================
Rayfield:Notify({
    Title = "Moon Hub",
    Content = "Script carregado com sucesso!",
    Duration = 5,
    Image = 4483362458
})