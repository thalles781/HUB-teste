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
-- ABA DE CRÉDITOS (primeira)
-- =========================
local CreditsTab = Window:CreateTab("Credits", 4483362458)

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
-- ABA LOCALPLAYER (segunda)
-- =========================
local LocalPlayerTab = Window:CreateTab("LocalPlayer", 4483362458)

-- Speed
LocalPlayerTab:CreateInput({
    Name = "Speed",
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
    Name = "Infinity Jump",
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

-- Fullbring
local FullbringEnabled = false
LocalPlayerTab:CreateToggle({
    Name = "Fullbring",
    CurrentValue = false,
    Callback = function(Value)
        FullbringEnabled = Value
        local player = game.Players.LocalPlayer
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            if Value then
                player.Character.Humanoid.WalkSpeed = 30
                player.Character.Humanoid.JumpPower = 70
                if not player.Character:FindFirstChild("FullbringEffect") then
                    local effect = Instance.new("ParticleEmitter")
                    effect.Name = "FullbringEffect"
                    effect.Parent = player.Character.HumanoidRootPart
                    effect.Rate = 50
                    effect.Lifetime = NumberRange.new(0.5)
                    effect.Speed = NumberRange.new(5)
                end
            else
                player.Character.Humanoid.WalkSpeed = 16
                player.Character.Humanoid.JumpPower = 50
                if player.Character:FindFirstChild("HumanoidRootPart") and player.Character.HumanoidRootPart:FindFirstChild("FullbringEffect") then
                    player.Character.HumanoidRootPart.FullbringEffect:Destroy()
                end
            end
        end
    end
})

-- Fly
local FlyEnabled = false
local FlySpeed = 50
local FlyBodyVelocity
local FlyConnection

LocalPlayerTab:CreateToggle({
    Name = "Fly (PC & Mobile)",
    CurrentValue = false,
    Callback = function(Value)
        local player = game.Players.LocalPlayer
        local char = player.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        local cam = workspace.CurrentCamera
        if not hrp then return end

        FlyEnabled = Value

        if FlyEnabled then
            FlyBodyVelocity = Instance.new("BodyVelocity")
            FlyBodyVelocity.MaxForce = Vector3.new(1e5,1e5,1e5)
            FlyBodyVelocity.Velocity = Vector3.new(0,0,0)
            FlyBodyVelocity.Parent = hrp

            FlyConnection = game:GetService("RunService").RenderStepped:Connect(function()
                if not FlyEnabled then return end
                local dir = Vector3.new(0,0,0)
                local UIS = game:GetService("UserInputService")
                if UIS:IsKeyDown(Enum.KeyCode.W) then dir = dir + cam.CFrame.LookVector end
                if UIS:IsKeyDown(Enum.KeyCode.S) then dir = dir - cam.CFrame.LookVector end
                if UIS:IsKeyDown(Enum.KeyCode.A) then dir = dir - cam.CFrame.RightVector end
                if UIS:IsKeyDown(Enum.KeyCode.D) then dir = dir + cam.CFrame.RightVector end
                if UIS:IsKeyDown(Enum.KeyCode.Space) then dir = dir + Vector3.new(0,1,0) end
                if UIS:IsKeyDown(Enum.KeyCode.LeftShift) then dir = dir - Vector3.new(0,1,0) end

                if dir.Magnitude > 0 then
                    FlyBodyVelocity.Velocity = dir.Unit * FlySpeed
                else
                    FlyBodyVelocity.Velocity = Vector3.new(0,0,0)
                end
            end)
        else
            if FlyConnection then FlyConnection:Disconnect() end
            if FlyBodyVelocity then FlyBodyVelocity:Destroy() end
        end
    end
})

-- =========================
-- ABA TELEPORT
-- =========================
local TeleportTab = Window:CreateTab("Teleport", 4483362458)

-- Teleporte por Nick
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

local LugarSelecionado = "Praça" -- já começa como Praça

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
-- ESP (sem alteração)
-- =========================
local ESPTab = Window:CreateTab("ESP", 4483362458)

local ESPEnabled = false
local ESPBoxes = {}
local ESPConnections = {}

ESPTab:CreateToggle({
    Name = "Ativar ESP",
    CurrentValue = false,
    Callback = function(Value)
        ESPEnabled = Value
        for _, gui in pairs(ESPBoxes) do
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
-- SISTEMA DE TRADUÇÃO
-- =========================
local IdiomaAtual = "en"

local Traducoes = {
    ["en"] = {
        Credits = "Credits",
        LocalPlayer = "LocalPlayer",
        Teleport = "Teleport",
        Spect = "Spect",
        Casa = "House",
        Tools = "Tools",
        ESP = "ESP",
        Visual = "Visual",
        Config = "Settings",

        -- Créditos
        Credit1 = "Made by: thalles456u",
        Credit2 = "UI by: Rayfield",
        Credit3 = "Any questions? Join our Discord! Click below!",

        DiscordBtn = "Click here to copy the Discord link!",

        -- LocalPlayer
        Speed = "Speed",
        InfJump = "Infinity Jump",
        Noclip = "Noclip",
        Fullbring = "Fullbring",
        Fly = "Fly (PC & Mobile)",

        -- Teleport
        TeleportPlayers = "Teleport Players",
        TeleportNick = "Teleport by Nick",
        FixedPlaces = "Fixed Places",
        ChoosePlace = "Choose the place",
        TeleportBtn = "Teleport",
        TeleportNotify = "No place selected!",

        -- Spect
        SpectNick = "Spectate by Nick",

        -- Casa
        UnbanAll = "Unban All",
        AutoUnban = "Auto Unban",

        -- Tools
        ToolsMsg = "These functions are still being developed!",

        -- ESP
        EspToggle = "Enable ESP",

        -- Visual
        VisualSection = "Visual functions",
        Soon = "Coming soon...",

        -- Config
        Language = "Language"
    },
    ["pt"] = {
        Credits = "Créditos",
        LocalPlayer = "LocalPlayer",
        Teleport = "Teleportar",
        Spect = "Espectar",
        Casa = "Casa",
        Tools = "Ferramentas",
        ESP = "ESP",
        Visual = "Visual",
        Config = "Configurações",

        -- Créditos
        Credit1 = "Feito por: thalles456u",
        Credit2 = "Interface por: Rayfield",
        Credit3 = "Alguma dúvida? Entre no nosso discord! Apenas clique abaixo!",

        DiscordBtn = "Clique aqui para copiar o link do Discord!",

        -- LocalPlayer
        Speed = "Velocidade",
        InfJump = "Pulo Infinito",
        Noclip = "Noclip",
        Fullbring = "Fullbring",
        Fly = "Voar (PC & Mobile)",

        -- Teleport
        TeleportPlayers = "Teleportar Jogadores",
        TeleportNick = "Teleporte por Nick",
        FixedPlaces = "Lugares Fixos",
        ChoosePlace = "Escolha o lugar",
        TeleportBtn = "Teleportar",
        TeleportNotify = "Nenhum lugar selecionado!",

        -- Spect
        SpectNick = "Espectar por Nick",

        -- Casa
        UnbanAll = "Desbanir Todos",
        AutoUnban = "Auto Unban",

        -- Tools
        ToolsMsg = "Essas funções ainda estão sendo desenvolvidas!",

        -- ESP
        EspToggle = "Ativar ESP",

        -- Visual
        VisualSection = "Funções visuais",
        Soon = "Em breve...",

        -- Config
        Language = "Idioma"
    },
    ["es"] = {
        Credits = "Créditos",
        LocalPlayer = "Jugador Local",
        Teleport = "Teletransporte",
        Spect = "Espectar",
        Casa = "Casa",
        Tools = "Herramientas",
        ESP = "ESP",
        Visual = "Visual",
        Config = "Configuración",

        -- Créditos
        Credit1 = "Hecho por: thalles456u",
        Credit2 = "Interfaz por: Rayfield",
        Credit3 = "¿Dudas? Únete a nuestro Discord! Haz clic abajo!",

        DiscordBtn = "Haz clic aquí para copiar el link de Discord!",

        -- LocalPlayer
        Speed = "Velocidad",
        InfJump = "Salto Infinito",
        Noclip = "Noclip",
        Fullbring = "Fullbring",
        Fly = "Volar (PC & Móvil)",

        -- Teleport
        TeleportPlayers = "Teletransportar Jugadores",
        TeleportNick = "Teletransporte por Nick",
        FixedPlaces = "Lugares Fijos",
        ChoosePlace = "Elige el lugar",
        TeleportBtn = "Teletransportar",
        TeleportNotify = "¡Ningún lugar seleccionado!",

        -- Spect
        SpectNick = "Espectar por Nick",

        -- Casa
        UnbanAll = "Desbanear Todos",
        AutoUnban = "Auto Unban",

        -- Tools
        ToolsMsg = "¡Estas funciones aún están en desarrollo!",

        -- ESP
        EspToggle = "Activar ESP",

        -- Visual
        VisualSection = "Funciones visuales",
        Soon = "Próximamente...",

        -- Config
        Language = "Idioma"
    }
}

-- =========================
-- FUNÇÃO DE TRADUZIR
-- =========================
local function T(chave)
    return Traducoes[IdiomaAtual][chave] or chave
end

-- =========================
-- ABA DE CONFIG
-- =========================
local ConfigTab = Window:CreateTab(T("Config"), 4483362458)

ConfigTab:CreateDropdown({
    Name = T("Language"),
    Options = {"English", "Português", "Español"},
    CurrentOption = {"English"},
    MultipleOptions = false,
    Callback = function(Option)
        if Option[1] == "English" then
            IdiomaAtual = "en"
        elseif Option[1] == "Português" then
            IdiomaAtual = "pt"
        elseif Option[1] == "Español" then
            IdiomaAtual = "es"
        end
        Rayfield:Notify({
            Title = "Language",
            Content = "Idioma alterado para: " .. Option[1],
            Duration = 5,
            Image = 4483362458
        })
        -- Aqui você pode futuramente recriar as abas e textos já traduzidos
    end
})