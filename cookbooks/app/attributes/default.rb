#
# Cookbook Name:: app
#
# Copyright RightScale, Inc. All rights reserved.  All access and use subject to the
# RightScale Terms of Service available at http://www.rightscale.com/terms.php and,
# if applicable, other agreements such as a RightScale Master Subscription Agreement.

# By default listen on port 8000
set_unless[:app][:port] = 8000

default[:app][:packages] = []
default[:app][:setup_db_after_update_code] = 'true'