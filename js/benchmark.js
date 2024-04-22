
const getDistance2d = (c1, c2) => Math.sqrt((Math.pow(c1[0] - c2[0], 2)) + (Math.pow(c1[1] - c2[1], 2)));
const getDistance3d = (c1, c2) => Math.sqrt((Math.pow(c1[0] - c2[0], 2)) + (Math.pow(c1[1] - c2[1], 2)) + (Math.pow(c1[2] - c2[2], 2)));

setImmediate(() => {
	const interationCount = 1000000

	ProfilerEnterScope("Natives")

	const playerPed = PlayerPedId()
	const coords = GetEntityCoords(playerPed)

	for (let i = 0; i < interationCount; i++) {
		DrawMarker(0xD6445746, coords.x, coords.y, coords.z + (i * 0.1), 0, 0, 0, 0, 0, 0, 0.3, 0.2, 0.15, 150, 30, 30, 222, false, false, 0, true, null, null, false)
	}

	ProfilerExitScope()

	ProfilerEnterScope("Concat")

	let a = "";
	for (let i = 0; i < interationCount; i++) {
		a = a + "a"
	}

	ProfilerExitScope()

	// don't include in the actual benchmark
	const x = Math.random() * 12000 - 6000
	const y = Math.random() * 12000 - 6000
	const z = Math.random() * 12000 - 6000

	const x2 = Math.random() * 12000 - 6000
	const y2 = Math.random() * 12000 - 6000
	const z2 = Math.random() * 12000 - 6000

	{
		ProfilerEnterScope("Vector2 Math")

		const pos1 = [x, y]
		const pos2 = [x2, y2]

		for (let i = 0; i < interationCount; i++) {
			const dist = getDistance2d(pos1, pos2)
		}

		ProfilerExitScope()
	}

	{
		ProfilerEnterScope("Vector3 Math")

		const pos1 = [x, y, z]
		const pos2 = [x2, y2, z2]

		for (let i = 0; i < interationCount; i++) {
			const dist = getDistance3d(pos1, pos2)
		}

		ProfilerExitScope()
	}

})

