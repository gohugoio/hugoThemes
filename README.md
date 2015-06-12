
[WARNING]: # (                   AUTO-GENERATED CODE                    )
[WARNING]: # ( CHANGES MADE HERE WILL BE OVERWRITTEN BY generate-readme )
[WARNING]: # (                EDIT README.tmpl.md INSTEAD               )

hugoThemes
==========

All Themes Hugo

See a complete listing of all of these themes along with screenshots and demos at http://themes.gohugo.io/ (coming soon).

Every theme in this list will automatically be added to the theme site.

# Installing Themes

## Installing all themes

If you would like to install all of the available Hugo themes, simply clone the entire repository from within your working directory with this command:

    git clone --recursive https://github.com/spf13/hugoThemes.git themes

## Installing a single theme

<pre><code>mkdir themes
cd themes
git clone <em>URL_TO_THEME</em>
</code></pre>

# Adding a theme to the list

* Create your theme using <code>hugo new theme <em>THEMENAME</em></code>;
* Test your theme against https://github.com/spf13/HugoBasicExample;
* Add a `theme.toml` file to the root of the theme;
* Add a `README.md` to the root of the theme;
* Add `/images/snapshot.png` and `/images/tn.png`;
* Send a Pull Request with the `git submodule` addition.


Each theme needs:

1. to be added to the hugoThemes repo;
2. the right fields in `theme.toml`;
3. the right images;
4. a good README.

## theme.toml

The following fields are required:

```toml
name = "Hyde"
license = "MIT"
licenselink = "https://github.com/spf13/hyde/blob/master/LICENSE.md"
description = "An elegant open source and mobile first theme"
homepage = "http://siteforthistheme.com/"
tags = ["blog", "company"]
features = ["blog", ]
min_version = 0.13

[author]
    name = "spf13"
    homepage = "http://spf13.com/"

# If porting an existing theme
[original]
    author = "mdo"
    homepage = "http://hyde.getpoole.com/"
    repo = "https://www.github.com/mdo/hyde"
```

> **Notes:**
>
> 1. This is different from the file created by `hugo new theme` in the old v0.12.
>    The current Hugo v0.13 does create the same template with the new fields
>    except `min_version` that was created in 0.14-DEV.
>
> 2. Only `theme.toml` is accepted, not `theme.yaml`, not `theme.json`.


## Media

* Thumbnail should be 900×600 in pixels
* Screenshot should be 1500×1000 in pixels
* Media must be located in:
    * <code><em>[ThemeDir]</em>/images/screenshot.png</code>
    * <code><em>[ThemeDir]</em>/images/tn.png</code>

Additional media may be provided in that same directory.

## README

