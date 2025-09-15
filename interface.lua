-- Rael Hub completo - Parte 1/3
-- LocalScript no StarterGui

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- Variáveis de toggle
local infJump = false
local noclip = false
local fullbring = false
local espEnabled = false
local espBoxes = {}

-- === GUI ===
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "RaelHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 500, 0, 350)
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -175)
MainFrame.BackgroundColor3 = Color3.fromRGB(30,30,30)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ClipsDescendants = true

-- Fade-in
TweenService:Create(MainFrame, TweenInfo.new(0.5), {BackgroundTransparency = 0}):Play()

-- Title
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1,0,0,50)
Title.BackgroundColor3 = Color3.fromRGB(45,45,45)
Title.BorderSizePixel = 0
Title.Text = "Rael Hub"
Title.TextColor3 = Color3.fromRGB(255,255,255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 24
Title.Parent = MainFrame

-- Botão Fechar
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0,30,0,30)
CloseBtn.Position = UDim2.new(1,-35,0,10)
CloseBtn.BackgroundColor3 = Color3.fromRGB(200,50,50)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255,255,255)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 18
CloseBtn.Parent = MainFrame
CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Botão Minimizar
local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Size = UDim2.new(0,30,0,30)
MinimizeBtn.Position = UDim2.new(1,-70,0,10)
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(150,150,150)
MinimizeBtn.Text = "_"
MinimizeBtn.TextColor3 = Color3.fromRGB(255,255,255)
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.TextSize = 18
MinimizeBtn.Parent = MainFrame

local minimized = false
MinimizeBtn.MouseButton1Click:Connect(function()
    if minimized then
        TweenService:Create(MainFrame,TweenInfo.new(0.3),{Size=UDim2.new(0,500,0,350)}):Play()
        minimized = false
    else
        TweenService:Create(MainFrame,TweenInfo.new(0.3),{Size=UDim2.new(0,500,0,50)}):Play()
        minimized = true
    end
end)

-- Categorias
local CategoryFrame = Instance.new("Frame")
CategoryFrame.Size = UDim2.new(0,150,1,-50)
CategoryFrame.Position = UDim2.new(0,0,0,50)
CategoryFrame.BackgroundColor3 = Color3.fromRGB(35,35,35)
CategoryFrame.BorderSizePixel = 0
CategoryFrame.Parent = MainFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Parent = CategoryFrame
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0,5)

-- Conteúdo
local ContentFrame = Instance.new("ScrollingFrame")
ContentFrame.Size = UDim2.new(1,-150,1,-50)
ContentFrame.Position = UDim2.new(0,150,0,50)
ContentFrame.BackgroundColor3 = Color3.fromRGB(40,40,40)
ContentFrame.BorderSizePixel = 0
ContentFrame.ScrollBarThickness = 5
ContentFrame.CanvasSize = UDim2.new(0,0,0,0)
ContentFrame.Parent = MainFrame

local ContentLayout = Instance.new("UIListLayout")
ContentLayout.Parent = ContentFrame
ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
ContentLayout.Padding = UDim.new(0,5)

-- Funções auxiliares
local function addHover(button)
    local normal = button.BackgroundColor3
    local hover = Color3.fromRGB(70,70,70)
    button.MouseEnter:Connect(function()
        TweenService:Create(button,TweenInfo.new(0.2),{BackgroundColor3=hover}):Play()
    end)
    button.MouseLeave:Connect(function()
        TweenService:Create(button,TweenInfo.new(0.2),{BackgroundColor3=normal}):Play()
    end)
end

local function clearContent()
    for _,v in pairs(ContentFrame:GetChildren()) do
        if v:IsA("GuiObject") then v:Destroy() end
    end
end

local function createButton(name,callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1,-10,0,40)
    btn.Position = UDim2.new(0,5,0,0)
    btn.BackgroundColor3 = Color3.fromRGB(60,60,60)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 16
    btn.Parent = ContentFrame
    addHover(btn)
    btn.MouseButton1Click:Connect(callback)
end

local function updateCanvas()
    ContentFrame.CanvasSize = UDim2.new(0,0,0,ContentLayout.AbsoluteContentSize.Y+10)
end

-- Rael Hub completo - Parte 2/3
-- Criação das categorias e botões

local Categories = {"Player","Fun","Teleport","ESP"}

