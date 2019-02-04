--The name of the mod displayed in the 'mods' screen.
name = "Light"
--A version number so you can ask people if they are running an old version of your mod.
version = "0.10.0"

--A description of the mod.
description = "圣灯，靠近自动点燃、远离自动灭，不想要时用锤子砸毁即可！"

--Who wrote this awesome mod?
author = "hewei"

--This lets other players know if your mod is out of date. This typically needs to be updated every time there's a new game update.
api_version = 10
dst_compatible = true
api_version_dst = 10
dont_starve_compatible = true
reign_of_giants_compatible = true
shipwrecked_compatible = true


--This lets clients know if they need to get the mod from the Steam Workshop to join the game
all_clients_require_mod = true

--This determines whether it causes a server to be marked as modded (and shows in the mod list)
client_only_mod = false

--This lets people search for servers with this mod by these tags
server_filter_tags = {"圣灯","Light","hewei"}

icon_atlas = "icon.xml"
icon = "icon.tex"
forumthread = "https://github.com/losswei"
----------------------

local language = "cn"
local chinese = language == "cn"

configuration_options =
{
	{
		name = "Craft",
		label = chinese and "制造" or "Craft",
		options =
			{
				{description = chinese and "简单" or "Easy", data = "Easy"},
				{description = chinese and "普通" or "Normal", data = "Normal"},
				{description = chinese and "困难" or "Hard", data = "Hard"},
			},
		default = "Easy",
	},
	{
		name = "Efficient",
		label = chinese and "节能(远离关闭)" or "Efficient",
		options =
			{
				{description = chinese and "是" or "Yes", data = "Yes"},
				{description = chinese and "否" or "No", data = "No"},
			},
		default = "Yes",
	},
	{
		name = "TriggerRange",
		label = chinese and "触发距离" or "TriggerRange",
		options =
			{
				{description = chinese and "普通" or "Normal", data = "1"},
				{description = chinese and "大" or "Large", data = "2"},
				{description = chinese and "超大" or "Huge", data = "3"},
			},
		default = "1",
	},
	{
		name = "Language",
		label = chinese and "语言" or "Language",
		options =
			{
				{description = chinese and "中文" or "English", data = "Cn"},
				{description = "English", data = "En"},
			},
		default = "Cn",
	},
}
