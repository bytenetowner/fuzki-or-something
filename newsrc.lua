local UILibrary = {}
UILibrary.__index = UILibrary

function UILibrary.new()
	local self = setmetatable({}, UILibrary)
	self.screenSize = UserInputService:GetMouseLocation()
	self.windows = {}
	return self
end

function UILibrary:createWindow(title)
	local window = {}
	window.title = title
	window.elements = {}
	window.position = UDim2.new(0, 10, 0, 10)
	window.size = UDim2.new(0, 250, 0, 50)
	
	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = title .. "GUI"
	screenGui.ResetOnSpawn = false
	screenGui.Parent = game.CoreGui
	
	local mainFrame = Instance.new("Frame")
	mainFrame.Name = "MainFrame"
	mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	mainFrame.BorderSizePixel = 0
	mainFrame.Size = window.size
	mainFrame.Position = window.position
	mainFrame.Parent = screenGui
	
	local titleLabel = Instance.new("TextLabel")
	titleLabel.Name = "TitleLabel"
	titleLabel.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
	titleLabel.BorderSizePixel = 0
	titleLabel.Size = UDim2.new(1, 0, 0, 30)
	titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	titleLabel.TextSize = 14
	titleLabel.Font = Enum.Font.GothamBold
	titleLabel.Text = title
	titleLabel.Parent = mainFrame
	
	local contentFrame = Instance.new("Frame")
	contentFrame.Name = "ContentFrame"
	contentFrame.BackgroundTransparency = 1
	contentFrame.Size = UDim2.new(1, 0, 1, -30)
	contentFrame.Position = UDim2.new(0, 0, 0, 30)
	contentFrame.Parent = mainFrame
	
	local listLayout = Instance.new("UIListLayout")
	listLayout.Padding = UDim.new(0, 5)
	listLayout.Parent = contentFrame
	
	local uiPadding = Instance.new("UIPadding")
	uiPadding.PaddingLeft = UDim.new(0, 5)
	uiPadding.PaddingRight = UDim.new(0, 5)
	uiPadding.PaddingTop = UDim.new(0, 5)
	uiPadding.PaddingBottom = UDim.new(0, 5)
	uiPadding.Parent = contentFrame
	
	window.mainFrame = mainFrame
	window.contentFrame = contentFrame
	window.screenGui = screenGui
	window.listLayout = listLayout
	
	table.insert(self.windows, window)
	
	return window
end

function UILibrary:createToggle(window, label, callback)
	local toggleSize = UDim2.new(1, 0, 0, 25)
	
	local toggleFrame = Instance.new("Frame")
	toggleFrame.Name = "ToggleFrame"
	toggleFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
	toggleFrame.BorderSizePixel = 0
	toggleFrame.Size = toggleSize
	toggleFrame.Parent = window.contentFrame
	
	local toggleLabel = Instance.new("TextLabel")
	toggleLabel.Name = "Label"
	toggleLabel.BackgroundTransparency = 1
	toggleLabel.Size = UDim2.new(0.7, 0, 1, 0)
	toggleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	toggleLabel.TextSize = 12
	toggleLabel.Font = Enum.Font.Gotham
	toggleLabel.Text = label
	toggleLabel.TextXAlignment = Enum.TextXAlignment.Left
	toggleLabel.Parent = toggleFrame
	
	local toggleButton = Instance.new("Frame")
	toggleButton.Name = "Button"
	toggleButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
	toggleButton.BorderSizePixel = 0
	toggleButton.Size = UDim2.new(0.25, 0, 0.6, 0)
	toggleButton.Position = UDim2.new(0.7, 5, 0.2, 0)
	toggleButton.Parent = toggleFrame
	
	local toggleCorner = Instance.new("UICorner")
	toggleCorner.CornerRadius = UDim.new(0, 3)
	toggleCorner.Parent = toggleButton
	
	local toggleState = false
	
	local mouseButton = Instance.new("TextButton")
	mouseButton.Name = "MouseButton"
	mouseButton.BackgroundTransparency = 1
	mouseButton.Size = UDim2.new(1, 0, 1, 0)
	mouseButton.Text = ""
	mouseButton.Parent = toggleButton
	
	local function updateToggleColor()
		if toggleState then
			toggleButton.BackgroundColor3 = Color3.fromRGB(0, 150, 136)
		else
			toggleButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
		end
	end
	
	mouseButton.MouseButton1Click:Connect(function()
		toggleState = not toggleState
		updateToggleColor()
		callback(toggleState)
	end)
	
	window.mainFrame.Size = window.mainFrame.Size + UDim2.new(0, 0, 0, 30)
	
	return toggleState
