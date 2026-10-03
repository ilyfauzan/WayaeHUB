local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local parentUI = CoreGui
if RunService:IsStudio() then
    parentUI = Players.LocalPlayer:WaitForChild("PlayerGui")
else
    local success = pcall(function() return CoreGui.Name end)
    if not success then parentUI = Players.LocalPlayer:WaitForChild("PlayerGui") end
end

if parentUI:FindFirstChild("WayaeHUB_UI") then
    parentUI.WayaeHUB_UI:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "WayaeHUB_UI"
ScreenGui.Parent = parentUI
ScreenGui.ResetOnSpawn = false

local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Name = "ToggleBtn"
ToggleBtn.Size = UDim2.new(0, 50, 0, 50)
ToggleBtn.Position = UDim2.new(0, 15, 0.5, -25)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.Text = "W"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.Font = Enum.Font.GothamBlack
ToggleBtn.TextSize = 24
ToggleBtn.Draggable = true
ToggleBtn.Parent = ScreenGui

local UICorner_Toggle = Instance.new("UICorner")
UICorner_Toggle.CornerRadius = UDim.new(1, 0)
UICorner_Toggle.Parent = ToggleBtn

local UIGradient_Toggle = Instance.new("UIGradient")
UIGradient_Toggle.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)),
    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(15, 15, 15))
}
UIGradient_Toggle.Rotation = 45
UIGradient_Toggle.Parent = ToggleBtn

local UIStroke_Text = Instance.new("UIStroke")
UIStroke_Text.Color = Color3.fromRGB(0, 0, 0)
UIStroke_Text.Thickness = 1.5
UIStroke_Text.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual
UIStroke_Text.Parent = ToggleBtn

local UIStroke_Toggle = Instance.new("UIStroke")
UIStroke_Toggle.Color = Color3.fromRGB(255, 255, 255)
UIStroke_Toggle.Thickness = 2
UIStroke_Toggle.Transparency = 0.6
UIStroke_Toggle.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke_Toggle.Parent = ToggleBtn

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 500, 0, 300)
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -150)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local UICorner_Main = Instance.new("UICorner")
UICorner_Main.CornerRadius = UDim.new(0, 8)
UICorner_Main.Parent = MainFrame

local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Size = UDim2.new(1, 0, 0, 35)
TopBar.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame

local UICorner_Top = Instance.new("UICorner")
UICorner_Top.CornerRadius = UDim.new(0, 8)
UICorner_Top.Parent = TopBar

local TopBarHider = Instance.new("Frame")
TopBarHider.Size = UDim2.new(1, 0, 0, 8)
TopBarHider.Position = UDim2.new(0, 0, 1, -8)
TopBarHider.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
TopBarHider.BorderSizePixel = 0
TopBarHider.Parent = TopBar

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -15, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "WayaeHUB"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TopBar

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 35, 0, 35)
CloseBtn.Position = UDim2.new(1, -35, 0, 0)
CloseBtn.BackgroundTransparency = 1
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(200, 50, 50)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 16
CloseBtn.Parent = TopBar

CloseBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
end)

ToggleBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

local Sidebar = Instance.new("Frame")
Sidebar.Name = "Sidebar"
Sidebar.Size = UDim2.new(0, 130, 1, -35)
Sidebar.Position = UDim2.new(0, 0, 0, 35)
Sidebar.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
Sidebar.BorderSizePixel = 0
Sidebar.Parent = MainFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Parent = Sidebar
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 5)

local UIPadding = Instance.new("UIPadding")
UIPadding.PaddingTop = UDim.new(0, 10)
UIPadding.PaddingLeft = UDim.new(0, 10)
UIPadding.PaddingRight = UDim.new(0, 10)
UIPadding.Parent = Sidebar

local ContentArea = Instance.new("Frame")
ContentArea.Name = "ContentArea"
ContentArea.Size = UDim2.new(1, -130, 1, -35)
ContentArea.Position = UDim2.new(0, 130, 0, 35)
ContentArea.BackgroundTransparency = 1
ContentArea.Parent = MainFrame

local Pages = {}

