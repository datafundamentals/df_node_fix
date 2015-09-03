#
# Cookbook Name:: df_node_fix
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

# there is a node for home but I don't know what it is
directory node['dfdevm_nodeschool']['npm-global-dir'] do 
    mode "0755"
    owner "vagrant"
    group "vagrant"
    recursive true
    action :create 
end


execute "reconfigure node" do 
    cwd node['dfdevm_nodeschool']['home']
    command "npm config set prefix '" + node['dfdevm_nodeschool']['npmrc'] + "'"
    action :run
end

template node['dfdevm_nodeschool']['npmrc'] do
  source 'npmrc.erb'
  mode "0755"
end

template '/etc/profile.d/nodeJsFix.sh' do
    owner "vagrant"
    group "vagrant"
  source 'nodeJsFix.sh.erb'
  mode "0777"
end

template '/home/vagrant/README_NODEJS.txt' do
    owner "vagrant"
    group "vagrant"
  source 'README_NODEJS.txt.erb'
  mode "0755"
end

template '/home/vagrant/node_fix_attribute_values.txt' do
    owner "vagrant"
    group "vagrant"
  source 'attribute_values.txt.erb'
  mode "0755"
end


directory node['dfdevm_nodeschool']['nvm'] do 
    mode "0777"
    owner "vagrant"
    group "vagrant"
    recursive true
    action :create 
end

execute "try installing nvm from git" do 
    user "vagrant"
    group "vagrant"
    cwd node['dfdevm_nodeschool']['nvm']
    command "git clone https://github.com/creationix/nvm.git ~/.nvm && cd ~/.nvm && git checkout `git describe --abbrev=0 --tags`"
    action :run
    not_if { File.exists?('/home/vagrant/.nvm/nvm.sh') }
end

template '/etc/profile.d/enable_nvm.sh' do
    owner "vagrant"
    group "vagrant"
  source 'enable_nvm.sh.erb'
  mode "0777"
end

execute "try executing nvm" do 
    user "vagrant"
    group "vagrant"
    cwd node['dfdevm_nodeschool']['nvm']
    command ". /home/vagrant/.nvm/nvm.sh"
    action :run
    only_if { File.exists?('/home/vagrant/.nvm/nvm.sh') }
    retries 10
end

#living dangerously!
execute "chmod usr local" do 
    command "chown -R vagrant:vagrant /usr/local"
    action :run
end