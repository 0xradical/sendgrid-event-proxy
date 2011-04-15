run "cd #{release_path} && bundle install"

run "cd #{release_path} && bundle exec test_control_file.rb"