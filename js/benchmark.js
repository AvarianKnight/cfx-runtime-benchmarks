const getDistance2d = (c1, c2) => Math.sqrt((Math.pow(c1[0] - c2[0], 2)) + (Math.pow(c1[1] - c2[1], 2)));
const getDistance3d = (c1, c2) => Math.sqrt((Math.pow(c1[0] - c2[0], 2)) + (Math.pow(c1[1] - c2[1], 2)) + (Math.pow(c1[2] - c2[2], 2)));

const Delay = (ms) => new Promise((res) => setTimeout(res, ms));

let hitRecording = false

const IS_FIVEM = GetGameName() == "fivem";

setImmediate(() => {
    const interationCount = GetConvarInt("benchmark_iterationCount", 1_000_000)
    // doing any of the optimizations of other runtimes doesn't work in JS, +=
    // is the fastest in JS
    // const useRuntimeOptimizations = GetConvarInt("benchmark_useRuntimeOptimizations", 0) == 1;

    // FiveM/RedM have the same invocation method so we just want to change
    // the marker type
    const MARKER_TYPE = IS_FIVEM ? 28 : 0xD6445746;

    ProfilerEnterScope("Natives")

    const playerPed = PlayerPedId()
    const coords = GetEntityCoords(playerPed)


    for (let i = 0; i < interationCount; i++) {
        DrawMarker(MARKER_TYPE, coords[0], coords[1], coords[2], 0, 0, 0, 0, 0, 0, 0.2, 0.2, 0.15, 250, 0, 0, 255, false, false, 0, true, null, null, false);
    }

    ProfilerExitScope()

    ProfilerEnterScope("Concat")

    let str = "";
    for (let i = 0; i < interationCount; i++) {
        str += "a"
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

