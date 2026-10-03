local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

-- Menentukan letak UI
local parentUI = CoreGui
if RunService:IsStudio() then
    parentUI = Players.LocalPlayer:WaitForChild("PlayerGui")
else
    local success = pcall(function() return CoreGui.Name end)
    if not success then parentUI = Players.LocalPlayer:WaitForChild("PlayerGui") end
end

-- Hapus UI lama jika ada biar tidak bertumpuk
if parentUI:FindFirstChild("WayaeHUB_UI") then
    parentUI.WayaeHUB_UI:Destroy()
end

-- =========================================
-- 1. MEMBUAT SCREEN GUI UTAMA
-- =========================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "WayaeHUB_UI"
ScreenGui.Parent = parentUI
ScreenGui.ResetOnSpawn = false

-- Tombol Toggle (Untuk Munculkan/Sembunyikan UI)
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Name = "ToggleBtn"
ToggleBtn.Size = UDim2.new(0, 45, 0, 45)
ToggleBtn.Position = UDim2.new(0, 15, 0, 15)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
ToggleBtn.Text = "W"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.TextSize = 20
ToggleBtn.Draggable = true
ToggleBtn.Parent = ScreenGui

local UICorner_Toggle = Instance.new("UICorner")
UICorner_Toggle.CornerRadius = UDim.new(0, 8)
UICorner_Toggle.Parent = ToggleBtn

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 500, 0, 360) -- Diperbesar sedikit agar muat 4 textbox
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -180)
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

-- =========================================
-- 2. SIDEBAR (Menu Kiri)
-- =========================================
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

-- =========================================
-- 3. KONTEN UTAMA (Area Kanan)
-- =========================================
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

-- =========================================
-- 4. SETUP HALAMAN & TAB
-- =========================================

-- Tab 1: Shader
local PageShader = CreatePage("ShaderPage")
local BtnShader = CreateMenuButton("Shader", "ShaderPage")

local ShaderLayout = Instance.new("UIListLayout")
ShaderLayout.Parent = PageShader
ShaderLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
ShaderLayout.SortOrder = Enum.SortOrder.LayoutOrder
ShaderLayout.Padding = UDim.new(0, 15)

local ShaderPadding = Instance.new("UIPadding")
ShaderPadding.Parent = PageShader
ShaderPadding.PaddingTop = UDim.new(0, 20)

local LabelShader = Instance.new("TextLabel")
LabelShader.Size = UDim2.new(1, 0, 0, 30)
LabelShader.BackgroundTransparency = 1
LabelShader.Text = "Menu Shader"
LabelShader.TextColor3 = Color3.fromRGB(255, 255, 255)
LabelShader.Font = Enum.Font.GothamBold
LabelShader.TextSize = 18
LabelShader.Parent = PageShader

-- ========================================================
-- Tab 2: Emote (Dengan 4 Input Manual)
-- ========================================================
local PageEmote = CreatePage("EmotePage")
local BtnEmote = CreateMenuButton("Emote", "EmotePage")

local EmoteLayout = Instance.new("UIListLayout")
EmoteLayout.Parent = PageEmote
EmoteLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
EmoteLayout.SortOrder = Enum.SortOrder.LayoutOrder
EmoteLayout.Padding = UDim.new(0, 8) -- Jarak sedikit lebih rapat agar 4 box muat

local EmotePadding = Instance.new("UIPadding")
EmotePadding.Parent = PageEmote
EmotePadding.PaddingTop = UDim.new(0, 15)

local LabelEmote = Instance.new("TextLabel")
LabelEmote.Size = UDim2.new(1, 0, 0, 30)
LabelEmote.BackgroundTransparency = 1
LabelEmote.Text = "Custom Emote Swapper"
LabelEmote.TextColor3 = Color3.fromRGB(255, 255, 255)
LabelEmote.Font = Enum.Font.GothamBold
LabelEmote.TextSize = 18
LabelEmote.Parent = PageEmote

-- Fungsi pembantu untuk membuat TextBox
local function CreateTextBox(placeholder)
    local box = Instance.new("TextBox")
    box.Size = UDim2.new(0.9, 0, 0, 32)
    box.PlaceholderText = placeholder
    box.Text = ""
    box.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    box.TextColor3 = Color3.fromRGB(255, 255, 255)
    box.Font = Enum.Font.Gotham
    box.TextSize = 12
    box.TextXAlignment = Enum.TextXAlignment.Left
    box.Parent = PageEmote
    local pad = Instance.new("UIPadding")
    pad.PaddingLeft = UDim.new(0, 10)
    pad.Parent = box
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = box
    return box
end

local InputTarget = CreateTextBox("1. Variabel Emote Target (Cth: Stride)")
local InputUITarget = CreateTextBox("2. Nama Target di Layar (Cth: Stride)")
local InputSource = CreateTextBox("3. Variabel Emote Baru (Cth: Broom)")
local InputUISource = CreateTextBox("4. Nama Baru di Layar (Cth: Broom Of Doom)")

-- Tombol Eksekusi
local BtnExecuteSwap = Instance.new("TextButton")
BtnExecuteSwap.Size = UDim2.new(0.5, 0, 0, 35)
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
    local uiTarget = InputUITarget.Text
    local sourceName = InputSource.Text
    local uiSource = InputUISource.Text
    
    local success, EmoteModule = pcall(function()
        return loadstring(game:HttpGet("https://raw.githubusercontent.com/ilyfauzan/WayaeHUB/main/EmoteSwapper.lua"))()
    end)
    
    if success and type(EmoteModule) == "table" and EmoteModule.Swap then
        EmoteModule.Swap(targetName, uiTarget, sourceName, uiSource)
    else
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "ERROR",
            Text = "Gagal memuat modul EmoteSwapper dari GitHub!",
            Duration = 5
        })
    end
end)


-- ========================================================
-- Tab 3: Unusual
-- ========================================================
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
LabelUnusual.Text = "Menu Unusual"
LabelUnusual.TextColor3 = Color3.fromRGB(255, 255, 255)
LabelUnusual.Font = Enum.Font.GothamBold
LabelUnusual.TextSize = 18
LabelUnusual.Parent = PageUnusual


-- =========================================
-- 5. INISIALISASI
-- =========================================
Pages["ShaderPage"].Visible = true
BtnShader.BackgroundColor3 = Color3.fromRGB(70, 70, 220)
BtnShader.TextColor3 = Color3.fromRGB(255, 255, 255)

print("Custom UI WayaeHUB berhasil dimuat!")
