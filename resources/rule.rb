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

actions :set, :unset
default_action :set

attribute :port,     :kind_of => [String, Array], :default => []
attribute :service,  :kind_of => [String, Array], :default => []
attribute :protocol, :kind_of => String,  :default => 'tcp'
attribute :zone,     :kind_of => String,  :name_attribune =>true