local function CreatePage(pageName)
    local PageFrame = Instance.new("Frame")
    PageFrame.Name = pageName
    PageFrame.Size = UDim2.new(1, 0, 1, 0)
    PageFrame.BackgroundTransparency = 1
    PageFrame.Visible = false
    PageFrame.Parent = ContentArea
    Pages[pageName] = PageFrame
    return PageFrame
end

local function CreateMenuButton(text, pageName)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1, 0, 0, 30)
    Btn.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    Btn.Text = text
    Btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    Btn.Font = Enum.Font.GothamSemibold
    Btn.TextSize = 13
    Btn.Parent = Sidebar

    local UICorner_Btn = Instance.new("UICorner")
    UICorner_Btn.CornerRadius = UDim.new(0, 6)
    UICorner_Btn.Parent = Btn

    Btn.MouseButton1Click:Connect(function()
        for _, page in pairs(Pages) do page.Visible = false end
        if Pages[pageName] then Pages[pageName].Visible = true end
        for _, otherBtn in ipairs(Sidebar:GetChildren()) do
            if otherBtn:IsA("TextButton") then
                otherBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
                otherBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
            end
        end
        Btn.BackgroundColor3 = Color3.fromRGB(70, 70, 220)
        Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    end)
    return Btn
end


local PageHome = CreatePage("HomePage")
local BtnHome = CreateMenuButton("Home", "HomePage")

local HomeLayout = Instance.new("UIListLayout")
HomeLayout.Parent = PageHome
HomeLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
HomeLayout.VerticalAlignment = Enum.VerticalAlignment.Center
HomeLayout.SortOrder = Enum.SortOrder.LayoutOrder
HomeLayout.Padding = UDim.new(0, 10)

local WelcomeTitle = Instance.new("TextLabel")
WelcomeTitle.Size = UDim2.new(1, 0, 0, 35)
WelcomeTitle.BackgroundTransparency = 1
WelcomeTitle.Text = "Welcome to WayaeHUB"
WelcomeTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
WelcomeTitle.Font = Enum.Font.GothamBlack
WelcomeTitle.TextSize = 24
WelcomeTitle.Parent = PageHome

local WelcomeSub = Instance.new("TextLabel")
WelcomeSub.Size = UDim2.new(0.9, 0, 0, 40)
WelcomeSub.BackgroundTransparency = 1
WelcomeSub.Text = "Silakan pilih menu di samping untuk mulai memodifikasi Emote, Unusual, atau Shader Anda secara kustom."
WelcomeSub.TextColor3 = Color3.fromRGB(180, 180, 190)
WelcomeSub.Font = Enum.Font.Gotham
WelcomeSub.TextSize = 13
WelcomeSub.TextWrapped = true
WelcomeSub.Parent = PageHome

local PageShader = Instance.new("ScrollingFrame")
PageShader.Name = "ShaderPage"
PageShader.Size = UDim2.new(1, 0, 1, 0)
PageShader.BackgroundTransparency = 1
PageShader.Visible = false
PageShader.ScrollBarThickness = 4
PageShader.CanvasSize = UDim2.new(0, 0, 0, 500)
PageShader.Parent = ContentArea
Pages["ShaderPage"] = PageShader

local BtnShader = CreateMenuButton("Shader", "ShaderPage")
local ShaderLayout = Instance.new("UIListLayout")
ShaderLayout.Parent = PageShader
ShaderLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
ShaderLayout.SortOrder = Enum.SortOrder.LayoutOrder
ShaderLayout.Padding = UDim.new(0, 8)

local ShaderPadding = Instance.new("UIPadding")
ShaderPadding.Parent = PageShader
ShaderPadding.PaddingTop = UDim.new(0, 10)

local LabelShader = Instance.new("TextLabel")
LabelShader.Size = UDim2.new(1, 0, 0, 30)
LabelShader.BackgroundTransparency = 1
LabelShader.Text = "Custom Shader"
LabelShader.TextColor3 = Color3.fromRGB(255, 255, 255)
LabelShader.Font = Enum.Font.GothamBold
LabelShader.TextSize = 18
LabelShader.Parent = PageShader

