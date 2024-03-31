import * as fs from "fs";
import {serializeError, deserializeError} from 'serialize-error';
import os from "os";
import {getSettingsPath} from "~/helpers";
import YAML from 'yaml'

String.prototype.toProperCase = function () {
    return this.replace(/\w\S*/g, function(txt){return txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase();});
};

export default defineEventHandler(async (event) => {

    try {
        const path = getSettingsPath();
        if (!path) {
            console.log("No settings file found");
            return {
                error: "No settings file found",
                failed: true,
                path,
            }

        } else {
            console.log("Settings file found at: ", path);
        }

        let data = await fs.promises.readFile(path, "utf-8").then((d) => YAML.parse(d));

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
        } else {
            return {
                failed: true,
                error: "No items found in settings file",
                path,
            }
        }
        return {
            ...data,
            path
        };
    } catch (e) {
        console.log(e);
        throw e;
        // return {
        //     error: serializeError(e),
        //     path,
        //     failed: true,
        // }
    }

})
