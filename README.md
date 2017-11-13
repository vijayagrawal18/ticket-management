# ticket-management
Rails 5 ticket management system using ruby `2.4.1`.

Ensure you have ruby 2.4.1 installed.

## Steps to set it up on local

```
# Install all dependencies
bundle install

# Setup data
# CAUTION:: It drops DB and re-populates with sample data.
rails setup

# Start puma server on port 3000
rails server

open http://localhost:3000
```

## Command to execute all test cases

```
rails test
```
