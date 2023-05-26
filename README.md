# API - Twitter MVP
This is a code challenge for silverdev technical interview.

# Objective
Create a Twitter MVP that can:
1. Create an account - skip authentication.
2. Follow accounts.
3. Create a tweet.
4. Feed endpoint. Read tweets by people that you are following.

# Pseudo-code

## Create an account
- Get the account params
- Verify username is not empty, has at least 5 and at most 50 characters long, and be unique.
- Verify that the username does not contain spaces or special characters.
- **IF** at least one validation fails, return an error \
  **ELSE IF** insert the record into the database

## Follow accounts
- Identify current_user
- Identify who's the account to be followed
- **IF** Validate that the accounts is not already followed by the current_user \
**AND** Validate that the current_user account and the followed account are not the same \
**THEN** Insert a record that reflects the follow relation between the two accounts. This should be a intermediate class/table. \
**ELSE** return an error.

## Create a tweet
- Identify current_user
- Get the tweet params
- **IF** Validates that the tweet's body is at least 3 characters long\
**AND** Validates that the tweet's body is at most 100 characters long\
**THEN** insert the record into the database\
**ELSE** return an error

## Feed endpoint
- Identify current_user
- **IF** page params is empty\
  **THEN** get the first 20 tweets from followed accounts \
  **ELSE** offset should be equal to `page * 20`
- **RENDER** the given tweets as a json from the controller


# Getting started

To get the Rails server running locally:

- Clone this repo
- `bundle install` to install all req'd dependencies
- `rails db:migrate` to make all database migrations
- `rails db:seed` to generate the initial sample data
- `rails s` to start the local server


# About
This project was built with `ruby 3.2.2` and `rails 7.0.5`. We use `postgresql` as database.
