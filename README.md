Coil
====

Coil is a minimalistic static content engine written in elixir.

Requirements
-------

You must have the latest stable version of elixir installed,
[v0.12.2](https://github.com/elixir-lang/elixir/releases/tag/v0.12.2) as of
the writing of this.

Install
-------

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

Run (on port 8080): `PORT=8080 mix run --no-halt`.

Deploy to Heroku:

```bash
heroku create --buildpack "https://github.com/goshakkk/heroku-buildpack-elixir.git"
git push heroku master
```

Customize
---------

If you have a `mix.exs` file requiring the coil lib properly, like
[this one](/example/mix.exs), you have only to follow the structure
below to get it working:

    .
    |-- articles
    |   `-- YYYY-mm-dd-article-title.md
    |-- assets
    |   `-- example.css
    |-- config.yml
    |-- mix.exs
    |-- pages
    |   `-- title.md
    `-- templates
        |-- archives.html.eex
        |-- article.html.eex
        |-- index.html.eex
        |-- index.xml.eex
        |-- layout.html.eex
        `-- page.html.eex

### Routes

* Index: `/`
* Page: `/title`
* Resource: `/assets/example.css`
* Article: `/articles/YYYY-mm-dd-article-title`
* RSS feed: `/feed`
* Archives: `/archives`

### Templates

Templates are embedded elixir files
(see the [EEx docs](http://elixir-lang.org/docs/stable/EEx.html)), and can be
customized to suit your design:

* `layout.html.eex` The template in which all other templates are embedded
* `index.html.eex` Renders the home page
* `article.html.eex` Renders the article page
* `page.html.eex` Renders the page page
* `archives.html.eex` Renders the archives page
* `index.xml.eex` Renders the rss feed

License
-------

The MIT License, see LICENSE
