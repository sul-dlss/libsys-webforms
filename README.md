[![Build Status](https://travis-ci.org/sul-dlss/libsys-webforms.svg?branch=master)](https://travis-ci.org/sul-dlss/libsys-webforms) | [![Coverage Status](https://coveralls.io/repos/github/sul-dlss/libsys-webforms/badge.svg?branch=master)](https://coveralls.io/github/sul-dlss/libsys-webforms?branch=master) | [![Dependency Status](https://gemnasium.com/sul-dlss/libsys-webforms.svg)](https://gemnasium.com/sul-dlss/libsys-webforms)
# Library Systems Webforms App

This is a Rails application to be a front-end for various Symphony reporting & updating tools. Intended to replace the web forms generated from the 'sulohs' servers.

## Requirements
1. Ruby (2.1.1 or greater)
2. Rails (4.2.0 or greater)
3. An Instance of Symphony to connect to

## Installation

Clone the repository
```
git clone https://github.com/sul-dlss/libsys-webforms.git
```

Change directories into the app and install dependencies
```
bundle install
```

Start the development server
```
REMOTE_USER=some-user rails s
```

## Testing

#### Running the migrations for test

Before running the tests with rake you should run the migrations in the `test` environment by running:
```
rake db:migrate RAILS_ENV=test
```
#### Setting up the fixtures

Before running the test suite you should load the fixture data into the tables with:
```
rails runner spec/init_libsys-webforms.rb
```

### Rake, etc.
The test suite (with RuboCop style enforcement) will be run with the default rake task (also run on travis)

    $ rake

The specs can be run without RuboCop enforcement

    $ rake spec

The RuboCop style enforcement can be run without running the tests

    $ rake rubocop

If you get a `ConnectionAdapters::OracleEnhancedAdapter` error when running a rake task, you may need to temporarily add `:development` to the group that contains the activerecord-oracle_enhanced-adapter gem, for example:

```
group :production, :development do
  gem 'activerecord-oracle_enhanced-adapter', '~> 1.6.0'
  gem 'ruby-oci8'
end
```
<strong>...but please do not commit this change, and revert it before deployment.</strong>

## Deployment

To deploy to development:

    $ cap development deploy

## Command-line tasks

There are some command-line tools the application provides.
For example, to upload and delete batches:

    $ bundle exec rake webforms:change_current_location[:path_to_file,:current_lib,:new_curloc,:email, :comments]
    $ bundle exec rake webforms:delete_batch[batch_id]    

## Ckey2Bibframe Webform

The "Ckey2Bibframe" webform allows you to enter a Symphony ckey and view <strong>marc21-to-xml</strong> and <strong>marcxml-to-bibframe2</strong> results in the browser. In order for this functionality to work you must install the <a href="https://github.com/lcnetdev/marc2bibframe2">LOC Marc2Bibframe2 Converter</a> and place it under this application's root. Running the LOC marc2bibframe2 converter via libsys-webforms requires the `xsltproc` command-line tool be installed on your system (see http://www.xmlsoft.org). After cloning this project, simply `cd libsys-webforms` and then `git clone https://github.com/lcnetdev/marc2bibframe2.git`. If it is not already there, you must also create a `lib/xform-marc21-to-xml-jar-with-dependencies.jar` file that is compiled from https://github.com/sul-dlss/ld4p-marc21-to-xml (see https://github.com/sul-dlss/ld4p-marc21-to-xml#compiling-and-executing, it should be placed in this app's lib folder as well).
