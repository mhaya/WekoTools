# -*- coding: utf-8 -*-

# インストール

node['php']['install_packages'].each do |pkg|
  package "#{pkg}" do
    action :install
  end
end