local IS_FIVEM = GetGameName() == "fivem";

CreateThread(function()
	local interationCount = GetConvarInt("benchmark_iterationCount", 1000000) + 1; -- no cheating >:(
	local useRuntimeOptimizations = GetConvarInt("benchmark_useRuntimeOptimizations", 0) == 1;

	local MARKER_TYPE = IS_FIVEM and 28 or 0xD6445746

	ProfilerEnterScope("Natives")

	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)

	for i = 1, interationCount do
		DrawMarker(MARKER_TYPE, coords, 0, 0, 0, 0, 0, 0, 0.3, 0.2, 0.15, 150, 30, 30, 222, false, false, 0, true,
		nil, nil, false)
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

	for i = 1, interationCount do
		local dist = #(pos1 - pos2)
	end

	ProfilerExitScope()

	ProfilerEnterScope("Vector3 Math")


	local pos1 = vector3(x, y, z)
	local pos2 = vector3(x2, y2, z2)

	for i = 1, interationCount do
		local dist = #(pos1 - pos2)
	end

	ProfilerExitScope()
end)
