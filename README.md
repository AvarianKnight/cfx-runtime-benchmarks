This is some benchmarking to test the performance of the different runtimes in FiveM

It should be noted that C# could not finish the string concatenation test because of it frequently trying to do stop-the-world garbage collection.

All of these tests were done with 1,000,000 iterations

| Client | Lua OAL | Lua | JS | C# rt2 |
|--- | --- | --- | --- | ---|
| Concatenation | 16.8s  | 16.8s | 180.97ms | - |
| 2D Distance | 180.99ms  | 178.83ms  | 33.23ms | 4.16ms |
| 3D Distance | 184.48ms  | 183.60ms |  33.34ms | 6.71ms |
| Native Execution | 198.71ms | 637.99ms | 697.24 | 86.58ms |

### NOTE: These tests were done on RedM, in order to get OAL to work on RedM I had to do a custom build since it looks to have been forgotten about, this shouldn't impact the tests.

The basic way these benchmarks where done was:

1. Put `profiler record 500` in the client console
2. `ensure [resource-name]`
3. Wait for the the profiler to finish
4. `profiler view`
5. Results!
