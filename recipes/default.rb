#
# Cookbook Name:: god
# Recipe:: default
#
# Copyright 2009, Opscode, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

gem_package "god" do
  action :install
end

bash "create rvm god wrapper" do
  code <<-EOH
  rvm wrapper 1.9.3-p194 bootup god
  EOH
end

template "/etc/init.d/god" do
  source "god.init.erb"
  owner "root"
  group "root"
  mode "0755"
end

directory "/etc/god/conf.d" do
  recursive true
  owner "root"
  group "root"
  mode 0755
end

template "/etc/god/master.god" do
  source "master.god.erb"
  owner "root"
  group "root"
  mode 0755
end

service "god" do
  supports :status => true, :restart => true, :reload => true
  action [:enable, :start]
end
