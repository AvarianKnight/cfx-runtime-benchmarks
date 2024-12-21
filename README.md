This is some benchmarking to test the performance of the different runtimes in Cfx

It should be noted that C# could not finish the string concatenation test because of it frequently trying to do stop-the-world garbage collection because every concatenation would create a new string object.

All of these tests were done with 1,000,000 iterations

| Client | Lua | JS | C# rt2 | Lua OAL |
|--- | --- | --- | --- | ---|
| Void Return Types | 328.61ms | 349.68ms | 176.00ms | 206.68ms |
| Number Return Types | 143.23ms | 209.47ms | 104.10ms | 144.49ms |
| Vec Return Type | 142.76ms | 521.45ms | 113.79ms | 137.70ms |
| Cfx Void Return Type | 40.97ms | 40.22ms | 14.34ms | 16.28ms |
| Cfx Number Return Type | 47.51ms | 71.28ms | 14.27ms | 16.43ms |
| Concatenation | 16.8s | 180.97ms | DNF |  16.8s |
| 2D Distance | 16.5ms | 6.62ms | 4.19ms | 16.5ms |
| 3D Distance | 17.37ms | 6.26ms | 4.34ms | 17.37ms |


All of these tests were done with 10,000 iterations

| Client | Lua | JS | C# rt2 | Lua OAL | 
|--- | --- | --- | --- | ---|
| Void Return Types | 3.45ms | 7.13ms | 2.37ms | 2.15ms | 
| Number Return Types | 1.48ms | 3.59ms | 1.12ms | 1.50ms |
| Vec Return Type | 1.53ms | 6.80ms | 1.20ms | 1.42ms | 
| Cfx Void Return Type | 0.41ms | 0.98ms | 0.20ms | 0.16ms |
| Cfx Number Return Type | 0.48ms | 1.34ms | 0.20ms |  0.17ms |
| Concatenation | 1.89ms | 4.72ms | 40.83ms | 1.80ms |
| 2D Distance | 0.17ms | 1.09ms | 0.11ms | 0.17ms | 
| 3D Distance | 0.18ms | 1.03ms | 65µs |  0.18ms |


All of these tests were done with 1,000,000 iterations with the optimized way to concatenate a large amount of strings in the specific runtime.

For C# this would be using `StringBuilder`, in Lua this would be adding all the string to a table and using `table.concat`

JS does not have an equivelent optimization (hence why its the slowest here)


| Client | Lua | JS | C# rt2 | Lua OAL | 
|--- | --- | --- | --- | ---|
| Concatenation | 61.52ms | 180.97ms | 4.71ms | 61.52ms | 


All of these tests were done with 10,000 iterations with the optimized way to concatenate a large amount of strings in the specific runtime.

| Client | Lua | JS | C# rt2 | Lua OAL | 
|--- | --- | --- | --- | ---|
| Concatenation | 0.81ms | 5.34ms | 0.42ms | 0.81ms |


### NOTE: These tests were done on RedM, in order to get OAL to work on RedM I had to do a custom build since it looks to have been forgotten about, this shouldn't impact the tests.

The basic way these benchmarks where done was:

1. Put `profiler record 500` in the client console
2. `ensure [resource-name]`
3. Wait for the the profiler to finish
4. `profiler view`
5. Results!
