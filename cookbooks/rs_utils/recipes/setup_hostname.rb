# Cookbook Name:: rs_utils
# Recipe:: setup_hostname
#
# Copyright (c) 2011 RightScale Inc
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

( log 'Setting hostname on OS X not supported.' and return ) if node['platform'] == 'mac_os_x'

rs_utils_hostname "set_system_hostname" do
  short_hostname node['rs_utils']['short_hostname']
  domain_name node['rs_utils']['domain_name']
  action :set
end

# Show the new host/node information (after ohai reload from provider)
ruby_block "show_host_info" do
  block do
    # show new host values from system
    Chef::Log.info("== New host/node information ==")
    Chef::Log.info("Hostname: #{`hostname`.strip == '' ? '<none>' : `hostname`.strip}")
    Chef::Log.info("Network node hostname: #{`uname -n`.strip == '' ? '<none>' : `uname -n`.strip}")
    Chef::Log.info("Alias names of host: #{`hostname -a`.strip == '' ? '<none>' : `hostname -a`.strip}")
    Chef::Log.info("Short host name (cut from first dot of hostname): #{`hostname -s`.strip == '' ? '<none>' : `hostname -s`.strip}")
    Chef::Log.info("Domain of hostname: #{`domainname`.strip == '' ? '<none>' : `domainname`.strip}")
    Chef::Log.info("FQDN of host: #{`hostname -f`.strip == '' ? '<none>' : `hostname -f`.strip}")
    Chef::Log.info("IP addresses for the hostname: #{`hostname -i`.strip == '' ? '<none>' : `hostname -i`.strip}")
  end
  action :create
end