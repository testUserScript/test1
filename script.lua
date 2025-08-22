
-- Criar ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SpeedChanger"
ScreenGui.Parent = guiParent

-- Criar Frame principal
local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 250, 0, 120)
Frame.Position = UDim2.new(0.4, 0, 0.3, 0)
Frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Frame.Active = true
Frame.Draggable = true -- arrastável
Frame.Parent = ScreenGui

-- Título
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Text = "Speed GUI"
Title.TextColor3 = Color3.fromRGB(255,255,255)
Title.BackgroundColor3 = Color3.fromRGB(20,20,20)
Title.Parent = Frame

-- Botão X (fechar)
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -30, 0, 0)
CloseBtn.Text = "X"
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseBtn.TextColor3 = Color3.fromRGB(255,255,255)
CloseBtn.Parent = Frame
CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Texto com velocidade atual
local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Size = UDim2.new(1, 0, 0, 30)
SpeedLabel.Position = UDim2.new(0,0,0.3,0)
SpeedLabel.Text = "Velocidade atual: 16"
SpeedLabel.TextColor3 = Color3.fromRGB(255,255,255)
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Parent = Frame

-- Caixa de texto para alterar velocidade
local SpeedBox = Instance.new("TextBox")
SpeedBox.Size = UDim2.new(0.6, 0, 0, 30)
SpeedBox.Position = UDim2.new(0.2, 0, 0.65, 0)
SpeedBox.PlaceholderText = "Digite a velocidade..."
SpeedBox.Text = ""
SpeedBox.TextColor3 = Color3.fromRGB(0,0,0)
SpeedBox.BackgroundColor3 = Color3.fromRGB(200,200,200)
SpeedBox.Parent = Frame

-- Função para mudar WalkSpeed
local function setSpeed(value)
    local player = game.Players.LocalPlayer
    local char = player.Character or player.CharacterAdded:Wait()
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid.WalkSpeed = value
        SpeedLabel.Text = "Velocidade atual: " .. value
    end
end

local player = game.Players.LocalPlayer

local function applySpeed(char)
    local Humanoid = char:WaitForChild("Humanoid")
    local speed = tonumber(SpeedBox)
    Humanoid.WalkSpeed = speed
end
if player.Character then
     applySpeed(player.Character)
end

player.CharacterAdded:Connect(applySpeed)

-- Quando digitar valor e apertar Enter
SpeedBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        local newSpeed = tonumber(SpeedBox.Text)
        if newSpeed then
            setSpeed(newSpeed)
        else
            SpeedLabel.Text = "Digite um número válido!"
        end
    end
end)
