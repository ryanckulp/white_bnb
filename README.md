# WhiteBnb
a simple property booking platform for branded destinations. #airbnbsucks

demo: https://hh.ryanckulp.com

## Installation
1. `bin/setup`

## Development
```sh
bin/dev # uses foreman to boot server, frontend, and bg job queue
```

To sync your project with the latest WhiteBnb improvements:

```sh
# one time only
git remote add white_bnb https://github.com/ryanckulp/white_bnb.git

# when you notice WhiteBnb updates on GitHub
git pull
git fetch white_bnb
git merge white_bnb/master --allow-unrelated-histories
git checkout -b white_bnb_updates
git add .
git push white_bnb_updates
# use GitHub UI to handle conflicts
```

## Testing
```sh
# headless
bundle exec rspec # run all tests inside spec/
bundle exec rspec spec/dir_name # run all tests inside given directory

# headed (in a real browser)
HEADED=TRUE bundle exec rspec
```

## Code Quality

clean code keeps projects manageable as they grow in complexity.

```sh
rubocop # checks your code against Ruby styling standards and calls out issues
rubocop -A # automatically fixes issues, can lead to false negatives
rubocop -a # automatically fixes "safe" issues, less aggressive than -A (uppercase)
```

**Rubocop is an optional feature**, however it runs automatically during GitHub CI checks. if you don't want to enforce the Rubocop style guide, simply disable the `Rubocop Check` step inside `ci.yml`.

## Contributing
anyone is welcome to submit a PR with improvements of any kind.
