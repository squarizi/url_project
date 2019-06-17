#================================================================================

# Configure Capybara for feature specs / end-to-end testing in a "real"
# browser environment.

# To use Selenium (the default), comment out everything below.  Otherwise...

#================================================================================

# To use Poltergeist/PhantomJS:

# require 'capybara/poltergeist'
# Capybara.javascript_driver = :poltergeist

# You will also need PhantomJS >= 1.8.1 installed:
#   Homebrew: brew install phantomjs
#   MacPorts: sudo port install phantomjs

#================================================================================

# To use WebKit:

Capybara.javascript_driver = :webkit

# You will also need Qt installed.  For Homebrew/OSX:
#   brew install qt5
#   brew link --force qt5
# For other situations, see here for installation details:
# https://github.com/thoughtbot/capybara-webkit/wiki/Installing-Qt-and-compiling-capybara-webkit
