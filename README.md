This is some benchmarking to test the performance of the different runtimes in Cfx

It should be noted that C# could not finish the string concatenation test because of it frequently trying to do stop-the-world garbage collection because every concatenation would create a new string object.

All of these tests were done with 1,000,000 iterations

| Client | Lua OAL | Lua | JS | C# rt2 |
|--- | --- | --- | --- | ---|
| Void Return Types | 206.68ms | 328.61ms | 349.68ms | 176.00ms |
| Number Return Types | 144.49ms | 143.23ms | 209.47ms | 104.10ms |
| Vec Return Type | 137.70ms | 142.76ms | 521.45ms | 113.79ms |
| Cfx Void Return Type | 16.28ms | 40.97ms | 40.22ms | 14.34ms |
| Cfx Number Return Type | 16.43ms | 47.51ms | 71.28ms | 14.27ms |
| Concatenation | 16.8s  | 16.8s | 180.97ms | DNF |
| 2D Distance | 16.5ms | 16.5ms | 6.62ms | 4.19ms |
| 3D Distance | 17.37ms | 17.37ms | 6.26ms | 4.34ms |


All of these tests were done with 10,000 iterations

| Client | Lua OAL | Lua | JS | C# rt2 |
|--- | --- | --- | --- | ---|
| Void Return Types | 2.15ms | 3.45ms | 7.13ms | 2.37ms |
| Number Return Types | 1.50ms | 1.48ms | 3.59ms | 1.12ms |
| Vec Return Type | 1.42ms | 1.53ms | 6.80ms | 1.20ms |
| Cfx Void Return Type | 0.16ms | 0.41ms | 0.98ms | 0.20ms |
| Cfx Number Return Type | 0.17ms | 0.48ms | 1.34ms | 0.20ms |
| Concatenation | 1.80ms  | 1.89ms | 4.72ms | 40.83ms |
| 2D Distance | 0.17ms | 0.17ms | 1.09ms | 0.11ms |
| 3D Distance | 0.18ms | 0.18ms | 1.03ms | 65µs |


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


### NOTE: These tests were done on RedM, in order to get OAL to work on RedM I had to do a custom build since it looks to have been forgotten about, this shouldn't impact the tests.

The basic way these benchmarks where done was:

1. Put `profiler record 500` in the client console
2. `ensure [resource-name]`
3. Wait for the the profiler to finish
4. `profiler view`
5. Results!
