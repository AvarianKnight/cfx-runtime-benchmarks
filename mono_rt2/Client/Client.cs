using CitizenFX.Core;
using static CitizenFX.RedM.Native.Natives;

namespace CsClient
{
    public class ClientMain : BaseScript
    {
        public ClientMain() {
            AsyncFunction();
        }

        async Coroutine AsyncFunction()
        {
            int interationCount = 1000000;

            ProfilerEnterScope("Natives");
            int playerId = PlayerPedId();
            Vector3 coords = GetEntityCoords(playerId, true, true);

            for (int i = 0; i < interationCount; i++)
            {
                DrawMarker(0xD6445746, coords[0], coords[1], coords[2] + (10.0f / i), 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.3f, 0.2f, 0.15f, 30, 150, 30, 222, false, false, 0, true, null, null, false);
            }

            ProfilerExitScope();

            // string str = "";

            ProfilerEnterScope("Concat");

            // Disabled due to GC murdering the test
            // for (int i = 0; i < interationCount; i++)
            // {
            //     str = str + "a";
            // }

            ProfilerExitScope();

            var random = new Random();

            float x = (float)random.NextDouble() * 12000 - 6000;
            float y = (float)random.NextDouble() * 12000 - 6000;
            float z = (float)random.NextDouble() * 12000 - 6000;

            float x2 = (float)random.NextDouble() * 12000 - 6000;
            float y2 = (float)random.NextDouble() * 12000 - 6000;
            float z2 = (float)random.NextDouble() * 12000 - 6000;


            ProfilerEnterScope("Vector2 Math");

            {
                var pos1 = new Vector2(x, y);
                var pos2 = new Vector2(x2, y2);

                for (int i = 0; i < interationCount; i++)
                {
                    Vector2.Distance(ref pos1, ref pos2, out float dist);
                }

            }
            ProfilerExitScope();


            ProfilerEnterScope("Vector3 Math");


            {
                var pos1 = new Vector3(x, y, z);
                var pos2 = new Vector3(x2, y2, z2);

                for (int i = 0; i < interationCount; i++)
                {
                    Vector3.Distance(ref pos1, ref pos2, out float dist);
                }
            }


            ProfilerExitScope();


        }
    }
}
