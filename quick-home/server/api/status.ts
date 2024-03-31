import {getPossiblePaths, getSettingsPath} from "~/helpers";

export default defineEventHandler(async (event) => {

    let path = getSettingsPath();

    return {
        possible: getPossiblePaths(),
        path,
    };
})
