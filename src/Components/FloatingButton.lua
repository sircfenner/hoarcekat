local Hoarcekat = script:FindFirstAncestor("Hoarcekat")

local Assets = require(Hoarcekat.Plugin.Assets)
local Roact = require(Hoarcekat.Vendor.Roact)
local StudioThemeAccessor = require(script.Parent.StudioThemeAccessor)

local e = Roact.createElement

local FloatingButton = Roact.Component:extend("FloatingButton")

function FloatingButton:init()
	self:setState({
		hovered = false,
		pressed = false,
	})
	self.onInputBegan = function(_, input)
		if input.UserInputType == Enum.UserInputType.MouseMovement then
			self:setState({ hovered = true })
		elseif input.UserInputType == Enum.UserInputType.MouseButton1 then
			self:setState({ pressed = true })
		end
	end
	self.onInputEnded = function(_, input)
		if input.UserInputType == Enum.UserInputType.MouseMovement then
			self:setState({ hovered = false })
		elseif input.UserInputType == Enum.UserInputType.MouseButton1 then
			self:setState({ pressed = false })
		end
	end
end

function FloatingButton:render()
	local props = self.props

	return e(StudioThemeAccessor, {}, {
		function(theme)
			local modifier = "Default"
			if self.state.pressed then
				modifier = "Pressed"
			elseif self.state.hovered then
				modifier = "Hover"
			end
			return e("ImageButton", {
				BackgroundTransparency = 1,
				Image = Assets.button_fill,
				ImageColor3 = theme:GetColor("DialogMainButton", modifier),
				Size = UDim2.new(props.Size, props.Size),

				[Roact.Event.InputBegan] = self.onInputBegan,
				[Roact.Event.InputEnded] = self.onInputEnded,
				[Roact.Event.Activated] = props.Activated,
			}, {
				Image = e("ImageLabel", {
					AnchorPoint = Vector2.new(0.5, 0.5),
					BackgroundTransparency = 1,
					Image = props.Image,
					Position = UDim2.fromScale(0.5, 0.5),
					Size = UDim2.new(props.ImageSize, props.ImageSize),
				}),
			})
		end,
	})
end

return FloatingButton
