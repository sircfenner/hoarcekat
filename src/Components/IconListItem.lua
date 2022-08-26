local TextService = game:GetService("TextService")

local Hoarcekat = script:FindFirstAncestor("Hoarcekat")

local Roact = require(Hoarcekat.Vendor.Roact)
local StudioThemeAccessor = require(script.Parent.StudioThemeAccessor)

local e = Roact.createElement

local BAR_HEIGHT = 24
local ICON_SIZE = 16
local PADDING = 5

local FONT = Enum.Font.Legacy
local TEXT_SIZE = 8

local function IconListItem(props)
	local textAreaSize = Vector2.new(math.huge, math.huge)
	local textSize = TextService:GetTextSize(props.Text, TEXT_SIZE, FONT, textAreaSize)
	local itemWidth = BAR_HEIGHT + PADDING + textSize.x + PADDING

	return e(StudioThemeAccessor, {}, {
		function(theme)
			-- FitComponent uses the size of the top-level instance, whose width we limit here
			-- however, we want the selection input area & indicator to be the full width of the list
			-- this is done by using a very wide nested textbutton and hiding the top-level instance
			return e("Frame", {
				BackgroundTransparency = 1,
				Size = UDim2.fromOffset(itemWidth, BAR_HEIGHT),
				LayoutOrder = props.LayoutOrder,
			}, {
				Catcher = e("TextButton", {
					AnchorPoint = Vector2.new(0.5, 0),
					Size = UDim2.fromScale(500, 1),
					Position = UDim2.fromScale(0.5, 0),
					BackgroundColor3 = theme:GetColor("CurrentMarker", "Selected"),
					BackgroundTransparency = props.Selected and 0.5 or 1,
					Text = "",
					ZIndex = 0,
					[Roact.Event.Activated] = props.Activated,
				}),

				IconFrame = e("Frame", {
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					LayoutOrder = 1,
					Size = UDim2.fromOffset(BAR_HEIGHT, BAR_HEIGHT),
					ZIndex = 1,
				}, {
					IconImage = e("ImageLabel", {
						BackgroundTransparency = 1,
						BorderSizePixel = 0,
						Position = UDim2.fromScale(0.5, 0.5),
						Size = UDim2.fromOffset(ICON_SIZE, ICON_SIZE),
						AnchorPoint = Vector2.new(0.5, 0.5),
						Image = props.Icon,
						ImageColor3 = theme:GetColor("BrightText", "Default"),
					}),
				}),

				Title = Roact.createElement("TextLabel", {
					Position = UDim2.fromOffset(BAR_HEIGHT + PADDING, 0),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					LayoutOrder = 2,
					Size = UDim2.new(1, -BAR_HEIGHT, 0, BAR_HEIGHT),
					Text = props.Text,
					TextColor3 = theme:GetColor("BrightText", "Default"),
					TextXAlignment = Enum.TextXAlignment.Left,
					Font = FONT,
					TextSize = TEXT_SIZE,
					ZIndex = 2,
				}),
			})
		end,
	})
end

return IconListItem
