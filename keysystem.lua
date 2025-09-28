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

local URL =
"https://raw.githubusercontent.com/thalles781/HUB-teste/refs/heads/main/mainbrookhaven.lua" -- <<--- troca aqui

local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- Cria ScreenGui/Frame simples e responsivo
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MoonHub_KeySystem"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 360, 0, 160)
frame.Position = UDim2.new(0.5, -180, 0.5, -80)
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.BorderSizePixel = 0
frame.Parent = screenGui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 36)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundTransparency = 1
title.Text = "Moon Hub x Key System"
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

local btn = Instance.new("TextButton")
btn.Size = UDim2.new(1, -40, 0, 34)
btn.Position = UDim2.new(0, 20, 0, 96)
btn.Text = "Verificar Key"
btn.BackgroundColor3 = Color3.fromRGB(70,70,70)
btn.TextColor3 = Color3.fromRGB(255,255,255)
btn.Font = Enum.Font.GothamSemibold
btn.TextSize = 16
btn.Parent = frame

-- Função que valida a key
local function isValidKey(k)
    for _, v in pairs(Keys) do
        if v == k then return true end
    end
    return false
end

-- Comportamento ao clicar
btn.MouseButton1Click:Connect(function()
    local key = tostring(input.Text):gsub("%s+", "") -- tira espaços redundantes
    if key == "" then
        status.Text = "Digite uma key antes."
        status.TextColor3 = Color3.fromRGB(255,180,0)
        return
    end

    if isValidKey(key) then
        -- Sucesso: some a UI e carrega o hub
        status.Text = "✔️ Key correta! Carregando hub..."
        status.TextColor3 = Color3.fromRGB(0,220,0)

        -- efeito visual opcional antes de remover
        for i = 1, 8 do
            frame.BackgroundTransparency = i / 8
            wait(0.02)
        end

        -- Remove a interface de key
        pcall(function() screenGui:Destroy() end)

        -- Carrega o Rayfield/hub do link (versão 2)
        local ok, err = pcall(function()
            local s = game:HttpGet(HubURL)
            local f = loadstring(s)
            f()
        end)

        if not ok then
            -- Se falhar ao puxar/rodar o hub, mostra mensagem no chat e (opcional) recria a tela
            warn("Falha ao carregar hub: "..tostring(err))
            -- opcional: criar uma notificação do erro para o jogador
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