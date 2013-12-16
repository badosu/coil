Coil
====

Coil is a minimalistic static content engine written in elixir.

Install
-------

You must have the latest stable version of elixir installed.

Clone the repo, fetch dependencies and compile:

```bash
git clone https://github.com/badosu/coil
cd coil && mix do deps.get, compile
```

Bootstrap a sample coil blog:

```bash
mix coil ../blog
cd ../blog && mix deps.get
```

Apply your configuration:

```bash
$EDITOR config.yml
```

Usage
-----

Add an article: `mix post`.

And run:

```bash
PORT=8080 mix run --no-halt
```

Deploy to Heroku:

```bash
heroku create --buildpack "https://github.com/goshakkk/heroku-buildpack-elixir.git"
git push heroku master
```

Customize
---------

If you have a `mix.exs` file requiring the coil lib properly, like
[this one](/blob/master/example/mix.exs) you have only to follow the guidelines
below to get it working.

### Articles

The content should be plain markdown.

Articles are stored in `articles/YYYY-mm-dd-article-title.md`, and accessed via
`/articles/YYYY-mm-dd-article-title`.

### Pages

The content should be plain markdown.

Pages are stored in `pages/title.md` and accessible via `/title`

### Resources

Any file stored on the `public/` folder will be served at the `/public` route

### Templates

Templates are stored in the `templates/` folder, and are embedded elixir files
(see the [EEx docs](http://elixir-lang.org/docs/stable/EEx.html)):

* `layout.html.eex` The template in which all other templates are embedded
* `index.html.eex` Renders the home page
* `article.html.eex` Renders the article page
* `page.html.eex` Renders the page page
* `archives.html.eex` Renders the archives page
* `index.xml.eex` Renders the rss feed

License
-------

The MIT License, see LICENSE
