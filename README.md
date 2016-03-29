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

The test suite (with RuboCop style enforcement) will be run with the default rake task (also run on travis)

    $ rake

The specs can be run without RuboCop enforcement

    $ rake spec

The RuboCop style enforcement can be run without running the tests

    $ rake rubocop
