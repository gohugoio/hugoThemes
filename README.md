This repository is replaced by https://github.com/gohugoio/hugoThemesSiteBuilder


[![Netlify Status](https://api.netlify.com/api/v1/badges/58968044-3238-424c-b9b6-e0d00733890c/deploy-status)](https://app.netlify.com/sites/hugothemes/deploys)

# Hugo themes

A collection of all themes that were created by the Hugo community. See a complete listing of all of these themes along with screenshots and demos at [themes.gohugo.io](https://themes.gohugo.io/). Every theme in this list will automatically be added to the theme site.

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

If your theme doesn't fit into the `Hugo Basic Example` site, we encourage theme authors to supply a self-contained Hugo site in `/exampleSite/`, but note that for security reasons the content directory on the Hugo showcase will still be published from the [`Hugo Basic Example`](https://github.com/gohugoio/hugoBasicExample/tree/master/content) repository.

**NOTES** 

* The folder name here is important, as this folder will be picked up and used by the script that generates the Hugo Theme Site. It mirrors the root directory of a Hugo website and allows you to add custom content, assets and a config file with preset values.

* Most of the themes in this repo are hosted on GitHub. We also include themes hosted on GitLab and similar, but we do not add themes living on a self-hosted repository.

* You need to test your theme's demo with the content directory from the [`Hugo Basic Example`](https://github.com/gohugoio/hugoBasicExample/tree/master/content) repository.

* An Example Site should **not** have third party tracking enabled. If you wish to provide configuration parameters to third party services (analytics, comments etc) then please do not enter a valid account `ID` or username.

Each theme needs:

1. To be added to the hugoThemes repo;
1. To have the right fields in `theme.toml`;
1. To have the right images;
1. A good README;
1. To include the `resources` folder if it's using [Hugo Pipes](https://gohugo.io/hugo-pipes) to process assets;
1. To have `https://example.com` as base url in `exampleSite/config.{toml, yaml, json}` to avoid the [abuse of unused domains](https://github.com/gohugoio/hugo/issues/2575).

## theme.toml

This file contains metadata about the theme and its creator or creators. **Only `theme.toml` is accepted, not `theme.yaml` or not `theme.json`**. The following fields are required:

```toml
name = "Theme Name"
license = "MIT"
licenselink = "Link to theme's license"
description = "Theme description"
homepage = "Website of your theme"
tags = ["blog", "company"]
features = ["some", "awesome", "features"]
min_version = "0.59.1"

# If the theme has multiple authors
authors = [
  {name = "Name of author", homepage = "Website of author"},
  {name = "Name of author", homepage = "Website of author"}
]

# If the theme has a single author
[author]
    name = "Your name"
    homepage = "Your website"

# If porting an existing theme
[original]
    author = "Name of original author"
    homepage = "His/Her website"
    repo = "Link to source code of original theme"
```

**Note:** Hugo started using full semver versions even for main releases in v0.54.0, therefore if your theme has a recent `min_version` you need to enter it as `0.59.0` and not `0.59`.

## LICENSE

Themes in this repository are accepted only if they come with an Open Source license, that allows for the theme to be freely used, modified, and shared. 

To have a look at popular licenses please visit the [Open Source Initiative](https://opensource.org/licenses) website.

**Note:** When porting an existing theme from another platform to Hugo, or if you are forking another Hugo theme in order to add new features and you wish to submit the derivative work for inclusion at the Hugo Themes Showcase, you really need to make sure that the requirements of the original theme's license are met. 

If a submission is found to violate the LICENSE of an original theme, it will be rejected without further discussion.

## Media

Screenshots are used as theme previews in the list, they should feature a theme's layout (without any browser chrome or device mockups) and have the following dimensions:

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

To ease accessibility for international users of your theme please provide at least an English translation of the README.

**Note:** If you add screenshots to the README please make use of absolute file paths instead of relative ones like `/images/screenshot.png`. Relative paths work great on GitHub but they don't correspond to the directory structure of [themes.gohugo.io](https://themes.gohugo.io/). Therefore, browsers will not be able to display screenshots on the theme site under the given (relative) path.

## Example Site

Theme demo content on the Hugo Themes website is typically inherited from the [hugoBasicExample](https://github.com/gohugoio/hugoBasicExample) repository.

If a theme demo requires its own content structure to function or if it is meant for a specialist use case, we will be more than glad to review your theme and accomodate its demo.

However you will still need to provide generic content that is as **neutral as possible** in the theme's exampleSite. 

From time to time we may audit the demos hosted on the Hugo Themes website. If a demo is found to feature content that is not acceptable it will be disabled.

## Resources

If your theme makes use of the [Hugo Pipes](https://gohugo.io/hugo-pipes) methods `toCSS` and / or `PostCSS`, you need to take additional steps to make your theme compatible with the basic version of Hugo:

- From the root of a Hugo project that uses your theme execute the command `hugo server` -this will generate the `/resources/` folder under the project root-.
- Or if you prefer to build the project simply run the command `hugo` -this will generate the resources under `public/resources`-.
- Copy the generated resources folder and commit it directly either under the root of your theme's repository or under `exampleSite`.
- Whenever you make any changes in your Hugo Pipes assets, you will need to regenerate and commit the theme's resources again.

## Common Permalink Issues

The demo of your theme will be available in a subdirectory of the [Hugo Themes website](https://themes.gohugo.io/) and you need to make sure of the following:

- If using inline styles, these need to use absolute URLs, for the linked assets to be served properly, e.g. `<div style="background: url('{{ "images/background.jpg" | absURL }}')">`
- Make sure not to use a forward slash `/` in the beginning of a `URL`, because it will point to the host root and Hugo will not generate the correct `URL` for the demo's assets.
- If using external CSS and JS from a CDN, make sure to load these assets over `https`. Please do not use relative protocol URLs in your theme's templates.

## Useful Tips

A Hugo theme may be used in various scenarios and as such it is important to keep it flexible:

- Use the inbuilt [`mainSections`](https://gohugo.io/functions/where/#mainsections) list instead of comparing section names to hard-coded values like `"posts"` or `"post"`. 

- The [`readFile`](https://gohugo.io/functions/readfile/#readout) and [`readDir`](https://gohugo.io/functions/readdir/#readout) functions may be useful in a project but not in a theme, since it is not advisable to use hardcoded PATHs in the form of:  `{{ .Site.baseURL }}/something` either in the theme's templates or in the config of an Example Site.

- Never leave pages without layouts. Instead use [`disableKinds`](https://gohugo.io/getting-started/configuration/#all-configuration-settings). A theme with no layouts for various kinds pollutes the Hugo Themes deploy logs to the point that these are almost unusable.

- Never use deprecated Hugo features that throw console warnings such as `Page's .URL`, `.RSSLink`, `Page's .Hugo`, `Page's .UniqueID`, `Page's .Dir` etc.

- Keep your theme's git repo history down. Please do not include binaries or videos with large file sizes.

- Never use photos that are copyrighted. Make sure that your theme’s resources can be used in an Open Source theme.

- We discourage the use of third party CDNs to serve assets. It is no longer a good practice in this day and age (fingerprinting, security risk etc) despite of the possible benefits of faster loading times.

## Theme Maintenance

- It is of paramount importance that a Hugo theme's demo generates with the latest version of Hugo. 

- Theme authors need to keep an eye on future Hugo releases and provide patches as needed. 

- The Hugo Themes Showcase always uses the latest Hugo version to generate its website. 

- If a theme demo breaks and remains so for more than 30 calendar days, we may remove it from this repository without further notification.

## Theme Updates

Themes are updated automatically at:
```
00:00 UTC on the 1, 4, 7, 10, 13, 16, 19, 22, 25, 28 and 31th of every month
```

## Testing a theme with the Hugo Themes website Build Script

To test your theme with the Hugo Themes Site Build Script locally:
- Clone this repo
- Navigate to the `_script/` directory e.g. `cd _script/`
- Then execute: `./reviewTheme.sh url-to-git-repository-of-theme`
   - If a theme demo requires its own content structure to function or if it is meant for a specialist use case, whitelist it in [./generateThemeSite.sh](https://github.com/gohugoio/hugoThemes/blob/master/_script/generateThemeSite.sh)
   - For more detailed information about the build process [look here](https://github.com/gohugoio/hugoThemes/tree/master/_script#quick-build-for-theme-reviews--tests)
- Open `http://localhost:1313` in your browser and navigate to the theme
- If your theme demo is not generated you can create an error report with: `./reviewTheme.sh url-to-git-repository-of-theme > errors.txt`
