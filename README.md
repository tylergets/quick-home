# Quick Home

Highly opinionated dashboard for your home server. Inspired by all the existing solutions, but made to be quicker to manage.

## Features
 * YAML/JSON Configuration
 * Integrates with Dashboard Icons
 * Search w/ Keyboard Shortcuts
 * Shows basic system stats

### Future Features
 * Groupings
 * Tabs / Multiple Pages

## Configuration (JSON)

```json
{
  "title": "Hello World",
  "subtitle": "This is a subtitle",
  "columns": 3,
  "services": {
    // used with shorthand
    "url_template": "https://$name$.example.com"
  },
  "items": [
    "sonarr", // shorthand for {"service": "sonarr" }
    // full example
    {
      "name": "radarr",
      "icon": "di:radarr",
      "url": "https://radarr.example.com",
      "target": "_blank"
    }
  ]
}
```

YAML is also supported.

## Install (Nixos)

Add the repo to your flake inputs and import the module

```nix
quick-home.url = "github:tylergets/quick-home";
```

import the module
```nix
quick-home.nixosModules.quick-home
```

then enable the service
```nix
services.quickHome = {
    enable = true;
    port = 8281;
    host = "0.0.0.0";
    settings = {}; # See Configuration above
};
```

## Install (Docker)

Coming soon