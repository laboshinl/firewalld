#
# Author:: Martin Janser (<martin@gogan.ch>)
# Copyright:: Copyright (c) 2013 Martin Janser <martin@gogan.ch>
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#


action :set do
  zone = ''
  if new_resource.zone
    zone = "--zone=#{new_resource.zone}"
  end

  if new_resource.service.kind_of?(String)
    services = [new_resource.service]
  else
    services = new_resource.service
  end
  
  if new_resource.port.kind_of?(String)
    ports = [new_resource.port]
  else
    ports = new_resource.port
  end
  
  services.each do |service|
    execute 'Permanently allow service' + service do
      not_if "firewall-cmd --permanent #{zone} --query-service=#{service}"
      command "firewall-cmd --permanent #{zone} --add-service=#{service}"
      notifies :restart, 'service[firewalld]'
    end
  end
  
  ports.each do |port|
    execute 'Permanently allow ' +new_resource.protocol + ' port '+port do
      not_if "firewall-cmd --permanent  #{zone} --query-port=#{port}/#{new_resource.protocol}"
      command "firewall-cmd --permanent #{zone} --add-port=#{port}/#{new_resource.protocol}"
      notifies :restart, 'service[firewalld]'
    end
  end
  new_resource.updated_by_last_action(true)
end

action :unset do
  zone = ''
  if new_resource.zone
    zone = " --zone=#{new_resource.zone}"
  end

  e = execute 'unset firewalld rule' do
    only_if "firewall-cmd --permanent#{zone} --query-port=#{new_resource.port}/#{new_resource.protocol}"
    command "firewall-cmd --permanent#{zone} --remove-port=#{new_resource.port}/#{new_resource.protocol}"
    notifies :restart, 'service[firewalld]'
  end
  new_resource.updated_by_last_action(true) if e.updated_by_last_action?
end
