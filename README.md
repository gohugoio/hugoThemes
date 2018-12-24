
# Hugo themes

A collection of all themes that were created by the Hugo community. See a complete listing of all of these themes along with screenshots and demos at [themes.gohugo.io](https://themes.gohugo.io/). Every theme in this list will automatically be added to the theme site. Theme updates aren't scheduled but usually happen at least once a week.

## Build script

For the curious,
[here’s how](buildThemeSite.sh)
this automatic adding is accomplished.

# Installation

## Installing all themes

If you would like to install all of the available Hugo themes, simply clone the entire repository from within your working directory with this command:

    git clone --depth 1 --recursive https://github.com/gohugoio/hugoThemes.git themes

## Installing a single theme

<pre><code>cd themes
git clone <em>URL_TO_THEME</em>
</code></pre>

# Adding a theme to the list

* Create your theme using <code>hugo new theme <em>THEMENAME</em></code>;
* Test your theme against https://github.com/gohugoio/HugoBasicExample;
* Add a `theme.toml` file to the root of the theme and add some metadata about the theme;
* Add a descriptive `README.md` to the root of the theme;
* Add `/images/screenshot.png` and `/images/tn.png` ([see below](#media));
* Open up a new **issue** with a link to the theme's repository on GitHub. Please **DO NOT** open a pull request!

If your theme doesn't fit into the `Hugo Basic Example` site, we encourage theme authors to supply a self-contained Hugo site in `/exampleSite`.

**NOTE:** The folder name here is important, as this folder will be picked up and used by the script that generates the Hugo Theme Site. It mirrors the root directory of a Hugo website and allows you to add custom content, assets and a config file with preset values.

**NOTE:** Most of the themes in this repo are hosted on GitHub. We also include themes hosted on GitLab and similar, but we do not add themes living on a self-hosted repository.

See [Artist theme's exampleSite](https://github.com/digitalcraftsman/hugo-artists-theme/tree/master/exampleSite) for a good example. And please make the site's content as neutral as possible.

Each theme needs:

1. To be added to the hugoThemes repo;
1. To have the right fields in `theme.toml`;
1. To have the right images;
1. A good README;
1. To include the `resources` folder if it's using [Hugo Pipes](https://gohugo.io/hugo-pipes) to process assets;
1. To have `https://example.com` as base url in `exampleSite/config.{toml, yaml, json}` to avoid the [abuse of unused domains](https://github.com/gohugoio/hugo/issues/2575).

## theme.toml

This file contains metadata about the theme and its creator. **Only `theme.toml` is accepted, not `theme.yaml` or not `theme.json`**. The following fields are required:

```toml
name = "Theme Name"
license = "MIT"
licenselink = "Link to theme's license"
description = "Theme description"
homepage = "Website of your theme"
tags = ["blog", "company"]
features = ["some", "awesome", "features"]
min_version = 0.38

[author]
    name = "Your name"
    homepage = "Your website"

# If porting an existing theme
[original]
    author = "Name of original author"
    homepage = "His/Her website"
    repo = "Link to source code of original theme"
```

## Media

Screenshots are used as preview in the list. Make sure that they have the right dimensions:

* Thumbnail should be 900×600 in pixels
* Screenshot should be 1500×1000 in pixels
* Media must be located in:
    * <code><em>[ThemeDir]</em>/images/screenshot.png</code>
    * <code><em>[ThemeDir]</em>/images/tn.png</code>

Additional media may be provided in that same directory.

## README.md

Your theme's README file
(which should be written in Markdown and called `README.md`)
serves a double purpose.
This is because its content will appear in two places&mdash;i.e., it will appear:

1. On your theme's details page at [themes.gohugo.io](https://themes.gohugo.io/); and
1. At GitHub (as usual), on your theme's regular main page.

**Note:** If you add screenshots to the README please make use of absolute file paths instead of relative ones like `/images/screenshot.png`. Relative paths work great on GitHub but they don't correspond to the directory structure of [themes.gohugo.io](https://themes.gohugo.io/). Therefore, browsers will not be able to display screenshots on the theme site under the given (relative) path.

## Resources

If your theme makes use of the [Hugo Pipes](https://gohugo.io/hugo-pipes) methods `toCSS` and / or `PostCSS`, you need to take additional steps to make your theme compatible with the basic version of Hugo:

- From the root of a Hugo project that uses your theme execute the command `hugo server` -this will generate the `/resources/` folder under the project root-.
- Or if you prefer to build the project simply run the command `hugo` -this will generate the resources under `public/resources`-.
- Copy the generated resources folder and commit it directly under the root of your theme's repository.

## Common Permalink Issues

The demo of your theme will be available in a subdirectory of the [Hugo Themes website](https://themes.gohugo.io/) and you need to make sure of the following:

- If using inline styles, these need to use absolute URLs, for the linked assets to be served properly, e.g. `<div style="background: url('{{ "images/background.jpg" | absURL }}')">`
- Make sure not to use a forward slash `/` in the beginning of a `URL`, because it will point to the host root and Hugo will not generate the correct `URL` for the demo's assets.
- If using external CSS and JS from a CDN, make sure to load these assets over `https`. Please do not use relative protocol URLs in your theme's templates.

## Testing a theme with the Hugo Themes website Build Script

To test your theme with the Hugo Themes Site Build Script locally:
- Clone this repo
- Add your theme from the root of the cloned repo with: `git submodule add --recursive <URL of your theme's repo>`
- Navigate to the `_script/` directory e.g.`cd _script/`
- Then execute: `./generateThemeSite.sh http://localhost:1313 && hugo server -w=false -s hugoThemeSite/themeSite`
- Open `localhost:1313` in your browser and navigate to the theme.
- If your theme demo is not generated you can create an error report with: `./generateThemeSite.sh > errors.txt`
