-- Key system Moon Hub Brookhaven
local Keys = {
    "L2C8-BJ8N-XAS7",
    "K9D3-MQ7Z-T4L2",
    "R8F6-V1XK-P0Z3",
    "H3Y9-CA4M-N7Q8",
    "W2Z5-JL8R-K6T1",
    "M7P2-QX9D-F4G5",
    "T1N6-BV3Y-Z8H4",
    "C5X8-L0P3-R9K7",
    "D9J2-KF5L-H8R0",
    "Z4M1-GT7Q-V2S6"
}

local URL = "https://raw.githubusercontent.com/thalles781/HUB-teste/refs/heads/main/Troll.lua" -- HUB

local GetKeyURL = "https://iusanh.mimo.run/index.html" -- <<--- link para pegar a key

local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- Cria ScreenGui/Frame simples e responsivo
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MoonHub_KeySystem"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 360, 0, 180)
frame.Position = UDim2.new(0.5, -180, 0.5, -90)
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.BorderSizePixel = 0
frame.Parent = screenGui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 36)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundTransparency = 1
title.Text = "OP Hub x Key System"
title.TextColor3 = Color3.fromRGB(255,255,255)
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.Parent = frame

local input = Instance.new("TextBox")
input.Size = UDim2.new(1, -40, 0, 36)
input.Position = UDim2.new(0, 20, 0, 48)
input.PlaceholderText = "Digite sua key aqui (ex: key1234)"
input.ClearTextOnFocus = false
input.BackgroundColor3 = Color3.fromRGB(40,40,40)
input.TextColor3 = Color3.fromRGB(255,255,255)
input.Font = Enum.Font.Gotham
input.TextSize = 16
input.Parent = frame

local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, -40, 0, 28)
status.Position = UDim2.new(0, 20, 1, -48)
status.BackgroundTransparency = 1
status.Text = "Aguardando key..."
status.TextColor3 = Color3.fromRGB(200,200,200)
status.TextXAlignment = Enum.TextXAlignment.Left
status.Font = Enum.Font.Gotham
status.TextSize = 14
status.Parent = frame

-- Botão Verificar Key
local btnVerify = Instance.new("TextButton")
btnVerify.Size = UDim2.new(0.5, -30, 0, 34)
btnVerify.Position = UDim2.new(0, 20, 0, 96)
btnVerify.Text = "Verificar Key"
btnVerify.BackgroundColor3 = Color3.fromRGB(70,70,70)
btnVerify.TextColor3 = Color3.fromRGB(255,255,255)
btnVerify.Font = Enum.Font.GothamSemibold
btnVerify.TextSize = 16
btnVerify.Parent = frame

-- Botão Get Key
local btnGet = Instance.new("TextButton")
btnGet.Size = UDim2.new(0.5, -30, 0, 34)
btnGet.Position = UDim2.new(0.5, 10, 0, 96)
btnGet.Text = "Get Key"
btnGet.BackgroundColor3 = Color3.fromRGB(45,120,200)
btnGet.TextColor3 = Color3.fromRGB(255,255,255)
btnGet.Font = Enum.Font.GothamSemibold
btnGet.TextSize = 16
btnGet.Parent = frame

-- Função que valida a key
local function isValidKey(k)
    for _, v in pairs(Keys) do
        if v == k then return true end
    end
    return false
end

-- Botão Verificar Key
btnVerify.MouseButton1Click:Connect(function()
    local key = tostring(input.Text):gsub("%s+", "")
    if key == "" then
        status.Text = "Digite uma key antes."
        status.TextColor3 = Color3.fromRGB(255,180,0)
        return
    end

    if isValidKey(key) then
        status.Text = "✔️ Key correta! Carregando hub..."
        status.TextColor3 = Color3.fromRGB(0,220,0)

        for i = 1, 8 do
            frame.BackgroundTransparency = i / 8
            wait(0.02)
        end

        pcall(function() screenGui:Destroy() end)

        local ok, err = pcall(function()
            local s = game:HttpGet(URL)
            local f = loadstring(s)
            f()
        end)

        if not ok then
            warn("Falha ao carregar hub: "..tostring(err))
            local StarterGui = game:GetService("StarterGui")
            pcall(function()
                StarterGui:SetCore("SendNotification", {
                    Title = "Moon Hub",
                    Text = "Erro ao carregar hub: "..tostring(err),
                    Duration = 6
                })
            end)
        end
    else
        status.Text = "❌ Key inválida!"
        status.TextColor3 = Color3.fromRGB(255,60,60)
    end
end)

-- Botão Get Key (abre o site)
btnGet.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard(GetKeyURL)
        status.Text = "🔗 Link copiado! Cole no navegador."
        status.TextColor3 = Color3.fromRGB(0,180,255)
    else
        status.Text = "Não foi possível copiar, abra: "..GetKeyURL
        status.TextColor3 = Color3.fromRGB(255,180,0)
    end
end)