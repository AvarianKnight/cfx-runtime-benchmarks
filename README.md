This is some benchmarking to test the performance of the different runtimes in Cfx

It should be noted that C# could not finish the string concatenation test because of it frequently trying to do stop-the-world garbage collection because every concatenation would create a new string object.

All of these tests were done with 1,000,000 iterations

| Client | Lua OAL | Lua | JS | C# rt2 |
|--- | --- | --- | --- | ---|
| Native Execution | 198.71ms | 637.99ms | 697.24ms | 86.58ms |
| Concatenation | 16.8s  | 16.8s | 180.97ms | DNF |
| 2D Distance | 180.99ms  | 178.83ms  | 33.23ms | 4.16ms |
| 3D Distance | 184.48ms  | 183.60ms |  33.34ms | 6.71ms |


All of these tests were done with 10,000 iterations

| Client | Lua OAL | Lua | JS | C# rt2 |
|--- | --- | --- | --- | ---|
| Native Execution | 2.40ms | 6.19ms | 48.15ms | 1.59ms |
| Concatenation | 1.80ms  | 1.89ms | 4.72ms | 40.83ms |
| 2D Distance | 1.89ms  | 2.43ms | 15.99ms | 0.13ms |
| 3D Distance | 1.91ms  |  1.86ms | 15.87ms | 90µs |


All of these tests were done with 1,000,000 iterations with the optimized way to concatenate a large amount of strings in the specific runtime.

For C# this would be using `StringBuilder`, in Lua this would be adding all the string to a table and using `table.concat`

JS does not have an equivelent optimization (hence why its the slowest here)


| Client | Lua OAL | Lua | JS | C# rt2 |
|--- | --- | --- | --- | ---|
| Concatenation | 61.52ms | 61.52ms | 180.97ms | 4.71ms |


All of these tests were done with 10,000 iterations with the optimized way to concatenate a large amount of strings in the specific runtime.

| Client | Lua OAL | Lua | JS | C# rt2 |
|--- | --- | --- | --- | ---|
| Concatenation | 0.81ms | 0.81ms | 5.34ms | 0.42ms |


### NOTE: These tests were done on RedM.

The basic way these benchmarks where done was:

1. Put `profiler record 500` in the client console
2. `ensure [resource-name]`
3. Wait for the the profiler to finish
4. `profiler view`
5. Results!