end

function UILibrary:createSlider(window, label, config, callback)
	local sliderSize = UDim2.new(1, 0, 0, 35)
	
	local sliderFrame = Instance.new("Frame")
	sliderFrame.Name = "SliderFrame"
	sliderFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
	sliderFrame.BorderSizePixel = 0
	sliderFrame.Size = sliderSize
	sliderFrame.Parent = window.contentFrame
	
	local sliderLabel = Instance.new("TextLabel")
	sliderLabel.Name = "Label"
	sliderLabel.BackgroundTransparency = 1
	sliderLabel.Size = UDim2.new(1, 0, 0, 15)
	sliderLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	sliderLabel.TextSize = 12
	sliderLabel.Font = Enum.Font.Gotham
	sliderLabel.Text = label
	sliderLabel.TextXAlignment = Enum.TextXAlignment.Left
	sliderLabel.Parent = sliderFrame
	
	local sliderBar = Instance.new("Frame")
	sliderBar.Name = "Bar"
	sliderBar.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
	sliderBar.BorderSizePixel = 0
	sliderBar.Size = UDim2.new(1, 0, 0, 5)
	sliderBar.Position = UDim2.new(0, 0, 0.5, 0)
	sliderBar.Parent = sliderFrame
	
	local sliderFill = Instance.new("Frame")
	sliderFill.Name = "Fill"
	sliderFill.BackgroundColor3 = Color3.fromRGB(0, 150, 136)
	sliderFill.BorderSizePixel = 0
	sliderFill.Size = UDim2.new(0, 0, 1, 0)
	sliderFill.Parent = sliderBar
	
	local sliderButton = Instance.new("Frame")
	sliderButton.Name = "Button"
	sliderButton.BackgroundColor3 = Color3.fromRGB(0, 150, 136)
	sliderButton.BorderSizePixel = 0
	sliderButton.Size = UDim2.new(0, 12, 0, 12)
	sliderButton.Position = UDim2.new(0, -6, 0.5, -6)
	sliderButton.Parent = sliderBar
	
	local sliderCorner = Instance.new("UICorner")
	sliderCorner.CornerRadius = UDim.new(0, 6)
	sliderCorner.Parent = sliderButton
	
	local valueLabel = Instance.new("TextLabel")
	valueLabel.Name = "ValueLabel"
	valueLabel.BackgroundTransparency = 1
	valueLabel.Size = UDim2.new(0.2, 0, 0, 15)
	valueLabel.Position = UDim2.new(0.8, 0, 0, 0)
	valueLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
	valueLabel.TextSize = 10
	valueLabel.Font = Enum.Font.Gotham
	valueLabel.Text = tostring(config.def or 0)
	valueLabel.Parent = sliderFrame
	
	local maxValue = config.max or 100
	local currentValue = config.def or 0
	
	local function updateSlider(newValue)
		currentValue = math.clamp(newValue, 0, maxValue)
		local percentage = currentValue / maxValue
		sliderFill.Size = UDim2.new(percentage, 0, 1, 0)
		sliderButton.Position = UDim2.new(percentage, -6, 0.5, -6)
		valueLabel.Text = tostring(math.floor(currentValue))
		callback(currentValue)
	end
	
	updateSlider(currentValue)
	
	local dragging = false
	
	sliderButton.MouseButton1Down:Connect(function()
		dragging = true
	end)
	
	UserInputService.InputEnded:Connect(function()
		if dragging then
			dragging = false
		end
	end)
	
	UserInputService.InputChanged:Connect(function(input)
		if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
			local mousePos = UserInputService:GetMouseLocation()
			local barPos = sliderBar.AbsolutePosition.X
			local barSize = sliderBar.AbsoluteSize.X
			local relativePos = math.clamp(mousePos.X - barPos, 0, barSize)
			local percentage = relativePos / barSize
			updateSlider(percentage * maxValue)
		end
	end)
	
	window.mainFrame.Size = window.mainFrame.Size + UDim2.new(0, 0, 0, 40)
	
	return currentValue
end

function UILibrary:init()
	return self
end

return UILibrary