local function CreateShaderButton(text, shaderId, color)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.8, 0, 0, 32)
    btn.Text = text
    btn.BackgroundColor3 = color or Color3.fromRGB(50, 50, 60)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamSemibold
    btn.TextSize = 13
    btn.Parent = PageShader
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = btn
    
    btn.MouseButton1Click:Connect(function()
        local success, ShaderModule = pcall(function()
            return loadstring(game:HttpGet("https://raw.githubusercontent.com/ilyfauzan/WayaeHUB/main/ShaderManager.lua"))()
        end)
        
        if success and type(ShaderModule) == "table" and ShaderModule.Apply then
            ShaderModule.Apply(shaderId)
        else
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "ERROR", Text = "Gagal memuat ShaderManager!", Duration = 5
            })
        end
    end)
end

CreateShaderButton("🌅 Shader 1 (Golden Glow)", 1)
CreateShaderButton("🌙 Shader 2 (Midnight Velvet)", 2)
CreateShaderButton("🍂 Shader 3 (Melancholy)", 3)
CreateShaderButton("🔮 Shader 4 (Cyber Neon)", 4)
CreateShaderButton("🥶 Shader 5 (Winter Chill)", 5)
CreateShaderButton("🌿 Shader 6 (Toxic Wasteland)", 6)
CreateShaderButton("🎭 Shader 7 (Black & White)", 7)
CreateShaderButton("🔥 Shader 8 (Hellfire)", 8)
CreateShaderButton("☀️ Shader 9 (Desert Mirage)", 9)
CreateShaderButton("🌌 Shader 10 (Void Galaxy)", 10)
CreateShaderButton("💎 Shader 11 (Ultra Clear 8K)", 11)
CreateShaderButton("🎬 Shader 12 (Cinematic RTX)", 12)
CreateShaderButton("☁️ Shader 13 (Moody Overcast 8K)", 13)
CreateShaderButton("🌇 Shader 14 (Golden Hour Ultra)", 14)
CreateShaderButton("🌃 Shader 15 (Midnight 8K Neon)", 15)
CreateShaderButton("❌ Matikan Shader", 0, Color3.fromRGB(200, 50, 50))


local function CreateTextBox(parent, placeholder)
    local box = Instance.new("TextBox")
    box.Size = UDim2.new(0.9, 0, 0, 35)
    box.PlaceholderText = placeholder
    box.Text = ""
    box.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    box.TextColor3 = Color3.fromRGB(255, 255, 255)
    box.Font = Enum.Font.Gotham
    box.TextSize = 11
    box.TextXAlignment = Enum.TextXAlignment.Left
    box.Parent = parent
    local pad = Instance.new("UIPadding")
    pad.PaddingLeft = UDim.new(0, 10)
    pad.Parent = box
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = box
    return box
end

local PageEmote = CreatePage("EmotePage")
local BtnEmote = CreateMenuButton("Emote", "EmotePage")

local EmoteLayout = Instance.new("UIListLayout")
EmoteLayout.Parent = PageEmote
EmoteLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
EmoteLayout.SortOrder = Enum.SortOrder.LayoutOrder
EmoteLayout.Padding = UDim.new(0, 15)

local EmotePadding = Instance.new("UIPadding")
EmotePadding.Parent = PageEmote
EmotePadding.PaddingTop = UDim.new(0, 20)

local LabelEmote = Instance.new("TextLabel")
LabelEmote.Size = UDim2.new(1, 0, 0, 30)
LabelEmote.BackgroundTransparency = 1
LabelEmote.Text = "Custom Emote"
LabelEmote.TextColor3 = Color3.fromRGB(255, 255, 255)
LabelEmote.Font = Enum.Font.GothamBold
LabelEmote.TextSize = 18
LabelEmote.Parent = PageEmote

local InputTarget = CreateTextBox(PageEmote, "Emote Target (Cth: SwagWalk)")
local InputSource = CreateTextBox(PageEmote, "Emote Baru (Cth: Broom)")