for _,cat in ipairs(Categories) do
    local catBtn = Instance.new("TextButton")
    catBtn.Size = UDim2.new(1,-10,0,40)
    catBtn.Text = cat
    catBtn.BackgroundColor3 = Color3.fromRGB(50,50,50)
    catBtn.TextColor3 = Color3.fromRGB(255,255,255)
    catBtn.Font = Enum.Font.GothamBold
    catBtn.TextSize = 18
    catBtn.Parent = CategoryFrame
    addHover(catBtn)

    catBtn.MouseButton1Click:Connect(function()
        clearContent()

        if cat == "Player" then
            -- Infinity Jump
            createButton("Infinity Jump",function()
                infJump = not infJump
                print("Infinity Jump: "..tostring(infJump))
            end)

            -- Noclip
            createButton("Noclip",function()
                noclip = not noclip
                print("Noclip: "..tostring(noclip))
            end)

            -- Set Speed
            createButton("Set Speed",function()
                local inputBox = Instance.new("TextBox")
                inputBox.Size = UDim2.new(1,-20,0,30)
                inputBox.Position = UDim2.new(0,10,0,0)
                inputBox.PlaceholderText = "Digite a velocidade"
                inputBox.TextColor3 = Color3.fromRGB(255,255,255)
                inputBox.BackgroundColor3 = Color3.fromRGB(70,70,70)
                inputBox.Font = Enum.Font.Gotham
                inputBox.TextSize = 16
                inputBox.Parent = ContentFrame
                inputBox.FocusLost:Connect(function(enter)
                    if enter then
                        local speed = tonumber(inputBox.Text)
                        if speed and Player.Character and Player.Character:FindFirstChildOfClass("Humanoid") then
                            Player.Character.Humanoid.WalkSpeed = speed
                            print("Velocidade setada: "..speed)
                        end
                        inputBox:Destroy()
                        updateCanvas()
                    end
                end)
                updateCanvas()
            end)

        elseif cat == "Fun" then
            createButton("Fullbring",function()
                fullbring = not fullbring
                print("Fullbring: "..tostring(fullbring))
            end)

        elseif cat == "Teleport" then
            createButton("Teleport por Nick",function()
                local inputBox = Instance.new("TextBox")
                inputBox.Size = UDim2.new(1,-20,0,30)
                inputBox.Position = UDim2.new(0,10,0,0)
                inputBox.PlaceholderText = "Digite o Nick"
                inputBox.TextColor3 = Color3.fromRGB(255,255,255)
                inputBox.BackgroundColor3 = Color3.fromRGB(70,70,70)
                inputBox.Font = Enum.Font.Gotham
                inputBox.TextSize = 16
                inputBox.Parent = ContentFrame
                inputBox.FocusLost:Connect(function(enter)
                    if enter then
                        local target = Players:FindFirstChild(inputBox.Text)
                        if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
                            Player.Character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame
                            print("Teleportado para "..target.Name)
                        else
                            print("Jogador não encontrado")
                        end
                        inputBox:Destroy()
                        updateCanvas()
                    end
                end)
                updateCanvas()
            end)

        elseif cat == "ESP" then
            createButton("ESP Players",function()
                espEnabled = not espEnabled
                print("ESP: "..tostring(espEnabled))
            end)
        end

        updateCanvas()
    end)
end-- Rael Hub completo - Parte 3/3 (corrigida)

-- Infinity Jump seguro
UserInputService.JumpRequest:Connect(function()
    local humanoid = Player.Character and Player.Character:FindFirstChildOfClass("Humanoid")
    if infJump and humanoid then
        humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

-- Noclip
RunService.Stepped:Connect(function()
    if noclip and Player.Character then
        for _, part in pairs(Player.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)

-- Fullbring (apenas cliente)
RunService.RenderStepped:Connect(function()
    if fullbring then
        for _, obj in pairs(Workspace:GetDescendants()) do
            if obj:IsA("BasePart") then
                obj.Color = Color3.fromRGB(255, 255, 255)
                obj.Material = Enum.Material.Neon
            end
        end
    end
end)

-- ESP Players
RunService.RenderStepped:Connect(function()
    if not espEnabled then
        -- Remove ESP
        for plr, box in pairs(espBoxes) do
            if box and box.Parent then
                box:Destroy()
            end
            espBoxes[plr] = nil
        end
    else
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= Player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                if not espBoxes[plr] then
                    local box = Instance.new("BillboardGui")
                    box.Adornee = plr.Character.HumanoidRootPart
                    box.Size = UDim2.new(0, 50, 0, 50)
                    box.AlwaysOnTop = true
                    box.Parent = PlayerGui

                    local frame = Instance.new("Frame")
                    frame.Size = UDim2.new(1, 0, 1, 0)
                    frame.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
                    frame.BorderSizePixel = 2
                    frame.BackgroundTransparency = 0.5
                    frame.Parent = box

                    espBoxes[plr] = box
                end
            elseif espBoxes[plr] then
                espBoxes[plr]:Destroy()
                espBoxes[plr] = nil
            end
        end
    end
end)

-- msg de boas vindas!
local LocalPlayer = game.Players.LocalPlayer
print("Seja bem vindo ao Talos Hub!" .. LocalPlayer.Name)

-- Verificação
local msg = "🇧🇷 Talos Hub foi executado"
local Gui = game.StarterGui
local Principal = Gui:FindFirstChild("TalosHub")

if Principal then
    local Esperar = Principal:WaitForChild("Esperar")
    print("O script " .. msg)
else
    print("O seu script não foi executado! Verifique com o suporte")
end