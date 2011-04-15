#
# Cookbook Name:: delayed_job
# Recipe:: default
#
if node[:instance_role] == "solo" || (node[:instance_role] == "util" && node[:name] !~ /^(mongodb|redis|memcache)/)
  node[:applications].each do |app_name,data|
    
    template "/etc/logrotate.d/delayed_job" do
      owner "root"
      group "root"
      mode 0755
      source "delayed_job.logrotate.erb"
      variables({
        :app_name => app_name
      })
      action :create
    end

    monitrc_file_basename = "delayed_job_#{app_name}"
    monitrc_directory     = "/etc/monit.d"

    execute "remove unused monitrc files for delayed job" do
      user 'root'
      command "rm -f #{monitrc_directory}/#{monitrc_file_basename}*.monitrc"
    end

    template "#{monitrc_directory}/#{monitrc_file_basename}.monitrc" do
      source "delayed_job_worker.monitrc.erb"
      owner "root"
      group "root"
      mode 0644
      variables({
        :app_name => app_name,
        :framework_env => node[:environment][:framework_env],
      })
    end

    execute "monit-reload-restart" do
       command "sleep 30 && monit reload"
       action :run
    end
  end
end