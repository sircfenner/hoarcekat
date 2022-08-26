local Hoarcekat = script:FindFirstAncestor("Hoarcekat")

local Assets = require(Hoarcekat.Plugin.Assets)
local FitComponent = require(script.Parent.FitComponent)
local IconListItem = require(script.Parent.IconListItem)
local Roact = require(Hoarcekat.Vendor.Roact)

local e = Roact.createElement

local Collapsible = Roact.Component:extend("Collapsible")

local OFFSET = 8

function Collapsible:init()
	self:setState({
		open = true,
	})

	self.toggle = function()
		self:setState({
			open = not self.state.open,
		})
	end
end

function Collapsible:render()
	local content = self.state.open and self.props[Roact.Children]

	return e(FitComponent, {
		FitWidth = true,
		ContainerClass = "Frame",
		ContainerProps = {
			BackgroundTransparency = 1,
		},
		LayoutClass = "UIListLayout",
		LayoutProps = {
			SortOrder = Enum.SortOrder.LayoutOrder,
		},
	}, {
		Topbar = e(IconListItem, {
			Activated = self.toggle,
			Icon = self.state.open and Assets.collapse_down or Assets.collapse_right,
			Text = self.props.Title,
		}),

		Content = content and e(FitComponent, {
			FitWidth = true,
			ContainerClass = "Frame",
			ContainerProps = {
				BackgroundTransparency = 1,
				Position = UDim2.fromOffset(OFFSET, 0),
			},
			LayoutClass = "UIListLayout",
			ExtraSize = Vector2.new(OFFSET, 0),
		}, {
			UIPadding = e("UIPadding", {
				PaddingLeft = UDim.new(0, OFFSET),
			}),

			Content = Roact.createFragment(content),
		}),
	})
end

return Collapsible
