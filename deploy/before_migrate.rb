run "cd #{release_path} && bundle install"

bundle_show_result = run "cd #{release_path} && bundle show curb"

raise bundle_show_result