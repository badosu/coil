Coil
====

Coil is a minimalistic blog engine written in elixir.

Install
-------

You must have the latest stable version of elixir installed.

Choose one of the following:

### Clone a sample repo

````bash
git clone https://github.com/badosu/coilblog
cd coilblog && mix deps.get
```

### Use the `mix coil` command

Clone the repo, fetch dependencies and compile:

````bash
git clone https://github.com/badosu/coil
cd coil && mix do deps.get, compile
````

Bootstrap a sample coil blog:

````bash
mix coil ../my-blog
cd ../my-blog && mix deps.get
```

Usage
-----

Edit `config.yml`.

Add an article: `mix post`

And run:

````bash
PORT=8080 mix run --no-halt
````

Deploy to Heroku:

````bash
heroku create --buildpack "https://github.com/goshakkk/heroku-buildpack-elixir.git"
git push heroku master
````

Customize
---------

### Resources

Any file stored on the `public/` folder will be served at the `/public` route

### Templates

Templates are stored in the `templates/` folder, and are embedded elixir files

See the [EEx docs](http://elixir-lang.org/docs/stable/EEx.html)

* `layout.html.eex` The template in which all other templates are embedded
* `index.html.eex` Renders the home page
* `article.html.eex` Renders the article page
* `page.html.eex` Renders the page page
* `archives.html.eex` Renders the archives page
* `index.xml.eex` Renders the rss feed

### Pages

The content should be plain markdown.

Pages are stored in `pages/title.md`

### Articles

The content should be plain markdown.

Articles are stored in `articles/YYYY-mm-dd-article-title.md`

License
-------

The MIT License, see LICENSE
