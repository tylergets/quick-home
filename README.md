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
 * Dark mode
 * Theme Support

## Configuration (YAML)

```yaml
title: Hello World
subtitle: This is a subtitle
columns: 3
services:
  # used for shorthands
  url_template: https://$name$.example.com
items:
    # this is a shorthand for
    # - service: sonarr
    - sonarr
    - name: radarr
      icon: di:radarr
      url: https://radarr.example.com
      target: _blank

```

JSON is also supported.

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

```bash
docker run --rm -v /local/path/to/folder:/etc/quickHome -p 3000:3000 ghcr.io/tylergets/quick-home
```

### Docker Compose

```yaml
services:
  quick-home:
    image: ghcr.io/tylergets/quick-home
    volumes:
      - /local/path/to/folder:/etc/quickHome
    ports:
      - 3000:3000
```