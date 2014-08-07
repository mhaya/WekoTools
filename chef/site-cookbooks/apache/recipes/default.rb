#
# Cookbook Name:: apache
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

#execute "apt-get update" do
#   command "apt-get update"
#end

package "apache2" do
   action :install
end

# enable mod_rewite
bash "rewrite" do
   code <<-EOC
       sudo a2enmod rewrite
   EOC
end

# enable mod_ssl
bash "ssl" do
  code <<-EOC
       sudo a2enmod ssl
       sudo a2ensite default-ssl
       sudo a2dissite 000-default
  EOC
end

group "www-data" do
     action :modify
     members ['vagrant']
     append true
end

#template "/etc/apache2/sites-available/000-default.conf" do
#    source "000-default.conf.erb"
#    owner "root"
#    group "root"
#    mode 0644
#    notifies :restart, "service[apache2]"
#end

template "/etc/apache2/apache2.conf" do
    source "apache2.conf.erb"
    owner "root"
    group "root"
    mode 0644
#    notifies :restart, "service[apache2]"
end

template "/etc/apache2/ports.conf" do
    source "ports.conf.erb"
    owner "root"
    group "root"
    mode 0644
#    notifies :restart, "service[apache2]"
end


template "/etc/apache2/sites-available/default-ssl.conf" do
    source "default-ssl.conf.erb"
    owner "root"
    group "root"
    mode 0644
    notifies :restart, "service[apache2]"
end

service "apache2" do
   supports :status => true, :restart => true, :reload => true
   action [:enable, :start]
end

