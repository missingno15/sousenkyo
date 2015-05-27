#!usr/bash

# A popup window should appear which says: 

#   The "xcode-select" command requires the
#   command line developer tools. Would you like
#   to install the tools now?

# Click "Install"
xcode-select --install

# Install Homebrew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Install necessary binaries
brew install tesseract
brew install imagemagick
brew install chromedriver

# Install RVM and get latest Ruby version
\curl -sSL https://get.rvm.io | bash -s stable --ruby
source /Users/$USER/.rvm/scripts/rvm

gem install rtesseract
gem install rmagick
gem install selenium-webdriver
