None of the existing hugo themes fit what I wanted so I created my own. I'm horrible at front-end stuff and usually stay away from it so keep that in mind if you plan on using this.

Skeleton is the CSS framework used.

This theme will not work out of the box, there are a few parameters you'll have to add/set in your main hugo config file:

````
[params]
    tagline = "this is a tagline..."
    headerimg = "toprow2.png"
    githubUrl = "http://github.com/esell"
````

The "headerimg" will be the name of a file located in static/img/

Additionally you will probably want to edit layouts/partials/header.html so that the "about" and "contact" links point to where you want them to go. While you are in there update the header text to whatever you want.
