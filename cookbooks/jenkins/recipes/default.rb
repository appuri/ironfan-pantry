#
# Cookbook Name::       jenkins
# Description::         Installs a Jenkins CI server using the http://jenkins-ci.org/redhat RPM.  The recipe also generates an ssh private key and stores the ssh public key in the node 'jenkins[:public_key]' attribute for use by the node recipes.
# Recipe::              default
# Author::              Doug MacEachern <dougm@vmware.com>
# Author::              Fletcher Nichol <fnichol@nichol.ca>
#
# Copyright 2010, VMware, Inc.
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

include_recipe 'java'
include_recipe 'silverware'
include_recipe 'volumes'

jenkins_server = discover(:jenkins, :server)
if jenkins_server
  jenkins_node = jenkins_server.node
  node[:jenkins][:server][:url]  = "http://#{jenkins_node[:fqdn]}:#{jenkins_node[:jenkins][:server][:port]}"
  node[:jenkins][:server][:port] = jenkins_node[:jenkins][:server][:port]
  node.save
end

package "jenkins"
