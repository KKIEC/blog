# README

**Blog application template**

It is deployed on Heroku:
https://tkk-blog.herokuapp.com/

It contains following features:
  - Rails and Ruby versions:
    - rails 6.1.4
    - ruby 3.0.2
  - Database:
    - postgresql in production
    - sqlite3 in development and test
    - relational (admin, bloggers, categories, articles)
    - seed by gem faker
  - Authentication:
    - from scratch with bcrypt
  - Authorization:
    - from scratch
  - Payment and premium content:
    - Stripe checkout, billing portal and webhooks
  - Styling:
    - bootstrap 4 classes
    - with own custom css
    - pagination (will_paginate)
    - gravatar for bloggers
    - erb, ejs and haml views
  - Code quality:
    - rubocop-rails
  - Testing:
    - rails 6 assertions
    - model tests
    - controller tests
    - examples for system and integration tests
    - byebug
