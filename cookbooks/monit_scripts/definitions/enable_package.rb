define :enable_package, :version => nil do
  name = params[:name]
  version = params[:version]
  full_name = name << ("-#{version}" if version)
  
  case node[:kernel][:machine]
  when "x86_64"
    arch="~amd64"
  when "i686"
    arch="~x86"
  end

  update_file "local portage package.keywords" do
    path "/etc/portage/package.keywords/local"
    body "=#{full_name} #{arch}"
    not_if "grep '=#{full_name}' /etc/portage/package.keywords/local"
  end
end
