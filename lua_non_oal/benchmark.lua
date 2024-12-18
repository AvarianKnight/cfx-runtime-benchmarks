local IS_FIVEM = GetGameName() == "fivem";

local GetEntityCoords = GetEntityCoords
local DrawMarker = DrawMarker
local GetEntityCoords = GetEntityCoords
local GetEntityForwardX = GetEntityForwardX
local CancelEvent = CancelEvent
local GetTimecycleVarCount = GetTimecycleVarCount


CreateThread(function()
	local iterationCount = GetConvarInt("benchmark_iterationCount", 1000000) + 1; -- no cheating >:(
	local useRuntimeOptimizations = GetConvarInt("benchmark_useRuntimeOptimizations", 0) == 1;

	local MARKER_TYPE = IS_FIVEM and 28 or 0xD6445746

	local playerPed = PlayerPedId()

	ProfilerEnterScope("Void Return type Natives")

	local coords = GetEntityCoords(playerPed);


	for i = 1, iterationCount do
		DrawMarker(MARKER_TYPE, coords, 0, 0, 0, 0, 0, 0, 0.2, 0.2, 0.15, 250, 0, 0, 255, false, false, 0, true, nil,
			nil, false);
	end

	ProfilerExitScope();

	ProfilerEnterScope("Number Return type Natives");


	for i = 1, iterationCount do
		GetEntityForwardX(playerPed)
	end

	ProfilerExitScope();

	ProfilerEnterScope("Vec return type natives");

	for i = 1, iterationCount do
		GetEntityCoords(playerPed);
	end

	ProfilerExitScope();
	ProfilerEnterScope("Void Cfx Return Type")

	for i = 1, iterationCount do
		CancelEvent()
	end

	ProfilerExitScope()


	ProfilerEnterScope("Number Cfx Return Type")

	for i = 1, iterationCount do
		local count = GetTimecycleVarCount()
	end

	ProfilerExitScope()


	ProfilerEnterScope("Concat")

	-- if not useRuntimeOptimizations then
	-- 	local str = ""
	-- 	for i = 1, interationCount do
	-- 		str = str .. "a"
	-- 	end
	-- else
	-- 	local str_tbl = {}
	-- 	for i = 1, interationCount do
	-- 		str_tbl[i] = "a"
	-- 	end
	-- 	local str = table.concat(str_tbl)
	-- end

	ProfilerExitScope()

	-- don't include in the actual benchmark
	local x = math.random() * 12000 - 6000
	local y = math.random() * 12000 - 6000
	local z = math.random() * 12000 - 6000

	local x2 = math.random() * 12000 - 6000
	local y2 = math.random() * 12000 - 6000
	local z2 = math.random() * 12000 - 6000

	ProfilerEnterScope("Vector2 Math")

	local pos1 = vector2(x, y)
	local pos2 = vector2(x2, y2)

	for i = 1, iterationCount do
		local dist = #(pos1 - pos2)
	end

	ProfilerExitScope()

	ProfilerEnterScope("Vector3 Math")


	local pos1 = vector3(x, y, z)
	local pos2 = vector3(x2, y2, z2)

	for i = 1, iterationCount do
		local dist = #(pos1 - pos2)
	end

	ProfilerExitScope()
end)
