import os from "os";
import osu from "node-os-utils";

export default defineEventHandler(async (event) => {

    const path = "/home/tyler/Development/quick-home/settings.json";
    const cpu = osu.cpu;
    const drive = osu.drive;
    const mem = osu.mem;
    var netstat = osu.netstat

    try {
        return {
            hostname: os.hostname(),
            openfiles: await osu.openfiles.openFd(),
            cpu: {
                usage: await cpu.usage(),
            },
            drive: {
                free: await drive.free(),
            },

            mem: {
                info: await mem.info(),
            },
        }
    } catch (e) {
        return {
            error: e,
            path,
            failed: true,
        }
    }

})
