run "cd #{release_path} && bundle install"

run "cd #{release_path} && bundle exec ruby test_control_file.rb"