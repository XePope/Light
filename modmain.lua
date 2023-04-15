local _G = GLOBAL
local STRINGS = _G.STRINGS
local Ingredient = _G.Ingredient
local RECIPETABS = _G.RECIPETABS
local TECH = _G.TECH

local Craft = GetModConfigData("Craft")
_G.MYLIGHT_CRAFT = Craft

local Language = GetModConfigData("Language")

PrefabFiles = {
	"mylight",
}

if Language == 'Cn' then
	STRINGS.NAMES.MYLIGHT = "电灯"
	STRINGS.RECIPE_DESC.MYLIGHT = "点亮夜空."
	STRINGS.CHARACTERS.GENERIC.DESCRIBE.MYLIGHT = {"它会在白天吸收太阳能 ！"}
else
	STRINGS.NAMES.MYLIGHT = "Light"
	STRINGS.RECIPE_DESC.MYLIGHT = "For life."
	STRINGS.CHARACTERS.GENERIC.DESCRIBE.MYLIGHT = {"This is a Light."}
end

local makings = nil
if Craft == 'Easy' then
	makings = { Ingredient("fireflies", 1), Ingredient("transistor", 2), Ingredient("boards", 1) }
elseif Craft == 'Normal' then
	makings = { Ingredient("lightbulb", 1), Ingredient("transistor", 2), Ingredient("lightninggoathorn", 1) }
else
	makings = { Ingredient("dragon_scales", 1), Ingredient("transistor", 2), Ingredient("lightninggoathorn", 1) }
end

AddRecipe2( "mylight", makings, TECH.NONE, { image = "mylight.tex", atlas = "images/inventoryimages/mylight.xml", placer="mylight_placer"}, {"PROTOTYPERS","LIGHT","DECOR"})