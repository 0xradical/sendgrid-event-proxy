#
# Cookbook Name:: delayed_job
# Recipe:: default
#

#
# Cookbook Name:: delayed_job
# Recipe:: default
#

# run DelayedJob worker on app instances
if ['solo', 'app', 'app_master', 'util'].include?(node[:instance_role])
  apps = node[:applications].keys #apps = ['indicaalumni']
  framework_env = node[:environment][:framework_env]
 
  template "/etc/logrotate.d/delayed_job" do
    owner "root"
    group "root"
    mode 0755
    source "delayed_job.logrotate.erb"
    action :create
  end

  apps.each do |app_name|
    base_worker_name = "#{app_name}"
    worker_group_name = "#{app_name}_workers"

    directory "/data/#{app_name}/shared/pids" do
      owner node[:owner_name]
      group node[:owner_name]
      mode 0755
    end

    execute "remove unused monitrc files for delayed job" do
      user 'root'
      command "rm -f /etc/monit.d/delayed_job_#{app_name}*.monitrc"
    end
    

    template "/etc/monit.d/delayed_job_#{app_name}.monitrc" do
      source "delayed_job_worker.monitrc.erb"
      owner "root"
      group "root"
      mode 0644
      variables({
        :app_name => app_name,
        :rails_env => framework_env,
        :worker_name => base_worker_name,
        :worker_group_name => worker_group_name,
        :user => node[:owner_name],
      })
    end
    
  end
  
  execute "monit-reload-restart" do
     command "sleep 30 && monit reload"
     action :run
  end
  
end
