local MarketplaceService = game:GetService("MarketplaceService")
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LightingService = game:GetService("Lighting")
local HttpService = game:GetService("HttpService")
local PlayersService = game:GetService("Players")

----// Variables \\----

local MeteoriteHub = {}
MeteoriteHub.Connections = {}
MeteoriteHub.Settings = {
	["Menu"] = {
		["OpenKeycode"] = Enum.KeyCode.K;
	}
}

local Player = PlayersService.LocalPlayer
local PlayerGui = Player.PlayerGui
local Mouse = Player:GetMouse()

----// Local Functions \\----

function newInstance(Class: string, Properties: {})
	local _Instance = Instance.new(Class)
	for Name, Value in Properties do
		_Instance[Name] = Value
	end

	return _Instance
end

local function _hasCoreAccess()
	local _arg = function()
		return game:GetService("CoreGui").Name
	end

	local _success, _valueOrError = pcall(_arg)
	MeteoriteHub.warn(`CoreGui "Enabled" State Is {_success}. `)

	if _success == true then
		return game:GetService("CoreGui");
	else
		return PlayerGui;
	end
end

---------------------------------------------

local function openTab(tabName: string)
	local Button = MeteoriteHub.InterfaceElements["Menu"]["TabButtons"]:FindFirstChild(tabName):: Frame
	local Page = MeteoriteHub.InterfaceElements["Menu"]["Pages"]:FindFirstChild(tabName):: Frame

	if not Button or not Page then
		return MeteoriteHub.warn(`Tab with name "{tabName}" not found.`)
	end

	for _, v in pairs(MeteoriteHub.InterfaceElements["Menu"]["TabButtons"]:GetChildren()) do
		if v:IsA("Frame") then
			TweenService:Create(v, TweenInfo.new(0.25), {BackgroundTransparency = 1}):Play()
		end
	end

	TweenService:Create(Button, TweenInfo.new(0.25), {BackgroundTransparency = 0.5}):Play()
	MeteoriteHub.InterfaceElements["Menu"]["Pages_UIPage"]:JumpTo(Page)
end

----// Other \\----

local Blur = newInstance("BlurEffect", {Name = "MH_BlurEffect"}):: BlurEffect

MeteoriteHub.InterfaceElements = {
	["Menu"] = {
		["Buttons"] = {
			["Close"] = {};
			["Minimize"] = {};
			["Settings"] = {};
		};

		["Settings"] = {}
	};

	["OpenButton"] = {};
}

----// Functions \\----

MeteoriteHub.print = function(Text: string?)
	print(`>>>>>-👌 Meteorite Hub 👌-<<<<<`)
	print(Text)
	print(`>>>>>>>>---------------<<<<<<<<\n`)
end

MeteoriteHub.warn = function(Text: string?)
	warn(`>>>>>-⚠️ Meteorite Hub ⚠️-<<<<<`)
	warn(Text)
	warn(`>>>>>>>>---------------<<<<<<<<\n`)
end