The README file serves double purposes. It is used on GitHub as the content for the main page. It also will become the content on the detailed theme view page for (the future) themes.gohugo.io. It should be in Markdown format and called `README.md`.
# Theme List
## [hugo_theme_aglaus](https://github.com/dim0627/hugo_theme_aglaus)
![dim0627/hugo_theme_aglaus](https://raw.githubusercontent.com/dim0627/hugo_theme_aglaus/13d97e05e189b43bce43861f6f6cf220e5e6ef2c/images/tn.png)

---

## [angels-ladder](https://github.com/tanksuzuki/angels-ladder)
![tanksuzuki/angels-ladder](https://raw.githubusercontent.com/tanksuzuki/angels-ladder/fe086ecf531fbc67306f57127cc44e7ad423d1a5/images/tn.png)

---

## [hugo_theme_beg](https://github.com/dim0627/hugo_theme_beg)
![dim0627/hugo_theme_beg](https://raw.githubusercontent.com/dim0627/hugo_theme_beg/1ea4bec734d361d402768151b21f1cedff8062e7/images/tn.png)

---

## [hugo-theme-bootie-docs](https://github.com/key-amb/hugo-theme-bootie-docs)
![key-amb/hugo-theme-bootie-docs](https://raw.githubusercontent.com/key-amb/hugo-theme-bootie-docs/c2838f154fccd6f01ee7a5013f47d25b901474a8/images/tn.png)

---

## [hugo-theme-casper](https://github.com/vjeantet/hugo-theme-casper)
![vjeantet/hugo-theme-casper](https://raw.githubusercontent.com/vjeantet/hugo-theme-casper/0e2a2a3fc1efee2c95286cb04d5e60d29683e330/images/tn.png)

---

## [hugo-theme-crisp](https://github.com/Zenithar/hugo-theme-crisp)
![Zenithar/hugo-theme-crisp](https://raw.githubusercontent.com/Zenithar/hugo-theme-crisp/f178ba762cc3b1fd7324fbfbb80a0ccbc95da55f/images/tn.png)

---

## [hugo-freelancer-theme](https://github.com/digitalcraftsman/hugo-freelancer-theme)
![digitalcraftsman/hugo-freelancer-theme](https://raw.githubusercontent.com/digitalcraftsman/hugo-freelancer-theme/f86e46c7d8f1506e547cb8ee99c3515b90fbbf95/images/tn.png)

---

## [greyshade](https://github.com/cxfksword/greyshade)
![cxfksword/greyshade](https://raw.githubusercontent.com/cxfksword/greyshade/2341a288c2301d6993432b4545e78a8407e91a58/images/tn.png)

---

## [heather-hugo](https://github.com/hbpasti/heather-hugo)
![hbpasti/heather-hugo](https://raw.githubusercontent.com/hbpasti/heather-hugo/3df3bfe5711c373995413900be78ed0ae0f5119e/images/tn.png)

---

## [herring-cove](https://github.com/spf13/herring-cove)
![spf13/herring-cove](https://raw.githubusercontent.com/spf13/herring-cove/944422430f8a77c7464c137650aa3406d4a0f802/images/tn.png)

---

## [hugo-theme-html5](https://github.com/simonmika/hugo-theme-html5)
*image not available* :hankey:

---

## [hugo-base-theme](https://github.com/crakjie/hugo-base-theme)
![crakjie/hugo-base-theme](https://raw.githubusercontent.com/crakjie/hugo-base-theme/f1b5289d9949a5a7352495d5e8cc56cf94b5e848/images/tn.png)

---

## [hugo-bootswatch](https://github.com/nilproductions/hugo-bootswatch)
![nilproductions/hugo-bootswatch](https://raw.githubusercontent.com/nilproductions/hugo-bootswatch/6681963f24d6c1e6b9efd148b1344434f090b5cd/images/tn.png)

---

## [hugo-incorporated](https://github.com/nilproductions/hugo-incorporated)
![nilproductions/hugo-incorporated](https://raw.githubusercontent.com/nilproductions/hugo-incorporated/717e7533f8dccdd4785349c59d2fb731b6633366/images/tn.png)

---

## [hugoscroll](https://github.com/SenjinDarashiva/hugoscroll)
![SenjinDarashiva/hugoscroll](https://raw.githubusercontent.com/SenjinDarashiva/hugoscroll/a7be047d31f54a0a5378e0fd22d5b4ab2be8e860/images/tn.png)

---

## [hugo-uno](https://github.com/SenjinDarashiva/hugo-uno)
![SenjinDarashiva/hugo-uno](https://raw.githubusercontent.com/SenjinDarashiva/hugo-uno/a644ec06918a2956105dc41923438993004463c1/images/tn.png)

---

## [hurock](https://github.com/TiTi/hurock)
![TiTi/hurock](https://raw.githubusercontent.com/TiTi/hurock/6fdbbaae038ac4568c78e4704d0819f73ec3616b/images/tn.png)

---

## [hyde](https://github.com/spf13/hyde)
![spf13/hyde](https://raw.githubusercontent.com/spf13/hyde/1a7140a4d7fd4b5834178c721fdb636e96db2dd6/images/tn.png)

---

## [hyde-x](https://github.com/zyro/hyde-x)
![zyro/hyde-x](https://raw.githubusercontent.com/zyro/hyde-x/29f88edc454b8744e85cbe1549eb5b7a7c9d1bc4/images/tn.png)

---

## [hugo-journal](https://github.com/mpas/hugo-journal)
![mpas/hugo-journal](https://raw.githubusercontent.com/mpas/hugo-journal/ecf49cbb14a4fa746ed86fa5f1e7959076aca5b1/images/tn.png)

---

## [landing-page-hugo](https://github.com/crakjie/landing-page-hugo)
![crakjie/landing-page-hugo](https://raw.githubusercontent.com/crakjie/landing-page-hugo/dc03a9d70eaec5704649987e5ff3b73c41dd6754/images/tn.png)

---

## [lanyon-hugo](https://github.com/tummychow/lanyon-hugo)
![tummychow/lanyon-hugo](https://raw.githubusercontent.com/tummychow/lanyon-hugo/febd4a0e378392b5e2834da8f87badaa9b039fba/images/tn.png)

---

## [liquorice](https://github.com/eliasson/liquorice)
![eliasson/liquorice](https://raw.githubusercontent.com/eliasson/liquorice/a32161d3aaf0aa39e1040034cdc2206bf7435e5f/images/tn.png)

---

## [material-design](https://github.com/pdevty/material-design)
![pdevty/material-design](https://raw.githubusercontent.com/pdevty/material-design/3a9d77ad467295f55caa67281be92d2369ae5df7/images/tn.png)

---

## [nofancy](https://github.com/gizak/nofancy)
![gizak/nofancy](https://raw.githubusercontent.com/gizak/nofancy/9cd8c1f29be39baaf1e8e2f6468f656641174f70/images/tn.png)

---

## [hugo-theme-pixyll](https://github.com/azmelanar/hugo-theme-pixyll)
*image not available* :hankey:

---

## [poopshow](https://github.com/esell/poopshow)
![esell/poopshow](https://raw.githubusercontent.com/esell/poopshow/459da0109a6a22d77b3275c6c92d9d390ddc09c3/images/tn.png)

---

## [purehugo](https://github.com/dplesca/purehugo)
![dplesca/purehugo](https://raw.githubusercontent.com/dplesca/purehugo/5e059b4130c5ade86f3ebcfa32487bc7df07d28f/images/tn.png)

---

## [hugo-redlounge](https://github.com/tmaiaroto/hugo-redlounge)
![tmaiaroto/hugo-redlounge](https://raw.githubusercontent.com/tmaiaroto/hugo-redlounge/f6f223881d945c1bcb31d3630ebb8b76a977531c/images/tn.png)

---

## [hugo-theme-shiori](https://github.com/chibicode/hugo-theme-shiori)
![chibicode/hugo-theme-shiori](https://raw.githubusercontent.com/chibicode/hugo-theme-shiori/fc21db77938e91f8c7b9451f0ca34ab8f5ff772b/images/tn.png)

---

## [simple-a](https://github.com/AlexFinn/simple-a)
![AlexFinn/simple-a](https://raw.githubusercontent.com/AlexFinn/simple-a/f0ed2c78dd5e2d6e6b344371ff720d93a59d0a22/images/tn.png)

---

## [simple-hugo](https://github.com/druzza/simple-hugo)
![druzza/simple-hugo](https://raw.githubusercontent.com/druzza/simple-hugo/7246d24953f244871140a932e5d88ac725e029bd/images/tn.png)

---

## [hugo-theme-slim](https://github.com/zhe/hugo-theme-slim)
![zhe/hugo-theme-slim](https://raw.githubusercontent.com/zhe/hugo-theme-slim/ccdd0de582c4f36a51a05e2cb11c0a5f190cbe49/images/tn.png)

---

## [startbootstrap-clean-blog](https://github.com/humboldtux/startbootstrap-clean-blog)
![humboldtux/startbootstrap-clean-blog](https://raw.githubusercontent.com/humboldtux/startbootstrap-clean-blog/cbff51828bb5d4485d1b97c470a3b4f0c5a0e5c2/images/tn.png)

---

## [tachyons](https://github.com/marloncabrera/tachyons)
![marloncabrera/tachyons](https://raw.githubusercontent.com/marloncabrera/tachyons/bd29edd0c05763b87336cf312cb657303aaa6d4d/images/tn.png)

---

## [tinyce-hugo-theme](https://github.com/roperzh/tinyce-hugo-theme)
![roperzh/tinyce-hugo-theme](https://raw.githubusercontent.com/roperzh/tinyce-hugo-theme/ae1511ae02f1f3f586ed68bc50f29e3b1549b03e/images/tn.png)

---

## [twentyfourteen](https://github.com/jaden/twentyfourteen)
![jaden/twentyfourteen](https://raw.githubusercontent.com/jaden/twentyfourteen/499670f6fe999b072d402da0d8cbf58a33dca5de/images/tn.png)

---

## [vienna](https://github.com/keichi/vienna)
![keichi/vienna](https://raw.githubusercontent.com/keichi/vienna/4d7a1fb6212b3267f8ea614d479152dbacbddbe0/images/tn.png)

---

