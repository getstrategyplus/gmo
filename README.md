

# Getting started

Strategy+ was built with Rails 5.0.1 and Ruby 2.3.1 and you must have installed Postgre SQL in your development machine. If you are a OS X user I recommend you to install using [postgreapp.com](http://postgresapp.com) instead of Homebrew.

# Deploy

The easiest way to prepare a server on Digital Ocean is using [Dokku Project](http://dokku.viewdocs.io/dokku/). Dokku works as a mini-heroku and it's very well suited for small projects like Strategy+. This [tutorial](http://www.rubyfleebie.com/how-to-use-dokku-on-digitalocean-and-deploy-rails-applications-like-a-pro/) explains how to deploy a Rails application on Digital Ocean using Dokku. I'll just spend a few minutes and your application will be ready.

After you configure Dokku, simply push your local code into Dokku Git repository to deploy a new version:

```
git push dokku master
```

To run your migrations in production, just call:

```
dokku run rake db:migrate
```

## Installing SSL certificates

Use [Dokku Let's Encrypt plugin](https://github.com/dokku/dokku-letsencrypt#usage). It will generate, validate and install your certificate automatically. I suggest you to read carefully the plugin documentation. There is such a great features like auto renew certificates, etc.

# Modules

## Goodbits Crawler

To update the newsletter on Strategy+ web application you just need to call a rake task:

```
dokku run rake crawler:fetch 
```

This rake task is idempotent, that means you call it many times without need to worry about creating duplicated data. If a newsletter is already crawled, the task will just update the newsletter data. Also, this task will run every minute fetching updates from Goodbits newsletters.