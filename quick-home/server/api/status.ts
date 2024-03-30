export default defineEventHandler(async (event) => {

    let path = "/etc/quickHome/settings.json";
    if (process.env.QUICK_HOME_SETTINGS) {
        path = process.env.QUICK_HOME_SETTINGS;
    }

    return {
        path,
    };
})
