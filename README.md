# TastyBrew

[![Build Status](https://travis-ci.org/jonnylink/tastybrew.svg?branch=master)](https://travis-ci.org/jonnylink/tastybrew)
[![Code Climate](https://codeclimate.com/github/jonnylink/tastybrew/badges/gpa.svg)](https://codeclimate.com/github/jonnylink/tastybrew)
[![Test Coverage](https://codeclimate.com/github/jonnylink/tastybrew/badges/coverage.svg)](https://codeclimate.com/github/jonnylink/tastybrew/coverage)

### ABOUT
--------------------
TastyBrew will be an inventory tracking and recipe suggestion tool for craft and home brewers.

### FEATURES
--------------------
* Ingredient database
* Recipe storage
* Recipe rating
* ABV calculation
* IBU calculation

### Getting Started
--------------------
1. Get the code. Clone this git repository and check out the latest release:

```bash
git clone https://github.com/jonnylink/tastybrew.git
cd sharetribe
git checkout latest
```

2. Install the required gems by running the following command in the project root directory:

```bash
bundle install
```

3. Create, migrate, and seed the database:

```bash
bundle exec rake db:create
bundle exec rake db:migrate
bundle exec rake db:seed
```

4. Run the tests:

```bash
bundle exec rake
```

  ### What it Comes With
  --------------------
* A set of common ingredients
