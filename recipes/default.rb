
#this is a dev vm only and not intended for shared use
execute "chmod usr local" do 
    command "chown -R vagrant:vagrant /usr/local"
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
