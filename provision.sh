#!/usr/bin/env bash
set -euo pipefail # http://redsymbol.net/articles/unofficial-bash-strict-mode/

# Localization
sudo locale-gen en_US en_US.UTF-8
echo "export LC_ALL=en_US.UTF-8" >> ~/.bashrc
export LC_ALL=en_US.UTF-8
perl -e exit # Verify is correct

# Update the system
sudo apt-get upgrade -y

# Other packages
sudo apt-get install -y git tig vim htop

# Ruby installation
sudo apt-get install -y software-properties-common
sudo apt-add-repository -y ppa:brightbox/ruby-ng
sudo apt-get update
sudo apt-get install -y ruby2.2 ruby2.2-dev

# For compiling gems with native extension
sudo apt-get install -y autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm3 libgdbm-dev

# Rails installation
echo "gem: --no-document" >> ~/.gemrc
sudo gem install rails
