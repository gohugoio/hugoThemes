# hugoThemeSiteScript
Script to generate Hugo's Theme Site

To test it locally, add the root of the baseUrl as first argument:

```
./generateThemeSite.sh http://localhost:1313
```

To alter the Hugo themes repository used (contains all themes to display),
provide a value for the environment variable `HUGO_THEMES_REPO`.

```
HUGO_THEMES_REPO=<repo> ./generateThemeSite.sh http://localhost:1313
```

To alter the Hugo theme site repository used, provide a value for the
environment variable `HUGO_THEME_SITE_REPO`.

```
HUGO_THEME_SITE_REPO=<repo> ./generateThemeSite.sh http://localhost:1313
```

To alter the Hugo example site repository used, provide a value for the
environment variable `HUGO_EXAMPLE_SITE_REPO`.

```
HUGO_EXAMPLE_SITE_REPO=<repo> ./generateThemeSite.sh http://localhost:1313
```

