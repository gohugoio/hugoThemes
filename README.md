hugoThemes
==========

All Themes Hugo

See a complete listing of all of these themes along with screenshots and demos at http://themes.gohugo.io (coming soon).

Every theme in this list will automatically be added to the theme site.

# Installing Themes

## Installing all themes

If you would like to install all of the available hugo themes, simply clone the entire repository from within your working directory.

    git clone --recursive https://github.com/spf13/hugoThemes.git themes

## Installing a single theme

    mkdir themes
    cd themes
    git clone URL_TO_THEME

# Adding a theme to the list

* Create your theme using `hugo new theme THEMENAME`
* Test your theme against https://github.com/spf13/HugoBasicExample
* Add a theme.toml file to the root of the theme
* Add a README.md to the root of the theme
* Add /images/snapshot.png and /images/tn.png
* Send a PR with the git submodule addition


Each theme needs: 

1. To be added to the themes repo
2. The right fields in theme.toml
3. The right images
4. A good readme.

## theme.toml

The following fields are required 
*Notice: This is different from the file created by hugo new theme in v0.12*

    name = "Hyde"
    license = "MIT"
    licenselink = "http://github.com/spf13/hugo/.."
    description = "An elegant open source and mobile first theme"
    homepage = "http://siteforthistheme.com"
    tags = ["blog", "company"]
    features = ["blog", ]
    
    [author]
        name = "spf13"
        homepage = "http://spf13.com"
    
    # If Porting existing theme
    [original]
        author =  "mdo"
        homepage = "http://andhyde.com"
        repo = "http://www.github.com/mdo/hyde"


## Media
Thumbnail should be 900x600 
Screenshot Should be 1500x1000

Media must be located in:

[ThemeDir]/images/screenshot.png 
[ThemeDir]/images/tn.png

Additional media may be provided in that same directory.

## ReadMe

The readme serves double purposes. It is used on github as the content for the main page. It also will become the content on the detailed theme view page for themes.gohugo.io. It should be markdown and called `README.md`.



