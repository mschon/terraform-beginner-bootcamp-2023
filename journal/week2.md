# Terraform Beginner Bootcamp 2023 - Week 2

## Working with Ruby

### Bundler

[Bundler](https://bundler.io/) is a package manager for Ruby. It is the primary way to install Ruby packages (known as gems) for Ruby. 

#### Install Gems

You need to create a Gemfile and define your gems in that file.

```rb
# frozen_string_literal: true

source "https://rubygems.org"

gem 'sinatra'
gem 'rake'
gem 'pry'
gem 'puma'
gem 'activerecord'
```

Then you need to run the `bundle install` command. 

This will install the gems on the system globally (unlike nodejs which installs packages in place in a folder called `node_modules`).

A Gemfile.lock will be created to lock the gem versions used in this project. 

#### Executing Ruby scripts in the context of Bundler

We have to use `bundle exec` to tell future Ruby scripts to use the gems we installed. This is the way we set context. 

### Sinatra

[Sinatra](https://sinatrarb.com/) is a micro web framework to build web apps. 

It's great for mock or development servers or very simple projects. 

You can create a web server in a single file. 

## Terratowns mock server

### Running the web server

We can run the web server by executing the following commands:

```sh
bundle install
bundle exec ruby server.rb
```

All of the code for our server is stored in the `server.rb` file. 

## CRUD

Terraform provider resources utilize CRUD

CRUD stands for create, read, update, delete.

https://en.wikipedia.org/wiki/Create,_read,_update_and_delete

