#!/usr/bin/env bash
# exit on error
set -o errexit
bundle install
bundle exec rails assets:precompile
bundle exec rails assets:clean
# bundle exec rails db:migrate

# テストデータを導入する際に使用
bundle exec rails db:migrate:reset
bundle exec rails db:seed