#
# Cookbook Name:: monit-scripts
# Recipe:: default
#

enable_package "ey-monit-scripts" do
  version "0.19"
end

package "ey-monit-scripts" do
  version "0.19"
  action :install
end
