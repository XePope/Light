require "prefabutil"

local assets =
{
	Asset("ANIM", "anim/mylight.zip"),
}

local name = "Light"

local folder = KnownModIndex:GetModActualName(name)

local Efficient = GetModConfigData("Efficient", folder)
local TriggerRange = tonumber(GetModConfigData("TriggerRange", folder))

local PlayerFarDist = 15 * TriggerRange

local function onworkfinished(inst)
    inst.components.lootdropper:DropLoot()
    local fx = SpawnPrefab("collapse_small")
    fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
    fx:SetMaterial("wood")
    inst:Remove()
end


local function onhit(inst, worker)
	inst.Light:Enable(false)
end


local function onbuilt(inst)
	inst.AnimState:PlayAnimation("place")
end


local function turn_on(inst)
	inst.AnimState:PlayAnimation("idle")
	inst.lightson = true
	inst.Light:Enable(true)
end


local function turn_off(inst)
	inst.AnimState:PlayAnimation("place")
	inst.lightson = false
	inst.Light:Enable(false)
end


local function onoccupiedlighttask(inst)
	if inst.lightson then
		if TheWorld.state.phase == "day" then
			inst:DoTaskInTime(3.0,turn_off)
		elseif	TheWorld.state.phase == "dusk" then
			turn_off(inst)
		elseif TheWorld.state.isfullmoon then
			turn_off(inst)
		end
	else
		local conditionNight = TheWorld.state.phase == "night" and (not TheWorld.state.isfullmoon)
		local conditionPlayer = inst.count_player > 0
		if conditionNight and (conditionPlayer  or Efficient == "No") then
			turn_on(inst)
		end
	end
end


local function player_increment(inst)
	inst.count_player = inst.count_player + 1
	if TheWorld.state.phase == "night" and (not TheWorld.state.isfullmoon) then
		turn_on(inst)
	end
end


local function player_decrement(inst)
	inst.count_player = inst.count_player - 1
	if inst.count_player <= 0 then
		inst.count_player = 0
		if Efficient == "Yes" then
			turn_off(inst)
		end
	end
end


local function fn(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
	inst.entity:AddNetwork()

	MakeObstaclePhysics(inst, .1) -- 物理障碍

	local light = inst.entity:AddLight()
    light:SetFalloff(1)
    light:SetIntensity(.8)
    light:SetRadius(10 * TriggerRange)
    light:SetColour(255/85, 255/85, 255/85)
	light:Enable(false)

	inst:AddTag("structure")
	inst.AnimState:SetBank("mylight")
	inst.AnimState:SetBuild("mylight")
	inst.AnimState:PlayAnimation("place")

	--MakeSnowCoveredPristine(inst)
	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
			return inst
	end

	inst:AddComponent("inspectable")
	
	-- 设置掉落
	inst:AddComponent("lootdropper")

	inst:AddComponent("workable")
	inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
	inst.components.workable:SetWorkLeft(4)
	inst.components.workable:SetOnFinishCallback(onworkfinished)
	inst.components.workable:SetOnWorkCallback(onhit)
	-- AddHauntableDropItemOrWork(inst)

	-- 启用玩家靠近触发
	inst.count_player = 0
	inst:AddComponent("playerprox")
	inst.components.playerprox:SetDist(5, PlayerFarDist)
    inst.components.playerprox:SetOnPlayerNear(player_increment)
	inst.components.playerprox:SetOnPlayerFar(player_decrement)

    inst:ListenForEvent("onbuilt", onbuilt)

	-- 启用智能灯
	inst:ListenForEvent("clocktick", function() onoccupiedlighttask(inst) end, TheWorld)

	-- 让鬼魂也生效
	MakeHauntableWork(inst)

	--MakeSnowCovered(inst)
    --MakeSmallBurnable(inst, nil, nil, true)
    --MakeMediumPropagator(inst)

	return inst
end


return Prefab( "mylight", fn, assets, prefabs),
	MakePlacer("mylight_placer", "mylight", "mylight", "place")