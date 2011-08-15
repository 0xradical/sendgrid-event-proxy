environment  = node[:environment][:framework_env]

run "cd #{release_path} && bundle exec whenever --update-crontab '#{app}' --set 'rails_root=#{current_path}&environment=#{environment}'"