local BtnExecuteSwap = Instance.new("TextButton")
BtnExecuteSwap.Size = UDim2.new(0.5, 0, 0, 40)
BtnExecuteSwap.Text = "Tukar Emote"
BtnExecuteSwap.BackgroundColor3 = Color3.fromRGB(70, 200, 70)
BtnExecuteSwap.TextColor3 = Color3.fromRGB(255, 255, 255)
BtnExecuteSwap.Font = Enum.Font.GothamBold
BtnExecuteSwap.TextSize = 14
BtnExecuteSwap.Parent = PageEmote
local CornerExecute = Instance.new("UICorner")
CornerExecute.CornerRadius = UDim.new(0, 6)
CornerExecute.Parent = BtnExecuteSwap

BtnExecuteSwap.MouseButton1Click:Connect(function()
    local targetName = InputTarget.Text
    local sourceName = InputSource.Text
    
    local success, EmoteModule = pcall(function()
        return loadstring(game:HttpGet("https://raw.githubusercontent.com/ilyfauzan/WayaeHUB/main/EmoteSwapper.lua"))()
    end)
    
    if success and type(EmoteModule) == "table" and EmoteModule.Swap then
        EmoteModule.Swap(targetName, sourceName)
    else
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "ERROR",
            Text = "Gagal memuat modul EmoteSwapper dari GitHub!",
            Duration = 5
        })
    end
end)


local PageUnusual = CreatePage("UnusualPage")
local BtnUnusual = CreateMenuButton("Unusual", "UnusualPage")

local UnusualLayout = Instance.new("UIListLayout")
UnusualLayout.Parent = PageUnusual
UnusualLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UnusualLayout.SortOrder = Enum.SortOrder.LayoutOrder
UnusualLayout.Padding = UDim.new(0, 15)

local UnusualPadding = Instance.new("UIPadding")
UnusualPadding.Parent = PageUnusual
UnusualPadding.PaddingTop = UDim.new(0, 20)

local LabelUnusual = Instance.new("TextLabel")
LabelUnusual.Size = UDim2.new(1, 0, 0, 30)
LabelUnusual.BackgroundTransparency = 1
LabelUnusual.Text = "Custom Unusual"
LabelUnusual.TextColor3 = Color3.fromRGB(255, 255, 255)
LabelUnusual.Font = Enum.Font.GothamBold
LabelUnusual.TextSize = 18
LabelUnusual.Parent = PageUnusual

local InputUnTarget = CreateTextBox(PageUnusual, "Unusual Target (Cth: MysticalTree)")
local InputUnSource = CreateTextBox(PageUnusual, "Unusual Baru (Cth: AngelicRedemption)")

local BtnExecUnusual = Instance.new("TextButton")
BtnExecUnusual.Size = UDim2.new(0.5, 0, 0, 40)
BtnExecUnusual.Text = "Tukar Unusual"
BtnExecUnusual.BackgroundColor3 = Color3.fromRGB(70, 200, 70)
BtnExecUnusual.TextColor3 = Color3.fromRGB(255, 255, 255)
BtnExecUnusual.Font = Enum.Font.GothamBold
BtnExecUnusual.TextSize = 14
BtnExecUnusual.Parent = PageUnusual
local CornerExecUn = Instance.new("UICorner")
CornerExecUn.CornerRadius = UDim.new(0, 6)
CornerExecUn.Parent = BtnExecUnusual

BtnExecUnusual.MouseButton1Click:Connect(function()
    local targetName = InputUnTarget.Text
    local sourceName = InputUnSource.Text
    
    local success, UnusualModule = pcall(function()
        return loadstring(game:HttpGet("https://raw.githubusercontent.com/ilyfauzan/WayaeHUB/main/UnusualSwapper.lua"))()
    end)
    
    if success and type(UnusualModule) == "table" and UnusualModule.Swap then
        UnusualModule.Swap(targetName, sourceName)
    else
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "ERROR",
            Text = "Gagal memuat modul UnusualSwapper dari GitHub!",
            Duration = 5
        })
    end
end)


Pages["HomePage"].Visible = true
BtnHome.BackgroundColor3 = Color3.fromRGB(70, 70, 220)
BtnHome.TextColor3 = Color3.fromRGB(255, 255, 255)

print("Custom UI WayaeHUB berhasil dimuat!")
