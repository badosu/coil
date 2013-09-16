Coil
====

Coil is a minimalistic blog engine written in elixir.

Install
-------

Clone the repo and fetch dependencies:

    git clone https://github.com/badosu/coil
    cd coil && mix deps.get

Usage
-----

Edit `config.yml`.

Add an article: `mix post`

And run:

    PORT=8080 mix run --no-halt

Deploy to Heroku:

    heroku create --buildpack "https://github.com/goshakkk/heroku-buildpack-elixir.git"
    git push heroku master


License
-------

The MIT License, see LICENSE
