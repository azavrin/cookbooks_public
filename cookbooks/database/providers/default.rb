include RightScale::Database::Helper

action :backup do
  @db = init(new_resource)
  block_device_args = { 
    :max_snapshots => new_resource.max_snapshots,
    :keep_dailies => new_resource.keep_daily,
    :keep_weeklies => new_resource.keep_weekly,
    :keep_monthlies => new_resource.keep_monthly,
    :keep_yearlies => new_resource.keep_yearly,
    
    :storage_type => new_resource.storage_type,  # "ros"|"volume" 
    :storage_account_id => new_resource.storage_account_id,
    :storage_account_secret => new_resource.storage_account_secret,
    :storage_container => new_resource.storage_container
  }
  @db.action_backup(new_resource.lineage, block_device_args)
end

action :restore do
  @db = init(new_resource)
  block_device_args = { 
    :storage_type => new_resource.storage_type,  # "ros"|"volume" 
    :storage_account_id => new_resource.storage_account_id,
    :storage_account_secret => new_resource.storage_account_secret,
    :storage_container => new_resource.storage_container
  }
  @db.action_restore(new_resource.lineage, block_device_args, new_resource.timestamp_override, new_resource.from_master, new_resource.force)
end

action :create do
  @db = init(new_resource)
  block_device_args = { 
    :storage_type => new_resource.storage_type,  # "ros"|"volume" 
    :volume_size => new_resource.volume_size,
    :stripe_count => new_resource.stripe_count
  }
  @db.action_create(block_device_args)
end
