

# Getting started

To configure Strategy+ in you local machine, make sure you have Ruby 2.3.1 and Postgre SQL in your development machine. You can use [RVM](https://rvm.io/) to manage and install multiple Ruby versions in your local machine. If you are a OS X user I recommend you to install using [postgreapp.com](http://postgresapp.com) instead of Homebrew.

Clone the Git repository:

```
git clone git@github.com:getstrategyplus/strategyplus.git
```

Run bundle command:

```
bundle install
```

Start the web application using foreman:

```
rails s
```

*NOTE:* All delayed jobs are executed inline in development mode. You don't need to start the deamon in development.

# Deploy

## Environment configuration

The easiest way to prepare a server on Digital Ocean is using [Dokku Project](http://dokku.viewdocs.io/dokku/). Dokku works as a mini-heroku and it's very well suited for small projects like Strategy+. This [tutorial](http://www.rubyfleebie.com/how-to-use-dokku-on-digitalocean-and-deploy-rails-applications-like-a-pro/) explains how to deploy a Rails application on Digital Ocean using Dokku. I'll just spend a few minutes and your application will be ready.

Don't forget to create the worker (delayed_job) and the scheduler (clockwork.rb) containers, running the following commands on server:

```
dokku ps:scale strategy-plus worker=1
```

```
dokku ps:scale strategy-plus scheduler=1
```


## Deploy new code

After you configure Dokku, simply push your local code into Dokku Git repository to deploy a new version:

```
git push dokku master
```

To run your migrations in production, just call:

```
dokku run rake db:migrate
```

## Configuring Mailchimp

You have to configure `MAILCHIMP_API_KEY` environment variable to get newsletter subscription working. Use the following command to do that:

```
dokku config:set strategy-plus MAILCHIMP_API_KEY=<your api key>
```

## Configuring Buffer Integration

You have to configure `BUFFER_API_KEY` environment variable to get posts created on buffer. Use the following command to do that:

```
dokku config:set strategy-plus BUFFER_API_KEY=<your api key>
```


## Installing SSL certificates

Use [Dokku Let's Encrypt plugin](https://github.com/dokku/dokku-letsencrypt#usage). It will generate, validate and install your certificate automatically. I suggest you to read carefully the plugin documentation. There is such a great features like auto renew certificates, etc.

# Modules

## Goodbits Crawler

To update the newsletter on Strategy+ web application you just need to call a rake task:

```
dokku run rake crawler:fetch 
```

This rake task is idempotent, that means you call it many times without need to worry about creating duplicated data. If a newsletter is already crawled, the task will just update the newsletter data. Also, this task will run every 5 minutes fetching updates from Goodbits newsletters.
