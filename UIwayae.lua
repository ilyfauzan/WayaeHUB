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
    ScreenGui:Destroy()
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

-- Tab 1: Shader (Kosong untuk sementara)
local PageShader = CreatePage("ShaderPage")
local BtnShader = CreateMenuButton("Shader", "ShaderPage")
local LabelShader = Instance.new("TextLabel")
LabelShader.Size = UDim2.new(1, 0, 0, 30)
LabelShader.Position = UDim2.new(0, 0, 0, 15)
LabelShader.BackgroundTransparency = 1
LabelShader.Text = "Menu Shader"
LabelShader.TextColor3 = Color3.fromRGB(255, 255, 255)
LabelShader.Font = Enum.Font.GothamBold
LabelShader.TextSize = 18
LabelShader.Parent = PageShader

-- ========================================================
-- Tab 2: Emote (Dengan Modul Terpisah)
-- ========================================================
local PageEmote = CreatePage("EmotePage")
local BtnEmote = CreateMenuButton("Emote", "EmotePage")

local LabelEmote = Instance.new("TextLabel")
LabelEmote.Size = UDim2.new(1, 0, 0, 30)
LabelEmote.Position = UDim2.new(0, 0, 0, 10)
LabelEmote.BackgroundTransparency = 1
LabelEmote.Text = "Custom Emote Swapper"
LabelEmote.TextColor3 = Color3.fromRGB(255, 255, 255)
LabelEmote.Font = Enum.Font.GothamBold
LabelEmote.TextSize = 18
LabelEmote.Parent = PageEmote

-- Kotak Input 1: Emote yang mau diganti (Target)
local InputTarget = Instance.new("TextBox")
InputTarget.Size = UDim2.new(0.8, 0, 0, 35)
InputTarget.Position = UDim2.new(0.1, 0, 0, 50)
InputTarget.PlaceholderText = "Emote yang Anda miliki (Contoh: SwagWalk)"
InputTarget.Text = ""
InputTarget.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
InputTarget.TextColor3 = Color3.fromRGB(255, 255, 255)
InputTarget.Font = Enum.Font.Gotham
InputTarget.TextSize = 13
InputTarget.Parent = PageEmote
local CornerTarget = Instance.new("UICorner"); CornerTarget.CornerRadius = UDim.new(0, 6); CornerTarget.Parent = InputTarget

-- Kotak Input 2: Emote pengganti (Source)
local InputSource = Instance.new("TextBox")
InputSource.Size = UDim2.new(0.8, 0, 0, 35)
InputSource.Position = UDim2.new(0.1, 0, 0, 95)
InputSource.PlaceholderText = "Emote pengganti (Contoh: RockinStride)"
InputSource.Text = ""
InputSource.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
InputSource.TextColor3 = Color3.fromRGB(255, 255, 255)
InputSource.Font = Enum.Font.Gotham
InputSource.TextSize = 13
InputSource.Parent = PageEmote
local CornerSource = Instance.new("UICorner"); CornerSource.CornerRadius = UDim.new(0, 6); CornerSource.Parent = InputSource

-- Tombol Eksekusi
local BtnExecuteSwap = Instance.new("TextButton")
BtnExecuteSwap.Size = UDim2.new(0.5, 0, 0, 40)
BtnExecuteSwap.Position = UDim2.new(0.25, 0, 0, 150)
BtnExecuteSwap.Text = "Tukar Emote"
BtnExecuteSwap.BackgroundColor3 = Color3.fromRGB(70, 200, 70)
BtnExecuteSwap.TextColor3 = Color3.fromRGB(255, 255, 255)
BtnExecuteSwap.Font = Enum.Font.GothamBold
BtnExecuteSwap.TextSize = 14
BtnExecuteSwap.Parent = PageEmote
local CornerExecute = Instance.new("UICorner"); CornerExecute.CornerRadius = UDim.new(0, 6); CornerExecute.Parent = BtnExecuteSwap

-- Logika mengambil file EmoteSwapper.lua dari GitHub saat tombol ditekan
BtnExecuteSwap.MouseButton1Click:Connect(function()
    local targetName = InputTarget.Text
    local sourceName = InputSource.Text
    
    -- Ambil modul logika secara dinamis (Terpisah agar rapi)
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


-- ========================================================
-- Tab 3: Unusual
-- ========================================================
local PageUnusual = CreatePage("UnusualPage")
local BtnUnusual = CreateMenuButton("Unusual", "UnusualPage")
local LabelUnusual = Instance.new("TextLabel")
LabelUnusual.Size = UDim2.new(1, 0, 0, 30)
LabelUnusual.Position = UDim2.new(0, 0, 0, 15)
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
