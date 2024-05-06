import os from "os";
import fs from "fs";

export function getPossiblePaths() {
    let possiblePaths = [
        process.env.QUICK_HOME_SETTINGS ?? null,
        os.homedir() + "/.config/quickHome/settings.{json,yaml,yml}",
        os.homedir() + "/.quickHome/settings.{json,yaml,yml}",
        "/etc/quickHome/settings.{json,yaml,yml}",
        "settings.json"
    ].filter((path) => !!path);

    possiblePaths = possiblePaths.flatMap((path) => {
        if (path.includes("{")) {
            const [start, end] = path.split("{");
            const extensions = end.split("}")[0].split(",");
            return extensions.map((ext) => start + ext);
        }
        return path;
    })

    return possiblePaths;
}
export function getSettingsPath() {

    for (const path of getPossiblePaths()) {
        if (path && fs.existsSync(path)) {
            return path;
        }
    }

    return null;
}