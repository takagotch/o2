rails activestrage:install


bin/rails active_storage:install
bin/rails db:migrate




ruby -v
gem install rails -v 5.2.1.beta2
rails new --skip-active-storage -S --webpack=vue fr-application

bin/rails active_storage:install
bin/rails db:create db:migrate
bin/rails server -b 0.0.0.0
curl http://localhost:8080/

bin/rails generate scaffold user name:string address:string
bin/rails db:migrate

bin/rails credentials:show
bin/rails credentials:show
cat config/storage.yml
cat config/environments/development.rb
bundle install


