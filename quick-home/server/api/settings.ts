import * as fs from "fs";
import {serializeError, deserializeError} from 'serialize-error';

String.prototype.toProperCase = function () {
    return this.replace(/\w\S*/g, function(txt){return txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase();});
};

export default defineEventHandler(async (event) => {

    // TODO Move to a function
    let path = "/etc/quickHome/settings.json";
    if (process.env.QUICK_HOME_SETTINGS) {
        path = process.env.QUICK_HOME_SETTINGS;
    }

    try {
        let data = await fs.promises.readFile(path, "utf-8").then((d) => JSON.parse(d));

        if (data.items) {
            data.items = data.items.map((item) => {

                if(typeof item === "string") {
                    item = {
                        service: item,
                    }
                }

                if(item.service) {
                    const url = data.services.url_template.replace('$name$', item.service);
                    // we need to add the service as the subdomain

                    item = {
                        name: item.service.toProperCase(),
                        url,
                        icon: `di:${item.service}`,
                        ...data.services,
                        ...item,
                    }
                }

                if (item.icon.startsWith("di:")) {
                    const name = item.icon.replace("di:", "");
                    item.icon = `https://raw.githubusercontent.com/walkxcode/dashboard-icons/main/png/${name}.png`
                }

                return {
                    ...item,
                };
            });
        }

        return data;
    } catch (e) {
        console.log(e);
        return {
            error: serializeError(e),
            path,
            failed: true,
        }
    }

})
