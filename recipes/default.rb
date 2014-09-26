#
# Cookbook Name:: firewalld
# Recipe:: default
#
# Copyright 2013, Martin Janser <martin@gogan.ch>
#
# Apache 2.0 License.
#

package 'firewalld'

execute 'systemctl unmask firewalld'

service 'firewalld' do
  service_name 'firewalld.service'
  provider Chef::Provider::Service::Systemd
  action [:enable, :start] 
end
