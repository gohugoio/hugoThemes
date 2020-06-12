# How to generate Hugo's theme site

This document describes how to generate the Hugo theme site for different scenarios.

## Complete build

This script generates Hugo's theme site (as on [www.themes.gohugo.io](https://themes.gohugo.io/))
by downloading all added themes.

**Note:** Takes a long time and is requires a lot of disk space.

To test it locally, add the root of the baseUrl as first argument:

```bash
./generateThemeSite.sh http://localhost:1313
```

## Quick build for theme reviews / tests

To test a single theme use the `reviewTheme.sh` script. It uses a dedicated 
directory to store themes used to build Hugo's theme site. Thus, build time 
decreases significantly. By default, `./review` is used.

To test it locally, add the url to the Git repository that contains the to be
tested theme. **Optionally**, change the dedicated directory with flag `-t`.

Whitelist your theme in `./generateThemeSite.sh` if necessary.

```bash
./reviewTheme.sh <repo> -t <path>
```

Hugo's theme site will be served automatically at [http://localhost:1313](http://localhost:1313).

## Environment variables

To alter the Hugo themes repository used (contains all themes to display),
provide a value for the environment variable `HUGO_THEMES_REPO`.

```bash
HUGO_THEMES_REPO=<repo> ./generateThemeSite.sh http://localhost:1313
```

To alter the Hugo theme site repository used, provide a value for the
environment variable `HUGO_THEME_SITE_REPO`.

```bash
HUGO_THEME_SITE_REPO=<repo> ./generateThemeSite.sh http://localhost:1313
```

To alter the Hugo example site repository used, provide a value for the
environment variable `HUGO_EXAMPLE_SITE_REPO`.

```bash
HUGO_EXAMPLE_SITE_REPO=<repo> ./generateThemeSite.sh http://localhost:1313
```
