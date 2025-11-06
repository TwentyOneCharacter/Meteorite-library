# Welcome To "Meteorite Hub" Page!
> [!WARNING]
> Hub can be used by anyone but please leave the authorship to me.

### Recommended Executor :: Solara, Velocity & Xeno
> [!NOTE]
> You can use executor higher level (Like Synapse X/Z)
____

# Adding to code
```lua
  local MeteoriteHub = loadstring(game:HttpGet(`https://raw.githubusercontent.com/TwentyOneCharacter/Meteorite-Hub/refs/heads/main/Main.lua?token=GHSAT0AAAAAADLBZ4R5JTDLB4SWQ45W3X5E2IM46LQ`))()
  local hubFunctions = MeteoriteHub.Functions -- need to add buttons and etc.
```
____

### Creating Page
```lua
  local newPage = hubFunctions.CreatePage(pageName, IconId, openOnCreate) --> (string, number, boolean) -> {Page: Frame, Button: Frame}
  --// iconId & openOnCreate is optionally.
  --// don't need any other things
```
____

> [!Warning]
> All other stuff needs to set parent and position to be showed.
> (type) -> {returned stuff: type}

### Adding Title
```lua
  local Title = hubFunctions.CreateTitle(Name) --> (string) -> {Frame: Frame}
  Title.Parent = newPage.Page -- Necessarily!!!
  Title.Position = UDim2.fromOffset(20, 20) -- aslo Necessarily
```
____

### Adding Checkbox
```lua
  local Checkbox = hubFunctions.add_Checkbox(Name, standartValue) --> (string, boolean) -> {Frame: Frame, BoolValue: BoolValue}
  Checkbox.Frame.Parent = newPage.Page
  Checkbox.Frame.Position = UDim2.fromOffset(20, 20)

  Checkbox.BoolValue.Changed:Connect(function()
      local currentBool = Checkbox.BoolValue.Value
      warn(currentBool)
  end)
```
____

### Adding Selector & Variable
```lua
  local Selector = hubFunctions.add_Selector(Name) --> (string) -> {Frame: Frame, Variable: StringValue}
  Selector.Frame.Parent = newPage.Page
  Selector.Frame.Position = UDim2.fromOffset(20, 20)

  local Variable = hubFunctions.add_selectorVariable(Name, Selector, Selected) --> (string, Frame, boolean) -> {}
  --// nothing more is needed

  Selector.Variable.Changed:Connect(function()
      local newVariable = Selector.Variable.Value
      warn(newVariable)
  end)
```
____

### Adding Button
```lua
  local Button = hubFunctions.add_Button(Name, iconID) --> (string, number) -> {Frame: Frame, Button: TextButton}
  Button.Frame.Parent = newPage.Page
  Button.Frame.Position = UDim2.fromOffset(20, 20)

  Button.Button.MouseButton1Click:Connect(function()
      warn("Button clicked.")
  end)
```
____

### Adding Slider
```lua
  local Slider = hubFunctions.add_Slider(Name, standartValue, minValue, maxValue, sliderStep) --> (string, number, number, number, number) -> {Frame: Frame, IntValue: NumberValue}
  Slider.Frame.Parent = newPage.Page
  Slider.Frame.Position = UDim2.fromOffset(20, 20)

  Slider.IntValue.Changed:Connect(function()
      local currentValue = Slider.IntValue.Value
      warn(currentValue)
  end)
```
____

### Adding Color Picker (NEW!)
```lua
  local ColorPicker = hubFunctions.add_colorPicker(Name, standartColor) --> (string, Color3) -> {Frame: Frame, Color: Color3Value}
  ColorPicker.Frame.Parent = newPage.Page
  ColorPicker.Frame.Position = UDim2.fromOffset(20, 20)

  ColorPicker.Color.Changed:Connect(function()
      local newColor = ColorPicker.Color.Value
      warn(`Color3.fromRGB({newColor.R}, {newColor.G}, {newColor.B})`)
  end)
```
____

### Adding Keycode Box (NEW!)
```lua
  local KeycodeBox = hubFunctions.add_keycodeBox(Name, standartKeycode, toggleMode) --> (string, Enum.Keycode, boolean) -> {Frame: Frame, keyState: BoolValue}
  KeycodeBox.Frame.Parent = newPage.Page
  KeycodeBox.Position = UDim2.fromOffset(20, 20)

  KeycodeBox.keyState.Changed:Connect(function()
      local keyPressed = KeycodeBox.keyState.Value
      warn(keyPressed)
  end)
```
____

### Adding Elements List (NEW!)
```lua
  local List = hubFunctions.add_elementsList(Name) --> (string) -> {Frame: Frame, List: ScrollingFrame}
  List.Frame.Parent = newPage.Page
  List.Frame.Position = UDim2.fromOffset(20, 20)

  --// Adding few elements to list

  hubFunctions.add_Button("Button").Frame.Parent = List.List
  hubFunctions.add_Slider("Slider").Frame.Parent = List.List
  hubFunctions.add_checkBox("checkBox").Frame.Parent = List.List
```

> [!NOTE]
> Hub version now is 0.3.5b
> All function can be changed any time
____
## Hub Changelog
+ [➕] Added Color Picker
+ [➕] Added Keycode Box
+ [➕] Added Elements List