MeteoriteHub.Init = function()
	MeteoriteHub.InterfaceElements["ScreenGui"] = newInstance("ScreenGui", {Name = HttpService:GenerateGUID(false); ZIndexBehavior = Enum.ZIndexBehavior.Sibling; Parent = _hasCoreAccess()}):: ScreenGui

	MeteoriteHub.InterfaceElements["MainBorder"] = newInstance("Frame", {Name = "Border"; Size = UDim2.fromScale(1, 1); Transparency = 1; Parent = MeteoriteHub.InterfaceElements["ScreenGui"]}):: Frame
	Blur.Size = 20

	---------------------------------------------

	local function loadMenu()
		MeteoriteHub.InterfaceElements["OpenButton"]["Frame"] = newInstance("Frame", {Name = "OpenButton"; BackgroundColor3 = Color3.fromRGB(33, 33, 33); Position = UDim2.fromScale(0.98, 0.5); AnchorPoint = Vector2.new(1, 0.5); Size = UDim2.fromOffset(35, 35); BorderSizePixel = 0; Transparency = 0.15; Visible = false; Parent = MeteoriteHub.InterfaceElements["MainBorder"]}):: Frame

		MeteoriteHub.InterfaceElements["OpenButton"]["Frame_UICorner"] = newInstance("UICorner", {CornerRadius = UDim.new(0, 3); Parent = MeteoriteHub.InterfaceElements["OpenButton"]["Frame"]})
		MeteoriteHub.InterfaceElements["OpenButton"]["Frame_UIStroke"] = newInstance("UIStroke", {Color = Color3.new(1, 1, 1); Transparency = 0.75; Thickness = 1; Parent = MeteoriteHub.InterfaceElements["OpenButton"]["Frame"]})
		MeteoriteHub.InterfaceElements["OpenButton"]["Icon"] = newInstance("ImageLabel", {Name = "Icon"; Image = "rbxassetid://12338895277"; Size = UDim2.fromScale(1, 1); Transparency = 1; Parent = MeteoriteHub.InterfaceElements["OpenButton"]["Frame"]})
		MeteoriteHub.InterfaceElements["OpenButton"]["Button"] = newInstance("TextButton", {Name = "Button"; Size = UDim2.fromScale(1, 1); Transparency = 1; Parent = MeteoriteHub.InterfaceElements["OpenButton"]["Frame"]})

		---------------------------------------------

		MeteoriteHub.InterfaceElements["Menu"]["Frame"] = newInstance("Frame", {Name = "Menu"; Parent = MeteoriteHub.InterfaceElements["MainBorder"]; AnchorPoint = Vector2.new(0.5, 0.5); Position = UDim2.fromScale(0.5, 0.5); Size = UDim2.fromOffset(500, 300); Transparency = 1})

		MeteoriteHub.InterfaceElements["Menu"]["Dragger"] = newInstance("Frame", {Name = "Dragger"; Parent = MeteoriteHub.InterfaceElements["Menu"]["Frame"]; Position = UDim2.fromScale(0, 0); AnchorPoint = Vector2.new(0, 0); Size = UDim2.fromScale(410, 29); Transparency = 1; ZIndex = 2})

		MeteoriteHub.InterfaceElements["Menu"]["Frame_UICorner"] = newInstance("UICorner", {Name = "Frame_UICorner"; Parent = MeteoriteHub.InterfaceElements["Menu"]["Frame"]; CornerRadius = UDim.new(0, 5)})

		MeteoriteHub.InterfaceElements["Menu"]["Topbar"] = newInstance("CanvasGroup", {Name = "Topbar"; Parent = MeteoriteHub.InterfaceElements["Menu"]["Frame"]; Position = UDim2.fromScale(0.5, 0); AnchorPoint = Vector2.new(0.5, 0); Size = UDim2.new(1, 0, 0, 35); Transparency = 1})
		MeteoriteHub.InterfaceElements["Menu"]["Topbar_UICorner"] = newInstance("UICorner", {Name = "Topbar_UICorner"; Parent = MeteoriteHub.InterfaceElements["Menu"]["Topbar"]; CornerRadius = UDim.new(0, 5)})

		---------------------------------------------

		MeteoriteHub.InterfaceElements["Menu"]["TopbarBackground"] = newInstance("Frame", {Name = "TopbarBackground"; Parent = MeteoriteHub.InterfaceElements["Menu"]["Topbar"]; BackgroundColor3 = Color3.fromRGB(39, 39, 39); Position = UDim2.fromScale(0.5, 0); AnchorPoint = Vector2.new(0.5, 0); Size = UDim2.new(1, 0, 0, 29); BackgroundTransparency = 0; BorderSizePixel = 0})
		MeteoriteHub.InterfaceElements["Menu"]["Icon"] = newInstance("ImageLabel", {Name = "Icon"; Parent = MeteoriteHub.InterfaceElements["Menu"]["TopbarBackground"]; Image = "rbxassetid://73547268944166"; Position = UDim2.new(0, 3, 0.5, 0); AnchorPoint = Vector2.new(0, 0.5); Size = UDim2.fromOffset(27, 27); BackgroundTransparency = 1})

		MeteoriteHub.InterfaceElements["Menu"]["Title"] = newInstance("TextLabel", {Name = "Title"; Parent = MeteoriteHub.InterfaceElements["Menu"]["TopbarBackground"]; Text = "<b>Meteorite Hub</b> | <i><font transparency=\"0.2\">" .. MarketplaceService:GetProductInfo(game.PlaceId).Name .. "</font></i>"; TextXAlignment = Enum.TextXAlignment.Left; Position = UDim2.new(0, 36, 0.5, 0); AnchorPoint = Vector2.new(0, 0.5); TextColor3 = Color3.new(1, 1, 1); BackgroundTransparency = 1; RichText = true; TextSize = 9})

		---------------------------------------------

		MeteoriteHub.InterfaceElements["Menu"]["Buttons"]["Close"]["Frame"] = newInstance("Frame", {Name = "Close"; Parent = MeteoriteHub.InterfaceElements["Menu"]["Topbar"]; BackgroundColor3 = Color3.fromRGB(255, 44, 44); Position = UDim2.fromScale(1, 0); AnchorPoint = Vector2.new(1, 0); Size = UDim2.fromOffset(29, 29); BackgroundTransparency = 1; BorderSizePixel = 0})
		MeteoriteHub.InterfaceElements["Menu"]["Buttons"]["Close"]["Close_Image"] = newInstance("ImageLabel", {Name = "Close_Image"; Parent = MeteoriteHub.InterfaceElements["Menu"]["Buttons"]["Close"]["Frame"]; Image = "rbxassetid://74120900238837"; Position = UDim2.fromScale(0.5, 0.5); AnchorPoint = Vector2.new(0.5, 0.5); Size = UDim2.fromScale(0.8, 0.8); BackgroundTransparency = 1})
		MeteoriteHub.InterfaceElements["Menu"]["Buttons"]["Close"]["Close_Button"] = newInstance("TextButton", {Name = "Close_Button"; Parent = MeteoriteHub.InterfaceElements["Menu"]["Buttons"]["Close"]["Frame"]; Position = UDim2.fromScale(0.5, 0.5); AnchorPoint = Vector2.new(0.5, 0.5); Size = UDim2.fromScale(1, 1); Transparency = 1; Modal = true})

		MeteoriteHub.InterfaceElements["Menu"]["Buttons"]["Close"]["Close_Button"].MouseEnter:Connect(function()
			TweenService:Create(
				MeteoriteHub.InterfaceElements["Menu"]["Buttons"]["Close"]["Frame"],
				TweenInfo.new(0.1),
				{BackgroundTransparency = 0}
			):Play()
		end)

		MeteoriteHub.InterfaceElements["Menu"]["Buttons"]["Close"]["Close_Button"].MouseLeave:Connect(function()
			TweenService:Create(
				MeteoriteHub.InterfaceElements["Menu"]["Buttons"]["Close"]["Frame"],
				TweenInfo.new(0.1),
				{BackgroundTransparency = 1}
			):Play()
		end)
		---------------------------------------------

		MeteoriteHub.InterfaceElements["Menu"]["Buttons"]["Minimize"]["Frame"] = newInstance("Frame", {Name = "Minimize"; Parent = MeteoriteHub.InterfaceElements["Menu"]["Topbar"]; BackgroundColor3 = Color3.fromRGB(255, 192, 90); Position = UDim2.fromScale(0.94, 0); AnchorPoint = Vector2.new(1, 0); Size = UDim2.fromOffset(29, 29); BackgroundTransparency = 1; BorderSizePixel = 0})
		MeteoriteHub.InterfaceElements["Menu"]["Buttons"]["Minimize"]["Minimize_Image"] = newInstance("ImageLabel", {Name = "Minimize_Image"; Parent = MeteoriteHub.InterfaceElements["Menu"]["Buttons"]["Minimize"]["Frame"]; Image = "rbxassetid://15396333997"; Position = UDim2.fromScale(0.5, 0.5); AnchorPoint = Vector2.new(0.5, 0.5); Size = UDim2.fromScale(0.8, 0.8); BackgroundTransparency = 1})
		MeteoriteHub.InterfaceElements["Menu"]["Buttons"]["Minimize"]["Minimize_Button"] = newInstance("TextButton", {Name = "Minimize_Button"; Parent = MeteoriteHub.InterfaceElements["Menu"]["Buttons"]["Minimize"]["Frame"]; Position = UDim2.fromScale(0.5, 0.5); AnchorPoint = Vector2.new(0.5, 0.5); Size = UDim2.fromScale(1, 1); Transparency = 1})

		MeteoriteHub.InterfaceElements["Menu"]["Buttons"]["Minimize"]["Minimize_Button"].MouseEnter:Connect(function()
			TweenService:Create(
				MeteoriteHub.InterfaceElements["Menu"]["Buttons"]["Minimize"]["Frame"],
				TweenInfo.new(0.1),
				{BackgroundTransparency = 0}
			):Play()
		end)

		MeteoriteHub.InterfaceElements["Menu"]["Buttons"]["Minimize"]["Minimize_Button"].MouseLeave:Connect(function()
			TweenService:Create(
				MeteoriteHub.InterfaceElements["Menu"]["Buttons"]["Minimize"]["Frame"],
				TweenInfo.new(0.1),
				{BackgroundTransparency = 1}
			):Play()
		end)

		---------------------------------------------

		MeteoriteHub.InterfaceElements["Menu"]["Buttons"]["Settings"]["Frame"] = newInstance("Frame", {Name = "Settings"; Parent = MeteoriteHub.InterfaceElements["Menu"]["Topbar"]; BackgroundColor3 = Color3.fromRGB(16, 16, 16); Position = UDim2.fromScale(0.88, 0); AnchorPoint = Vector2.new(1, 0); Size = UDim2.fromOffset(29, 29); BackgroundTransparency = 1; BorderSizePixel = 0})
		MeteoriteHub.InterfaceElements["Menu"]["Buttons"]["Settings"]["Settings_Image"] = newInstance("ImageLabel", {Name = "Settings_Image"; Parent = MeteoriteHub.InterfaceElements["Menu"]["Buttons"]["Settings"]["Frame"]; Image = "rbxassetid://7059346373"; Position = UDim2.fromScale(0.5, 0.5); AnchorPoint = Vector2.new(0.5, 0.5); Size = UDim2.fromScale(0.6, 0.6); BackgroundTransparency = 1})
		MeteoriteHub.InterfaceElements["Menu"]["Buttons"]["Settings"]["Settings_Button"] = newInstance("TextButton", {Name = "Settings_Button"; Parent = MeteoriteHub.InterfaceElements["Menu"]["Buttons"]["Settings"]["Frame"]; Position = UDim2.fromScale(0.5, 0.5); AnchorPoint = Vector2.new(0.5, 0.5); Size = UDim2.fromScale(1, 1); Transparency = 1})

		MeteoriteHub.InterfaceElements["Menu"]["Buttons"]["Settings"]["Settings_Button"].MouseEnter:Connect(function()
			TweenService:Create(
				MeteoriteHub.InterfaceElements["Menu"]["Buttons"]["Settings"]["Frame"],
				TweenInfo.new(0.1),
				{BackgroundTransparency = 0}
			):Play()
		end)

		MeteoriteHub.InterfaceElements["Menu"]["Buttons"]["Settings"]["Settings_Button"].MouseLeave:Connect(function()
			TweenService:Create(
				MeteoriteHub.InterfaceElements["Menu"]["Buttons"]["Settings"]["Frame"],
				TweenInfo.new(0.1),
				{BackgroundTransparency = 1}
			):Play()
		end)

		---------------------------------------------

		MeteoriteHub.InterfaceElements["Menu"]["Settings"]["Frame"] = newInstance("Frame", {Name = "Settings"; Parent = MeteoriteHub.InterfaceElements["Menu"]["Frame"]; Position = UDim2.fromScale(0.5, 1); AnchorPoint = Vector2.new(0.5, 1); Size = UDim2.fromOffset(500, 271); BackgroundTransparency = 1; ZIndex = 3})
		MeteoriteHub.InterfaceElements["Menu"]["Settings"]["Title"] = newInstance("TextLabel", {Name = "Title"; Parent = MeteoriteHub.InterfaceElements["Menu"]["Settings"]["Frame"]; AnchorPoint = Vector2.new(0.5, 0); Position = UDim2.fromScale(0.5, 0.05); TextColor3 = Color3.new(1, 1, 1); BackgroundTransparency = 1; Text = "<b>Settings</b>"; RichText = true; TextSize = 10})
		MeteoriteHub.InterfaceElements["Menu"]["Settings"]["Title_Underline"] = newInstance("Frame", {Name = "Title_Underline"; Parent = MeteoriteHub.InterfaceElements["Menu"]["Settings"]["Frame"]; BackgroundColor3 = Color3.new(1, 1, 1); Position = UDim2.fromScale(0.5, 0.1); AnchorPoint = Vector2.new(0.5, 0); Size = UDim2.fromOffset(470, 2)})
		MeteoriteHub.InterfaceElements["Menu"]["Settings"]["Title_UIGradient"] = newInstance("UIGradient", {Name = "Title_UIGradient"; Parent = MeteoriteHub.InterfaceElements["Menu"]["Settings"]["Title_Underline"]; Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1); NumberSequenceKeypoint.new(0.1, 0); NumberSequenceKeypoint.new(0.5, 0); NumberSequenceKeypoint.new(0.9, 0); NumberSequenceKeypoint.new(1, 1)})})

		MeteoriteHub.InterfaceElements["Menu"]["Settings"]["Frame"].Visible = false

		---------------------------------------------

		MeteoriteHub.InterfaceElements["Menu"]["Background"] = newInstance("Frame", {Name = "Background"; Parent = MeteoriteHub.InterfaceElements["Menu"]["Frame"]; BackgroundColor3 = Color3.fromRGB(30, 30, 30); Position = UDim2.fromScale(0.5, 1); AnchorPoint = Vector2.new(0.5, 1); Size = UDim2.fromOffset(500, 271); BorderSizePixel = 0; Transparency = 0.25})

		---------------------------------------------

		MeteoriteHub.InterfaceElements["Menu"]["Functions"] = newInstance("Frame", {Name = "Functions"; Parent = MeteoriteHub.InterfaceElements["Menu"]["Frame"]; Position = UDim2.fromScale(0.5, 0.98); AnchorPoint = Vector2.new(0.5, 1); Size = UDim2.fromOffset(480, 255); Transparency = 1})
		MeteoriteHub.InterfaceElements["Menu"]["Pages"] = newInstance("Frame", {Name = "Pages"; Parent = MeteoriteHub.InterfaceElements["Menu"]["Functions"]; Position = UDim2.fromScale(0.5, 1); AnchorPoint = Vector2.new(0.5, 1); Size = UDim2.fromOffset(480, 235); ClipsDescendants = true; Transparency = 1})
		MeteoriteHub.InterfaceElements["Menu"]["Pages_UIPage"] = newInstance("UIPageLayout", {Name = "Pages_UIPage"; Parent = MeteoriteHub.InterfaceElements["Menu"]["Pages"]; EasingDirection = Enum.EasingDirection.InOut; EasingStyle = Enum.EasingStyle.Quad; Padding = UDim.new(0, 50); TweenTime = 0.5})
		MeteoriteHub.InterfaceElements["Menu"]["TabButtons"] = newInstance("ScrollingFrame", {Name = "TabButtons"; Parent = MeteoriteHub.InterfaceElements["Menu"]["Functions"]; Position = UDim2.fromScale(0.5, 0); AnchorPoint = Vector2.new(0.5, 0); Size = UDim2.fromOffset(450, 20); ScrollBarThickness = 0; Transparency = 1})
		MeteoriteHub.InterfaceElements["Menu"]["TabButtons_UIList"] = newInstance("UIListLayout", {Name = "TabButtons_UIList"; Parent = MeteoriteHub.InterfaceElements["Menu"]["TabButtons"]; FillDirection = Enum.FillDirection.Horizontal; SortOrder = Enum.SortOrder.LayoutOrder})

		MeteoriteHub.InterfaceElements["Menu"]["TabButtons_UIList"]:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
			MeteoriteHub.InterfaceElements["Menu"]["TabButtons"].CanvasSize = UDim2.fromOffset(MeteoriteHub.InterfaceElements["Menu"]["TabButtons_UIList"].AbsoluteContentSize, 0)
		end)

		---------------------------------------------

		local function MinimizeGUI(State: boolean)
			if State then
				MeteoriteHub.InterfaceElements["OpenButton"]["Frame"].Visible = true
				MeteoriteHub.InterfaceElements["Menu"]["Frame"].Visible = false

				TweenService:Create(Blur, TweenInfo.new(0.5), {Size = 0}):Play()
			else
				MeteoriteHub.InterfaceElements["OpenButton"]["Frame"].Visible = false
				MeteoriteHub.InterfaceElements["Menu"]["Frame"].Visible = true

				TweenService:Create(Blur, TweenInfo.new(0.5), {Size = 20}):Play()
				UserInputService.MouseIconEnabled = true
			end
		end

		---------------------------------------------

		MeteoriteHub.InterfaceElements["Menu"]["Buttons"]["Close"]["Close_Button"].MouseButton1Click:Connect(function()
			for Index, Connection: RBXScriptConnection in MeteoriteHub.Connections do
				Connection:Disconnect()
				Connection = nil
			end

			MeteoriteHub.InterfaceElements["ScreenGui"]:Destroy()
			Blur:Destroy()
		end)

		MeteoriteHub.InterfaceElements["Menu"]["Buttons"]["Minimize"]["Minimize_Button"].MouseButton1Click:Connect(function()
			MinimizeGUI(true)
		end)
		MeteoriteHub.InterfaceElements["OpenButton"]["Button"].MouseButton1Click:Connect(function()
			MinimizeGUI(false)
		end)

		MeteoriteHub.InterfaceElements["Menu"]["Buttons"]["Settings"]["Settings_Button"].MouseButton1Click:Connect(function()
			local State = MeteoriteHub.InterfaceElements["Menu"]["Settings"]["Frame"].Visible
			MeteoriteHub.InterfaceElements["Menu"]["Settings"]["Frame"].Visible = not State
			MeteoriteHub.InterfaceElements["Menu"]["Functions"].Visible = State
		end)

		---------------------------------------------

		UserInputService.InputBegan:Connect(function(inputObject, gameProcessedEvent)
			if gameProcessedEvent then
				return
			end

			if inputObject.KeyCode == MeteoriteHub.Settings.Menu.OpenKeycode then
				local state = MeteoriteHub.InterfaceElements["OpenButton"]["Frame"].Visible
				MinimizeGUI(not state)
			end
		end)
	end

	loadMenu()
