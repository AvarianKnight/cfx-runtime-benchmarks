using System.Text;
using CitizenFX.Core;

#if IS_REDM
using static CitizenFX.RedM.Native.Natives;
#else
using static CitizenFX.FiveM.Native.Natives;
#endif

namespace CsClient
{
    public class ClientMain : BaseScript
    {
        public ClientMain()
        {
            Benchmark();
        }

        async Coroutine Benchmark()
        {
            int interationCount = GetConvarInt("benchmark_iterationCount", 1_000_000);
            bool useRuntimeOptimizations = GetConvarInt("benchmark_useRuntimeOptimizations", 0) == 1;

            ProfilerEnterScope("Natives");
            int playerPed = PlayerPedId();
#if IS_REDM
            Vector3 coords = GetEntityCoords(playerId, false, true);
#else
            Vector3 coords = GetEntityCoords(playerPed, false);
#endif

#if IS_REDM
            const u32 MARKER_TYPE = 0xD6445746;
#else
            const int MARKER_TYPE = 28;
#endif

            for (int i = 0; i < interationCount; i++)
            {
                DrawMarker(MARKER_TYPE, coords.X, coords.Y, coords.Z, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.3f, 0.2f, 0.15f, 30, 150, 30, 222, false, false, 0, true, null, null, false);
            }

            ProfilerExitScope();


            ProfilerEnterScope("Concat");

            //Disabled due to GC murdering the test
            if (!useRuntimeOptimizations)
            {
                // string str = "";
                // if (interationCount <= 10000)
                // {
                //     for (int i = 0; i < interationCount; i++)
                //     {
                //         str += "a";
                //     }
                // }
            }
            else
            {
                StringBuilder strBuilder = new();
                for (int i = 0; i < interationCount; i++)
                {
                    // we could do str.Append("a", iterationCount); but this
                    // would kind of be cheating
                    strBuilder.Append("a");
                }
                String str = strBuilder.ToString();
            }

            ProfilerExitScope();

            var random = new Random();

            float x = (float)random.NextDouble() * 12000 - 6000;
            float y = (float)random.NextDouble() * 12000 - 6000;
            float z = (float)random.NextDouble() * 12000 - 6000;

            float x2 = (float)random.NextDouble() * 12000 - 6000;
            float y2 = (float)random.NextDouble() * 12000 - 6000;
            float z2 = (float)random.NextDouble() * 12000 - 6000;



            {
                ProfilerEnterScope("Vector2 Math");
                var pos1 = new Vector2(x, y);
                var pos2 = new Vector2(x2, y2);

                for (int i = 0; i < interationCount; i++)
                {
                    Vector2.Distance(ref pos1, ref pos2, out float dist);
                }

                ProfilerExitScope();
            }


            {
                ProfilerEnterScope("Vector3 Math");
                var pos1 = new Vector3(x, y, z);
                var pos2 = new Vector3(x2, y2, z2);

                for (int i = 0; i < interationCount; i++)
                {
                    Vector3.Distance(ref pos1, ref pos2, out float dist);
                }
                ProfilerExitScope();
            }

        }
    }
}
