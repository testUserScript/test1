-- Parent seguro pro Delta / Synapse
local guiParent = (gethui and gethui()) or game.CoreGui

-- Criar ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SpeedChanger"
ScreenGui.Parent = guiParent

-- Frame principal
local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 250, 0, 130)
Frame.Position = UDim2.new(0.4, 0, 0.3, 0)
Frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Frame.Active = true
Frame.Draggable = true
Frame.Parent = ScreenGui

-- Título
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Text = "Speed GUI gostoso"
Title.TextColor3 = Color3.fromRGB(255,255,255)
Title.BackgroundColor3 = Color3.fromRGB(20,20,20)
Title.Parent = Frame

-- Botão fechar
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

-- Label de velocidade
local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Size = UDim2.new(1, 0, 0, 30)
SpeedLabel.Position = UDim2.new(0, 0, 0.3, 0)
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

-- Função para aplicar WalkSpeed
local player = game.Players.LocalPlayer

local function applySpeed(char)
    local humanoid = char:WaitForChild("Humanoid")
    local speed = tonumber(SpeedBox.Text) or 16
    humanoid.WalkSpeed = speed
    SpeedLabel.Text = "Velocidade atual: " .. speed
end

-- Aplica no personagem atual se já existir
if player.Character then
    applySpeed(player.Character)
end

-- Aplica sempre que respawnar
player.CharacterAdded:Connect(applySpeed)

-- Quando digitar valor e apertar Enter
SpeedBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        local newSpeed = tonumber(SpeedBox.Text)
        if newSpeed then
            if player.Character then
                applySpeed(player.Character)
            end
        else
            SpeedLabel.Text = "Digite um número válido!"
        end
    end
end)