end

---------------------------------------------

MeteoriteHub.Functions = {
	CreateTab = function(Name: string, iconID: number, openOnCreate: boolean)
		if Name == nil or Name == "" then
			error("Tab name is empty or equals nil.")
		end
		
		---------------------------------------------

		openOnCreate = openOnCreate or false
		iconID = iconID or 0
		
		---------------------------------------------

		local newButton = Instance.new("Frame")
		newButton.Parent = MeteoriteHub.InterfaceElements["Menu"]["TabButtons"]
		newButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		newButton.Size = UDim2.fromOffset(100, 23)
		newButton.BackgroundTransparency = 1
		newButton.BorderSizePixel = 0
		newButton.Name = Name

		local buttonUICorner = Instance.new("UICorner")
		buttonUICorner.CornerRadius = UDim.new(0, 5)
		buttonUICorner.Parent = newButton
		
		---------------------------------------------

		local Icon = Instance.new("ImageLabel")
		Icon.Position = UDim2.new(0, 5, 0.47, 0)
		Icon.AnchorPoint = Vector2.new(0, 0.5)
		Icon.Size = UDim2.fromOffset(13, 13)
		Icon.Image = `rbxassetid://{iconID}`
		Icon.BackgroundTransparency = 1
		Icon.Parent = newButton
		Icon.Name = "Icon"
		
		---------------------------------------------

		local Title = Instance.new("TextLabel")
		Title.Position = UDim2.new(0, 28, 0.47, 0)
		Title.AnchorPoint = Vector2.new(0, 0.5)
		Title.Size = UDim2.fromOffset(73, 20)
		Title.Parent = newButton
		Title.Name = "Title"
		Title.TextSize = 9

		Title.TextXAlignment = Enum.TextXAlignment.Left
		Title.TextColor3 = Color3.new(1, 1, 1)
		Title.BackgroundTransparency = 1
		Title.Text = `<b>{Name}</b>`
		Title.RichText = true
		
		---------------------------------------------

		local Button = Instance.new("TextButton")
		Button.Size = UDim2.fromScale(1, 1)
		Button.Parent = newButton
		Button.Transparency = 1
		Button.Name = "Button"
		
		---------------------------------------------

		local newPage = Instance.new("Frame")
		newPage.Parent = MeteoriteHub.InterfaceElements["Menu"]["Pages"]
		newPage.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		newPage.Size = UDim2.fromScale(1, 1)
		newPage.Transparency = 0.5
		newPage.BorderSizePixel = 0
		newPage.Name = Name

		local page_UICorner = newInstance("UICorner", {Name = "UICorner"; Parent = newPage; CornerRadius = UDim.new(0, 5)})
		
		---------------------------------------------

		Button.MouseButton1Click:Connect(function() openTab(Name) end)
		if openOnCreate == true then openTab(Name) end
		
		---------------------------------------------

		return {
			Page = newPage;
			Button = newButton
		}
	end,
	
	createTitle = function(Name: string)
		if Name == nil or Name == "" then
			error("Title name is empty or equals nil.")
		end

		---------------------------------------------

		local Frame = Instance.new("Frame")
		Frame.BackgroundColor3 = Color3.new(0, 0, 0)
		Frame.Size = UDim2.fromOffset(150, 22)
		Frame.BackgroundTransparency = 0.45
		Frame.BorderSizePixel = 0
		Frame.Name = Name
		
		local UICorner = Instance.new("UICorner")
		UICorner.CornerRadius = UDim.new(0, 2)
		UICorner.Parent = Frame

		---------------------------------------------

		local Title = Instance.new("TextLabel")
		Title.Parent = Frame
		Title.Name = "Title"

		Title.Position = UDim2.fromScale(0.5, 0.5)
		Title.AnchorPoint = Vector2.new(0.5, 0.5)

		Title.Size = UDim2.fromScale(1, 0.6)
		Title.BackgroundTransparency = 1
		Title.TextScaled = true
		Title.RichText = true

		Title.TextWrapped = true
		Title.Text = `<b>---›› {Name} ‹‹---</b>`
		Title.TextColor3 = Color3.new(1, 1, 1)

		---------------------------------------------

		return {
			Frame = Frame;
		}
	end,
	
	---------------------------------------------

	add_checkBox = function(Name: string, standartValue: boolean)
		if Name == nil or Name == "" then
			error("Checkbox name is empty or equals nil.")
		end

		standartValue = standartValue or false

		---------------------------------------------

		local Frame = Instance.new("Frame")
		Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
		Frame.Size = UDim2.fromOffset(150, 22)
		Frame.BorderSizePixel = 0
		Frame.Name = Name

		local Frame_UIStroke = Instance.new("UIStroke")
		Frame_UIStroke.Color = Color3.new(1, 1, 1)
		Frame_UIStroke.Parent = Frame
		Frame_UIStroke.Thickness = 1.1

		local Frame_UICorner = Instance.new("UICorner")
		Frame_UICorner.Parent = Frame
		Frame_UICorner.CornerRadius = UDim.new(0, 2)

		---------------------------------------------

		local BoolValue = Instance.new("BoolValue")
		BoolValue.Parent = Frame
		BoolValue.Name = "State"
		BoolValue.Value = standartValue

		---------------------------------------------

		local Title = Instance.new("TextLabel")
		Title.Parent = Frame
		Title.Name = "Title"

		Title.Position = UDim2.new(0, 8, 0.5, 0)
		Title.AnchorPoint = Vector2.new(0, 0.5)

		Title.Size = UDim2.new(0, 124, 1, 0)
		Title.BackgroundTransparency = 1
		Title.RichText = true
		Title.TextSize = 7

		Title.TextWrapped = true
		Title.Text = `<b>{Name}</b>`
		Title.TextColor3 = Color3.new(1, 1, 1)
		Title.TextXAlignment = Enum.TextXAlignment.Left

		---------------------------------------------

		local Check_Frame = Instance.new("Frame")
		Check_Frame.Parent = Frame
		Check_Frame.Name = "Check"

		Check_Frame.AnchorPoint = Vector2.new(1, 0.5)
		Check_Frame.Position = UDim2.new(0.98, 0, 0.5, 0)
		Check_Frame.Size = UDim2.fromOffset(18, 18)

		Check_Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
		Check_Frame.BorderMode = Enum.BorderMode.Inset
		Check_Frame.BorderColor3 = Color3.new(1, 1, 1)
		Check_Frame.BorderSizePixel = 1

		local Check_Icon = Instance.new("ImageLabel")
		Check_Icon.Parent = Check_Frame
		Check_Icon.Name = "Icon"

		Check_Icon.Size = UDim2.fromScale(1, 1)
		Check_Icon.BackgroundTransparency = 1

		Check_Icon.Image = `rbxassetid://14189590169`
		Check_Icon.Visible = standartValue

		local Button = Instance.new("TextButton")
		Button.Parent = Check_Frame
		Button.Name = "Button"

		Button.Size = UDim2.fromScale(1, 1)
		Button.Transparency = 1

		---------------------------------------------

		local Cooldown = false
		Button.MouseButton1Click:Connect(function()
			if Cooldown then
				return
			end

			Cooldown = true

			BoolValue.Value = not BoolValue.Value
			Check_Icon.Visible = BoolValue.Value

			task.delay(0.25, function()
				Cooldown = false
			end)
		end)

		---------------------------------------------

		return {
			Frame = Frame;
			BoolValue = BoolValue;
		}
	end,

	add_Selector = function(Name: string)
		if Name == nil or Name == "" then
			error("Selector name is empty or equals nil.")
		end

		local Frame = Instance.new("Frame")
		Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
		Frame.Size = UDim2.fromOffset(150, 22)
		Frame.BorderSizePixel = 0
		Frame.Name = Name

		local Frame_UIStroke = Instance.new("UIStroke")
		Frame_UIStroke.Color = Color3.new(1, 1, 1)
		Frame_UIStroke.Parent = Frame
		Frame_UIStroke.Thickness = 1.1

		local Frame_UICorner = Instance.new("UICorner")
		Frame_UICorner.Parent = Frame
		Frame_UICorner.CornerRadius = UDim.new(0, 2)

		---------------------------------------------

		local CurrentVariable = Instance.new("StringValue")
		CurrentVariable.Parent = Frame
		CurrentVariable.Name = "CurrentVariable"
		CurrentVariable.Value = ""

		---------------------------------------------

		local Title = Instance.new("TextLabel")
		Title.Parent = Frame
		Title.Name = "Title"

		Title.Position = UDim2.new(0, 8, 0.5, 0)
		Title.AnchorPoint = Vector2.new(0, 0.5)

		Title.Size = UDim2.new(0, 124, 1, 0)
		Title.BackgroundTransparency = 1
		Title.RichText = true
		Title.TextSize = 7

		Title.TextWrapped = true
		Title.Text = `<b>{Name}</b>`
		Title.TextColor3 = Color3.new(1, 1, 1)
		Title.TextXAlignment = Enum.TextXAlignment.Left

		---------------------------------------------

		local ViewAll = Instance.new("Frame")
		ViewAll.Parent = Frame
		ViewAll.Name = "ViewAll"

		ViewAll.AnchorPoint = Vector2.new(1, 0.5)
		ViewAll.Position = UDim2.new(0.98, 0, 0.5, 0)
		ViewAll.Size = UDim2.fromOffset(18, 18)

		ViewAll.BackgroundTransparency = 1
		ViewAll.BorderSizePixel = 0

		local Icon = Instance.new("ImageLabel")
		Icon.Parent = ViewAll
		Icon.Name = "Icon"

		Icon.Image = `rbxassetid://12338895277`
		Icon.Size = UDim2.fromScale(1, 1)
		Icon.BackgroundTransparency = 1

		local Button = Instance.new("TextButton")
		Button.Parent = ViewAll
		Button.Name = "Button"

		Button.Size = UDim2.fromScale(1, 1)
		Button.Transparency = 1

		---------------------------------------------

		local VariablesFrame = Instance.new("ScrollingFrame")
		VariablesFrame.Name = "VariablesFrame"
		VariablesFrame.Parent = Frame

		VariablesFrame.BorderColor3 = Color3.fromRGB(48, 48, 48)
		VariablesFrame.ScrollBarThickness = 0
		VariablesFrame.BorderSizePixel = 0

		VariablesFrame.Size = UDim2.fromOffset(150, 0)
		VariablesFrame.AnchorPoint = Vector2.new(0.5, 0)
		VariablesFrame.Position = UDim2.new(0.5, 0, 1, 5)

		VariablesFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)

		local UIList = Instance.new("UIListLayout")
		UIList.Parent = VariablesFrame
		UIList.SortOrder = Enum.SortOrder.LayoutOrder

		---------------------------------------------

		UIList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
			VariablesFrame.CanvasSize = UDim2.fromOffset(0, UIList.AbsoluteContentSize.Y)
		end)

		Button.MouseButton1Click:Connect(function()
			local State = (Icon.Rotation == 90)

			if State then
				TweenService:Create(
					Icon,
					TweenInfo.new(0.2),
					{Rotation = 0}
				):Play()

				local close = TweenService:Create(
					VariablesFrame,
					TweenInfo.new(0.2),
					{
						Size = UDim2.fromOffset(150, 0); 
						ScrollBarThickness = 0;
						BorderSizePixel = 0;
					}
				); close:Play()

				close.Completed:Connect(function()
					Frame.ZIndex = 1
				end)
			else
				Frame.ZIndex = 10

				TweenService:Create(
					Icon,
					TweenInfo.new(0.2),
					{Rotation = 90}
				):Play()

				TweenService:Create(
					VariablesFrame,
					TweenInfo.new(0.2),
					{
						Size = UDim2.fromOffset(150, 80); 
						ScrollBarThickness = 4;
						BorderSizePixel = 1;
					}
				):Play()
			end
		end)

		---------------------------------------------

		return {
			Frame = Frame;
			Variable = CurrentVariable;
		}
	end,

	add_selectorVariable = function(Name: string, Selector: Frame, Selected: boolean)
		if Name == nil or Name == "" then
			error("Selector Variable name is empty or equals nil.")
		end

		Selected = Selected or false

		local VariablesFrame = Selector:FindFirstChild("VariablesFrame"):: ScrollingFrame
		local CurrentVariable = Selector:FindFirstChild("CurrentVariable"):: StringValue

		---------------------------------------------

		if VariablesFrame and CurrentVariable then
			local Frame = Instance.new("Frame")
			Frame.Parent = VariablesFrame
			Frame.Name = Name

			Frame.Size = UDim2.new(1, 0, 0, 20)
			Frame.BackgroundTransparency = 1
			Frame.BorderSizePixel = 1

			Frame.LayoutOrder = #VariablesFrame:GetChildren()

			---------------------------------------------

			local Title = Instance.new("TextLabel")
			Title.Parent = Frame
			Title.Name = "Title"

			Title.Size = UDim2.fromScale(1, 1)
			Title.BackgroundTransparency = 1
			Title.BorderSizePixel = 0

			Title.TextColor3 = Color3.new(1, 1, 1)
			Title.TextWrapped = true
			Title.RichText = true
			Title.TextSize = 8.5

			---------------------------------------------

			local Button = Instance.new("TextButton")
			Button.Parent = Frame
			Button.Name = "Button"

			Button.Transparency = 1
			Button.Size = UDim2.fromScale(1, 1)

			---------------------------------------------

			local function deselect()
				for _, v in pairs(VariablesFrame:GetChildren()) do
					if v:IsA("Frame") then
						local t = v:FindFirstChild("Title")
						v.BackgroundTransparency = 1
						t.Text = `{v.Name}`
					end
				end
			end

			Button.MouseButton1Click:Connect(function()
				local State = (CurrentVariable.Value == Name)
				deselect()

				if State then
					CurrentVariable.Value = "None"
					Frame.Transparency = 1
					Title.Text = `{Name}`
				else
					CurrentVariable.Value = Name
					Title.Text = `<b>{Name}</b>`
					Frame.Transparency = 0.7
				end
			end)

			if Selected then
				deselect()

				Frame.Transparency = 0.7
				Title.Text = `<b>{Name}</b>`
				CurrentVariable.Value = Name
			else
				Title.Text = `{Name}`
				Frame.Transparency = 1
			end
		else
			return MeteoriteHub.warn(`VariablesFrame or CurrentVariable was not founded.`)
		end
	end,

	add_Button = function(Name: string, iconID: number)
		if Name == nil or Name == "" then
			error("Button name is empty or equals nil.")
		end

		iconID = iconID or nil

		local Frame = Instance.new("Frame")
		Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
		Frame.Size = UDim2.fromOffset(150, 22)
		Frame.BorderSizePixel = 0
		Frame.Name = Name

		local Frame_UIStroke = Instance.new("UIStroke")
		Frame_UIStroke.Color = Color3.new(1, 1, 1)
		Frame_UIStroke.Parent = Frame
		Frame_UIStroke.Thickness = 1.1

		local Frame_UICorner = Instance.new("UICorner")
		Frame_UICorner.Parent = Frame
		Frame_UICorner.CornerRadius = UDim.new(0, 2)

		---------------------------------------------

		local Title = Instance.new("TextLabel")
		Title.Parent = Frame
		Title.Name = "Title"

		Title.Position = UDim2.fromScale(1, 0.5)
		Title.AnchorPoint = Vector2.new(1, 0.5)

		Title.Size = UDim2.new(0, 142, 1, 0)
		Title.BackgroundTransparency = 1
		Title.RichText = true
		Title.TextSize = 7

		Title.TextWrapped = true
		Title.Text = `<b>{Name}</b>`
		Title.TextColor3 = Color3.new(1, 1, 1)
		Title.TextXAlignment = Enum.TextXAlignment.Left

		---------------------------------------------

		local Button = Instance.new("TextButton")
		Button.Parent = Frame
		Button.Name = "Button"

		Button.Transparency = 1
		Button.Size = UDim2.fromScale(1, 1)

		---------------------------------------------

		if iconID ~= nil then
			local Icon = Instance.new("ImageLabel")
			Icon.Parent = Frame
			Icon.Name = "Icon"

			Icon.BackgroundTransparency = 1
			Icon.Size = UDim2.fromOffset(16, 16)

			Icon.Position = UDim2.new(0, 5, 0.5, 0)
			Icon.AnchorPoint = Vector2.new(0, 0.5)

			Title.Size = UDim2.new(0, 123, 1, 0)
			Icon.Image = `rbxassetid://{iconID}`
		end

		---------------------------------------------

		return {
			Frame = Frame;
			Button = Button;
		}
	end,

	add_Slider = function(Name: string, standartValue: number, minValue: number, maxValue: number, sliderStep: number)
		if Name == nil or Name == "" then
			error("Slider name is empty or equals nil.")
		end

		minValue = minValue or 0
		maxValue = maxValue or 1
		sliderStep = sliderStep or 0.1
		standartValue = standartValue or 0

		if standartValue < minValue then
			standartValue = minValue
		end

		---------------------------------------------

		local Frame = Instance.new("Frame")
		Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
		Frame.Size = UDim2.fromOffset(150, 34)
		Frame.BorderSizePixel = 0
		Frame.Name = Name

		local Frame_UIStroke = Instance.new("UIStroke")
		Frame_UIStroke.Color = Color3.new(1, 1, 1)
		Frame_UIStroke.Parent = Frame
		Frame_UIStroke.Thickness = 1.1

		local Frame_UICorner = Instance.new("UICorner")
		Frame_UICorner.Parent = Frame
		Frame_UICorner.CornerRadius = UDim.new(0, 2)

		---------------------------------------------

		local SliderValue = Instance.new("NumberValue")
		SliderValue.Parent = Frame
		SliderValue.Name = "Value"

		SliderValue.Value = standartValue

		---------------------------------------------

		local Title = Instance.new("TextLabel")
		Title.Parent = Frame
		Title.Name = "Title"

		Title.Position = UDim2.new(0, 5, 0, 0)

		Title.Size = UDim2.new(0, 80, 0.5, 0)
		Title.BackgroundTransparency = 1
		Title.RichText = true
		Title.TextSize = 7

		Title.TextWrapped = true
		Title.Text = `<b>{Name}</b>`
		Title.TextColor3 = Color3.new(1, 1, 1)
		Title.TextXAlignment = Enum.TextXAlignment.Left

		---------------------------------------------

		local TextValue = Instance.new("TextLabel")
		TextValue.Parent = Frame
		TextValue.Name = "Value"

		TextValue.Position = UDim2.new(1, -5, 0, 0)
		TextValue.AnchorPoint = Vector2.new(1, 0)

		TextValue.Size = UDim2.new(0, 50, 0.5, 0)
		TextValue.BackgroundTransparency = 1
		TextValue.RichText = true
		TextValue.TextSize = 7

		TextValue.TextTransparency = 0.5
		TextValue.TextWrapped = true

		TextValue.Text = SliderValue.Value
		TextValue.TextColor3 = Color3.new(1, 1, 1)
		TextValue.TextXAlignment = Enum.TextXAlignment.Right

		---------------------------------------------

		local Slider_Frame = Instance.new("Frame")
		Slider_Frame.Name = "Slider_Canvas"
		Slider_Frame.Parent = Frame

		Slider_Frame.Size = UDim2.fromOffset(142, 11)
		Slider_Frame.BackgroundTransparency = 1

		Slider_Frame.AnchorPoint = Vector2.new(0.5, 1)
		Slider_Frame.Position = UDim2.fromScale(0.5, 0.9)

		local Slider_UIStroke = Instance.new("UIStroke")
		Slider_UIStroke.Color = Color3.new(0.568627, 0.568627, 0.568627)
		Slider_UIStroke.Parent = Slider_Frame
		Slider_UIStroke.Thickness = 1.1

		local Slider_UICorner = Instance.new("UICorner")
		Slider_UICorner.Parent = Slider_Frame
		Slider_UICorner.CornerRadius = UDim.new(0, 2)

		---------------------------------------------

		local rawOutput = (standartValue - minValue) / (maxValue - minValue)
		local clampedOutput = math.clamp(rawOutput, 0, 1)

		local steppedOutput = math.round(clampedOutput / sliderStep) * sliderStep
		steppedOutput = math.clamp(steppedOutput, 0, 1)

		local Slider_Filler = Instance.new("Frame")
		Slider_Filler.Parent = Slider_Frame
		Slider_Filler.Name = "Filler"

		Slider_Filler.AnchorPoint = Vector2.new(0, 0.5)
		Slider_Filler.Position = UDim2.fromScale(0, 0.5)
		Slider_Filler.Size = UDim2.fromScale(steppedOutput, 1)

		Slider_Filler.BackgroundColor3 = Color3.new(1, 1, 1)
		Slider_Filler.BorderSizePixel = 0

		---------------------------------------------

		local Button = Instance.new("TextButton")
		Button.Parent = Slider_Frame
		Button.Name = "Button"

		Button.Transparency = 1
		Button.Size = UDim2.fromScale(1, 1)

		local Sliding = false
		Button.MouseButton1Up:Connect(function()
			Sliding = false
		end)

		Button.MouseButton1Down:Connect(function()
			Sliding = true
			MeteoriteHub.Connections[Name] = UserInputService.InputEnded:Connect(function(input, gameProcessedEvent)
				if gameProcessedEvent then return end

				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					Sliding = false
					MeteoriteHub.Connections[Name]:Disconnect()
				end
			end)

			repeat
				task.wait()
				local rawOutput = (Mouse.X - Slider_Frame.AbsolutePosition.X) / Slider_Frame.AbsoluteSize.X
				local clampedOutput = math.clamp(rawOutput, 0, 1)

				local steppedOutput = math.round(clampedOutput / sliderStep) * sliderStep
				steppedOutput = math.clamp(steppedOutput, 0, 1)

				TweenService:Create(
					Slider_Filler,
					TweenInfo.new(0.35),
					{Size = UDim2.fromScale(steppedOutput, 1)}
				):Play()

				SliderValue.Value = math.round(steppedOutput * ((maxValue - minValue) / sliderStep)) * sliderStep + minValue
				TextValue.Text = string.format("%.2f", SliderValue.Value)
			until not Sliding
		end)

		---------------------------------------------

		return {
			Frame = Frame;
			IntValue = SliderValue
		}
	end,

	add_colorPicker = function(Name: string, standartColor: Color3)
		if Name == nil or Name == "" then
			error("Color picker name is empty or equals nil.")
		end

		---------------------------------------------

		standartColor = standartColor or Color3.fromRGB(255, 255, 255)

		---------------------------------------------

		local Frame = Instance.new("Frame")
		Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
		Frame.Size = UDim2.fromOffset(150, 22)
		Frame.BorderSizePixel = 0
		Frame.Name = Name
		Frame.ZIndex = 2

		local Frame_UIStroke = Instance.new("UIStroke")
		Frame_UIStroke.Color = Color3.new(1, 1, 1)
		Frame_UIStroke.Parent = Frame
		Frame_UIStroke.Thickness = 1.1

		local Frame_UICorner = Instance.new("UICorner")
		Frame_UICorner.Parent = Frame
		Frame_UICorner.CornerRadius = UDim.new(0, 2)

		---------------------------------------------

		local Title = Instance.new("TextLabel")
		Title.Parent = Frame
		Title.Name = "Title"

		Title.Position = UDim2.fromScale(1, 0.5)
		Title.AnchorPoint = Vector2.new(1, 0.5)

		Title.Size = UDim2.new(0, 142, 1, 0)
		Title.BackgroundTransparency = 1
		Title.RichText = true
		Title.TextSize = 7

		Title.TextWrapped = true
		Title.Text = `<b>{Name}</b>`
		Title.TextColor3 = Color3.new(1, 1, 1)
		Title.TextXAlignment = Enum.TextXAlignment.Left

		---------------------------------------------

		local Color3Value = Instance.new("Color3Value")
		Color3Value.Value = standartColor
		Color3Value.Parent = Frame

		---------------------------------------------

		local colorBox = Instance.new("Frame")
		colorBox.Parent = Frame
		colorBox.Name = "colorBox"

		colorBox.AnchorPoint = Vector2.new(1, 0.5)
		colorBox.Position = UDim2.new(0.98, 0, 0.5, 0)
		colorBox.Size = UDim2.fromOffset(18, 18)

		colorBox.BackgroundColor3 = standartColor
		colorBox.BorderMode = Enum.BorderMode.Inset
		colorBox.BorderColor3 = Color3.new(1, 1, 1)
		colorBox.BorderSizePixel = 1

		local Button = Instance.new("TextButton")
		Button.Parent = colorBox
		Button.Name = "Button"

		Button.Size = UDim2.fromScale(1, 1)
		Button.Transparency = 1

		---------------------------------------------

		local chooseFrame = Instance.new("Frame")
		chooseFrame.Name = "chooser"
		chooseFrame.Parent = Frame

		chooseFrame.AnchorPoint = Vector2.new(0.5, 0)
		chooseFrame.Position = UDim2.fromScale(0.5, 1.3)

		chooseFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
		chooseFrame.Size = UDim2.fromOffset(150, 35)
		chooseFrame.BorderSizePixel = 0

		local chooser_UIStroke = Instance.new("UIStroke")
		chooser_UIStroke.Color = Color3.new(1, 1, 1)
		chooser_UIStroke.Parent = chooseFrame
		chooser_UIStroke.Thickness = 1.1

		local chooser_UICorner = Instance.new("UICorner")
		chooser_UICorner.CornerRadius = UDim.new(0, 2)
		chooser_UICorner.Parent = chooseFrame

		---------------------------------------------

		local Rtext = Instance.new("TextLabel")
		Rtext.Parent = chooseFrame
		Rtext.Name = "R_label"

		Rtext.TextColor3 = Color3.fromRGB(255, 98, 98)
		Rtext.BackgroundTransparency = 1
		Rtext.BorderSizePixel = 0

		Rtext.RichText = true
		Rtext.Text = "<b>R</b>"

		Rtext.AnchorPoint = Vector2.new(0.5, 0.5)
		Rtext.Position = UDim2.fromScale(0.2, 0.3)

		local RedPicker = Instance.new("TextBox")
		RedPicker.Parent = chooseFrame
		RedPicker.Name = "RedPicker"

		RedPicker.Size = UDim2.fromOffset(45, 10)
		RedPicker.BackgroundTransparency = 1
		RedPicker.BorderSizePixel = 0

		RedPicker.TextColor3 = Color3.fromRGB(255, 255, 255)
		RedPicker.Text = `<b>{math.round(standartColor.R * 255)}</b>`
		RedPicker.RichText = true
		RedPicker.TextSize = 9

		RedPicker.AnchorPoint = Vector2.new(0.5, 0.5)
		RedPicker.Position = UDim2.fromScale(0.2, 0.7)

		---------------------------------------------

		local Gtext = Instance.new("TextLabel")
		Gtext.Parent = chooseFrame
		Gtext.Name = "G_label"

		Gtext.TextColor3 = Color3.fromRGB(164, 255, 115)
		Gtext.BackgroundTransparency = 1
		Gtext.BorderSizePixel = 0

		Gtext.RichText = true
		Gtext.Text = "<b>G</b>"

		Gtext.AnchorPoint = Vector2.new(0.5, 0.5)
		Gtext.Position = UDim2.fromScale(0.5, 0.3)

		local GreenPicker = Instance.new("TextBox")
		GreenPicker.Parent = chooseFrame
		GreenPicker.Name = "GreenPicker"

		GreenPicker.Size = UDim2.fromOffset(45, 10)
		GreenPicker.BackgroundTransparency = 1
		GreenPicker.BorderSizePixel = 0

		GreenPicker.TextColor3 = Color3.fromRGB(255, 255, 255)
		GreenPicker.Text = `<b>{math.round(standartColor.G * 255)}</b>`
		GreenPicker.RichText = true
		GreenPicker.TextSize = 9

		GreenPicker.AnchorPoint = Vector2.new(0.5, 0.5)
		GreenPicker.Position = UDim2.fromScale(0.5, 0.7)

		---------------------------------------------

		local Btext = Instance.new("TextLabel")
		Btext.Parent = chooseFrame
		Btext.Name = "B_label"

		Btext.TextColor3 = Color3.fromRGB(99, 102, 255)
		Btext.BackgroundTransparency = 1
		Btext.BorderSizePixel = 0

		Btext.RichText = true
		Btext.Text = "<b>B</b>"

		Btext.AnchorPoint = Vector2.new(0.5, 0.5)
		Btext.Position = UDim2.fromScale(0.8, 0.3)

		local BluePicker = Instance.new("TextBox")
		BluePicker.Parent = chooseFrame
		BluePicker.Name = "BluePicker"

		BluePicker.Size = UDim2.fromOffset(45, 10)
		BluePicker.BackgroundTransparency = 1
		BluePicker.BorderSizePixel = 0

		BluePicker.TextColor3 = Color3.fromRGB(255, 255, 255)
		BluePicker.Text = `<b>{math.round(standartColor.B * 255)}</b>`
		BluePicker.RichText = true
		BluePicker.TextSize = 9

		BluePicker.AnchorPoint = Vector2.new(0.5, 0.5)
		BluePicker.Position = UDim2.fromScale(0.8, 0.7)

		---------------------------------------------

		chooseFrame.Visible = false
		chooseFrame.Size = UDim2.fromOffset(150, 0)
		for _, v in pairs(chooseFrame:GetChildren()) do
			if v:IsA("TextLabel") or v:IsA("TextBox") then
				TweenService:Create(v, TweenInfo.new(0.5), {TextTransparency = 0}):Play()
			end
		end

		Button.MouseButton1Up:Connect(function()
			local active = chooseFrame.Visible

			if not active then
				chooseFrame.Visible = true
				local _start = TweenService:Create(chooseFrame, TweenInfo.new(0.5), {
					Size = UDim2.fromOffset(150, 35)
				}); _start:Play()

				for _, v in pairs(chooseFrame:GetChildren()) do
					if v:IsA("TextLabel") or v:IsA("TextBox") then
						TweenService:Create(v, TweenInfo.new(0.5), {TextTransparency = 0}):Play()
					end
				end

				_start.Completed:Connect(function()
					chooseFrame.Size = UDim2.fromOffset(150, 35)
					chooseFrame.Visible = true
				end)
			else
				local _end = TweenService:Create(chooseFrame, TweenInfo.new(0.5), {
					Size = UDim2.fromOffset(150, 0)
				}); _end:Play()

				for _, v in pairs(chooseFrame:GetChildren()) do
					if v:IsA("TextLabel") or v:IsA("TextBox") then
						TweenService:Create(v, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
					end
				end

				_end.Completed:Connect(function()
					chooseFrame.Size = UDim2.fromOffset(150, 0)
					chooseFrame.Visible = false
				end)
			end
		end)

		---------------------------------------------

		RedPicker.FocusLost:Connect(function()
			local formattedText = RedPicker.Text:gsub("%D+", "")
			RedPicker.Text = formattedText

			local numbers = tonumber(formattedText)

			if numbers then
				Color3Value.Value = Color3.new(math.clamp(numbers, 0, 255)/255, Color3Value.Value.G, Color3Value.Value.B)
			else
				Color3Value.Value = Color3.new(1, Color3Value.Value.G, Color3Value.Value.B)
			end
		end)

		GreenPicker.FocusLost:Connect(function()
			local formattedText = GreenPicker.Text:gsub("%D+", "")
			GreenPicker.Text = formattedText

			local numbers = tonumber(formattedText)

			if numbers then
				Color3Value.Value = Color3.new(Color3Value.Value.R, math.clamp(numbers, 0, 255)/255, Color3Value.Value.B)
			else
				Color3Value.Value = Color3.new(Color3Value.Value.R, 1, Color3Value.Value.B)
			end
		end)

		BluePicker.FocusLost:Connect(function()
			local formattedText = BluePicker.Text:gsub("%D+", "")
			BluePicker.Text = formattedText

			local numbers = tonumber(formattedText)

			if numbers then
				Color3Value.Value = Color3.new(Color3Value.Value.R, Color3Value.Value.G, math.clamp(numbers, 0, 255)/255)
			else
				Color3Value.Value = Color3.new(Color3Value.Value.r, Color3Value.Value.G, 1)
			end
		end)

		---------------------------------------------

		Color3Value.Changed:Connect(function()
			local newValue = Color3Value.Value

			RedPicker.Text = `<b>{math.round(newValue.R*255)}</b>`
			GreenPicker.Text = `<b>{math.round(newValue.G*255)}</b>`
			BluePicker.Text = `<b>{math.round(newValue.B*255)}</b>`

			colorBox.BackgroundColor3 = newValue
		end)

		---------------------------------------------

		return {
			Frame = Frame;
			Color = Color3Value;
		}
	end,

	add_keycodeBox = function(Name: string, standartKeycode: Enum.KeyCode, toggleMode: boolean)
		if Name == nil or Name == "" then
			error("Keycode box name is empty or equals nil.")
		end

		---------------------------------------------

		local newKeycode = standartKeycode
		toggleMode = toggleMode or false

		local Frame = Instance.new("Frame")
		Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
		Frame.Size = UDim2.fromOffset(150, 22)
		Frame.BorderSizePixel = 0
		Frame.Name = Name

		local Frame_UIStroke = Instance.new("UIStroke")
		Frame_UIStroke.Color = Color3.new(1, 1, 1)
		Frame_UIStroke.Parent = Frame
		Frame_UIStroke.Thickness = 1.1

		local Frame_UICorner = Instance.new("UICorner")
		Frame_UICorner.Parent = Frame
		Frame_UICorner.CornerRadius = UDim.new(0, 2)

		---------------------------------------------

		local Title = Instance.new("TextLabel")
		Title.Parent = Frame
		Title.Name = "Title"

		Title.Position = UDim2.new(0, 8, 0.5, 0)
		Title.AnchorPoint = Vector2.new(0, 0.5)

		Title.Size = UDim2.new(0, 90, 1, 0)
		Title.BackgroundTransparency = 1
		Title.RichText = true
		Title.TextSize = 7

		Title.TextWrapped = true
		Title.Text = `<b>{Name}</b>`
		Title.TextColor3 = Color3.new(1, 1, 1)
		Title.TextXAlignment = Enum.TextXAlignment.Left

		---------------------------------------------

		local Key_Frame = Instance.new("Frame")
		Key_Frame.Parent = Frame
		Key_Frame.Name = "Check"

		Key_Frame.AnchorPoint = Vector2.new(1, 0.5)
		Key_Frame.Position = UDim2.new(0.98, 0, 0.5, 0)
		Key_Frame.Size = UDim2.fromOffset(60, 18)

		Key_Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
		Key_Frame.BorderMode = Enum.BorderMode.Inset
		Key_Frame.BorderColor3 = Color3.new(1, 1, 1)
		Key_Frame.BorderSizePixel = 1

		---------------------------------------------

		local showValue = Instance.new("TextLabel")
		showValue.Parent = Key_Frame
		showValue.Name = "Title"

		showValue.Position = UDim2.fromScale(0.5, 0.5)
		showValue.AnchorPoint = Vector2.new(0.5, 0.5)

		showValue.Size = UDim2.fromScale(1, 1)
		showValue.BackgroundTransparency = 1
		showValue.RichText = true
		showValue.TextSize = 7

		showValue.TextWrapped = true
		showValue.TextColor3 = Color3.new(1, 1, 1)

		if newKeycode ~= nil then
			showValue.Text = `<b>{newKeycode.Name}</b>`
		else
			showValue.Text = `<b>None</b>`
		end

		---------------------------------------------

		local chooseKeyMode = false
		local Button = Instance.new("TextButton")
		Button.Parent = Key_Frame
		Button.Name = "Button"

		Button.Size = UDim2.fromScale(1, 1)
		Button.Transparency = 1

		---------------------------------------------

		local keyState = Instance.new("BoolValue")
		keyState.Name = "keyState"
		keyState.Parent = Frame

		---------------------------------------------

		if MeteoriteHub.Connections[`KeycodeBox_{Name}`] then
			for Key, Value in pairs(MeteoriteHub.Connections[`KeycodeBox_{Name}`]) do
				if Key == "InputBegan" or Key == "InputEnded" then
					if Value ~= nil then
						Value:Disconnect()
					end
				end
			end
		end

		MeteoriteHub.Connections[`KeycodeBox_{Name}`] = {["InputBegan"] = nil; ["InputEnded"] = nil}
		local newTable = MeteoriteHub.Connections[`KeycodeBox_{Name}`]

		Button.MouseButton1Up:Connect(function()
			chooseKeyMode = not chooseKeyMode
			if chooseKeyMode then
				showValue.Text = `<b>Choosing key</b>`
				keyState.Value = false
			end
		end)

		newTable['InputBegan'] = UserInputService.InputBegan:Connect(function(inputObject, gameProcessedEvent)
			if inputObject.KeyCode == newKeycode then
				if toggleMode then
					keyState.Value = not keyState.Value
				else
					keyState.Value = true
				end
			end

			if chooseKeyMode then
				if inputObject.KeyCode == Enum.KeyCode.Escape or inputObject.UserInputType == Enum.UserInputType.MouseButton1 or inputObject.UserInputType == Enum.UserInputType.MouseButton2 then
					showValue.Text = `<b>None</b>`
					chooseKeyMode = false
					newKeycode = nil
				else
					if inputObject.UserInputType == Enum.UserInputType.Keyboard then
						showValue.Text = `<b>{inputObject.KeyCode.Name}</b>`
						newKeycode = inputObject.KeyCode
						chooseKeyMode = false
					end
				end
			end
		end)

		newTable['InputEnded'] = UserInputService.InputEnded:Connect(function(inputObject)
			if inputObject.KeyCode == newKeycode then
				if not toggleMode then
					keyState.Value = false
				end
			end
		end)

		---------------------------------------------

		keyState.Changed:Connect(function()
			if keyState.Value then
				showValue.TextColor3 = Color3.fromRGB(160, 255, 131)
			else
				showValue.TextColor3 = Color3.fromRGB(255, 255, 255)
			end
		end)

		---------------------------------------------

		return {
			Frame = Frame;
			keyState = keyState
		}
	end,
	
	add_elementsList = function(Name: string)
		if Name == nil or Name == "" then
			error("elements list name is empty or equals nil.")
		end

		local Frame = Instance.new("Frame")
		Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
		Frame.Size = UDim2.fromOffset(150, 22)
		Frame.BorderSizePixel = 0
		Frame.Name = Name
		Frame.ZIndex = 2

		local Frame_UIStroke = Instance.new("UIStroke")
		Frame_UIStroke.Color = Color3.new(1, 1, 1)
		Frame_UIStroke.Parent = Frame
		Frame_UIStroke.Thickness = 1.1

		local Frame_UICorner = Instance.new("UICorner")
		Frame_UICorner.Parent = Frame
		Frame_UICorner.CornerRadius = UDim.new(0, 2)

		---------------------------------------------

		local Title = Instance.new("TextLabel")
		Title.Parent = Frame
		Title.Name = "Title"

		Title.Position = UDim2.fromScale(0.5, 0.5)
		Title.AnchorPoint = Vector2.new(0.5, 0.5)

		Title.Size = UDim2.new(0, 88, 0.55, 0)
		Title.BackgroundTransparency = 1
		Title.TextScaled = true
		Title.RichText = true

		Title.TextWrapped = true
		Title.Text = `<b>{Name}</b>`
		Title.TextColor3 = Color3.new(1, 1, 1)

		---------------------------------------------

		local Button = Instance.new("TextButton")
		Button.Parent = Frame
		Button.Name = "Button"

		Button.Transparency = 1
		Button.Size = UDim2.fromScale(1, 1)
		
		---------------------------------------------
		
		local Left = Instance.new("ImageLabel")
		Left.Parent = Frame
		Left.Name = "leftIcon"

		Left.Image = `rbxassetid://12338895277`
		Left.Size = UDim2.fromOffset(15, 15)
		Left.BackgroundTransparency = 1
		
		Left.Position = UDim2.new(0, 8, 0.5, 0)
		Left.AnchorPoint = Vector2.new(0, 0.5)
		Left.Rotation = 180
		
		---------------------------------------------
		
		local Right = Instance.new("ImageLabel")
		Right.Parent = Frame
		Right.Name = "rightIcon"

		Right.Image = `rbxassetid://12338895277`
		Right.Size = UDim2.fromOffset(15, 15)
		Right.BackgroundTransparency = 1

		Right.Position = UDim2.new(0, 143, 0.5, 0)
		Right.AnchorPoint = Vector2.new(1, 0.5)
		
		---------------------------------------------
		
		local List = Instance.new("ScrollingFrame")
		List.Visible = false
		List.Parent = Frame
		List.Name = "List"
		
		List.BorderSizePixel = 0
		List.BackgroundTransparency = 0.4
		List.BackgroundColor3 = Color3.new(0, 0, 0)
		List.CanvasSize = UDim2.fromOffset(0, 0)
		
		List.Size = UDim2.fromOffset(165, 0)
		List.AnchorPoint = Vector2.new(0.5, 0)
		List.Position = UDim2.fromScale(0.5, 1.2)
		List.ScrollBarThickness = 3
		
		local UIPadding = Instance.new("UIPadding")
		UIPadding.Parent = List
		UIPadding.PaddingTop = UDim.new(0, 5)
		UIPadding.PaddingBottom = UDim.new(0, 5)
		
		local ListStroke = Instance.new("UIStroke")
		ListStroke.Parent = List
		
		ListStroke.Thickness = 1
		ListStroke.Color = Color3.new(1, 1, 1)
		
		local ListCorner = Instance.new("UICorner")
		ListCorner.CornerRadius = UDim.new(0, 1)
		ListCorner.Parent = List
		
		local UIListLayout = Instance.new("UIListLayout")
		UIListLayout.Parent = List
		
		UIListLayout.Padding = UDim.new(0, 5)
		UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
		
		UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
			List.CanvasSize = UDim2.fromOffset(0, UIListLayout.AbsoluteContentSize.Y+10)
		end)

		---------------------------------------------
		
		Button.MouseButton1Up:Connect(function()
			if not List.Visible then
				List.Visible = true
				
				TweenService:Create(List, TweenInfo.new(0.4), {
					Size = UDim2.fromOffset(165, 50)
				}):Play()
				
				TweenService:Create(Left, TweenInfo.new(0.4), {
					Rotation = 90;
				}):Play()
				
				TweenService:Create(Right, TweenInfo.new(0.4), {
					Rotation = 90;
				}):Play()
			else
				local _end = TweenService:Create(List, TweenInfo.new(0.4), {
					Size = UDim2.fromOffset(165, 0)
				}); _end:Play()

				TweenService:Create(Left, TweenInfo.new(0.4), {
					Rotation = 180;
				}):Play()

				TweenService:Create(Right, TweenInfo.new(0.4), {
					Rotation = 0;
				}):Play()
				
				_end.Completed:Connect(function()
					List.Visible = false
				end)
			end
		end)
		
		---------------------------------------------

		return {
			Frame = Frame;
			List = List;
		}
	end,
}

---------------------------------------------

MeteoriteHub.Init()

--// Settings

local blurSetting = MeteoriteHub.Functions.add_checkBox("Enable Blur", true)
blurSetting.Frame.Parent = MeteoriteHub.InterfaceElements["Menu"]["Settings"]["Frame"]
blurSetting.Frame.Position = UDim2.fromOffset(20, 50)

blurSetting.BoolValue.Value = Blur.Enabled
blurSetting.BoolValue.Changed:Connect(function()
	local State = blurSetting.BoolValue.Value
	Blur.Enabled = State
end)

---------------------------------------------

return MeteoriteHub
