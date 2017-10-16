namespace :webforms do
  desc 'Transfer a batch'
  # actions are UPDITEMTYPE, UPDCURLOC, UPDHOMELOC, WITHDRAW, TRANSFER
  # if not from web then user_name 'batch', priority 2
  # TODO DRY rake tasks up!
  task :transfer_items, %i[path_to_file current_lib new_lib new_homeloc new_curloc
                           new_itype email comments] => :environment do |_t, args|
    barcodes = IO.read(args[:path_to_file]).split("\n").uniq
    @uni_updates_batch = UniUpdatesBatch.create(batch_date: Time.current,
                                                user_name: 'batch',
                                                user_email: args[:email],
                                                action: 'TRANSFER',
                                                priority: 2,
                                                export_yn: 'SocI',
                                                orig_lib: args[:current_lib],
                                                new_lib: args[:new_lib],
                                                new_homeloc: args[:new_homeloc],
                                                new_curloc: args[:new_curloc],
                                                new_itype: args[:new_itype],
                                                check_bc_first: 'N',
                                                total_bcs: barcodes.length,
                                                pending: 'Y',
                                                comments: args[:comments])
    filtered_item_ids = UniUpdates.filter_duplicates(barcodes)
    uniques = filtered_item_ids[0]
    duplicates = filtered_item_ids[1].join(' ')
    UniUpdates.create_for_batch(uniques, @uni_updates_batch)
    puts "Batch id #{@uni_updates_batch.batch_id} created"
    WebformsMailer.batch_upload_email(@uni_updates_batch, duplicates).deliver_now
  end
end
namespace :webforms do
  desc 'Withdraw a batch'
  task :withdraw_items, %i[path_to_file current_lib email comments] => :environment do |_t, args|
    barcodes = IO.read(args[:path_to_file]).split("\n").uniq
    @uni_updates_batch = UniUpdatesBatch.create(batch_date: Time.current,
                                                user_name: 'batch',
                                                user_email: args[:email],
                                                action: 'WITHDRAW',
                                                priority: 2,
                                                export_yn: 'SocI',
                                                orig_lib: args[:current_lib],
                                                check_bc_first: 'N',
                                                total_bcs: barcodes.length,
                                                pending: 'Y',
                                                comments: args[:comments])
    filtered_item_ids = UniUpdates.filter_duplicates(barcodes)
    uniques = filtered_item_ids[0]
    duplicates = filtered_item_ids[1].join(' ')
    UniUpdates.create_for_batch(uniques, @uni_updates_batch)
    puts "Batch id #{@uni_updates_batch.batch_id} created"
    WebformsMailer.batch_upload_email(@uni_updates_batch, duplicates).deliver_now
  end
end
namespace :webforms do
  desc 'Change home location of a batch'
  task :change_home_location, %i[path_to_file current_lib new_homeloc
                                 new_curloc new_itype email comments] => :environment do |_t, args|
    barcodes = IO.read(args[:path_to_file]).split("\n").uniq
    @uni_updates_batch = UniUpdatesBatch.create(batch_date: Time.current,
                                                user_name: 'batch',
                                                user_email: args[:email],
                                                action: 'UPDHOMELOC',
                                                orig_lib: args[:current_lib],
                                                new_homeloc: args[:new_homeloc],
                                                new_curloc: args[:new_curloc],
                                                new_itype: args[:new_itype],
                                                priority: 2,
                                                export_yn: 'SocI',
                                                check_bc_first: 'N',
                                                total_bcs: barcodes.length,
                                                pending: 'Y',
                                                comments: args[:comments])
    filtered_item_ids = UniUpdates.filter_duplicates(barcodes)
    uniques = filtered_item_ids[0]
    duplicates = filtered_item_ids[1].join(' ')
    UniUpdates.create_for_batch(uniques, @uni_updates_batch)
    puts "Batch id #{@uni_updates_batch.batch_id} created"
    WebformsMailer.batch_upload_email(@uni_updates_batch, duplicates).deliver_now
  end
end
namespace :webforms do
  desc 'Change current location of a batch'
  task :change_current_location, %i[path_to_file current_lib
                                    new_curloc email comments] => :environment do |_t, args|
    barcodes = IO.read(args[:path_to_file]).split("\n").uniq
    @uni_updates_batch = UniUpdatesBatch.create(batch_date: Time.current,
                                                user_name: 'batch',
                                                user_email: args[:email],
                                                action: 'UPDCURLOC',
                                                orig_lib: args[:current_lib],
                                                new_curloc: args[:new_curloc],
                                                priority: 2,
                                                export_yn: 'SocI',
                                                check_bc_first: 'N',
                                                total_bcs: barcodes.length,
                                                pending: 'Y',
                                                comments: args[:comments])
    filtered_item_ids = UniUpdates.filter_duplicates(barcodes)
    uniques = filtered_item_ids[0]
    duplicates = filtered_item_ids[1].join(' ')
    UniUpdates.create_for_batch(uniques, @uni_updates_batch)
    puts "Batch id #{@uni_updates_batch.batch_id} created"
    WebformsMailer.batch_upload_email(@uni_updates_batch, duplicates).deliver_now
  end
end
namespace :webforms do
  desc 'Change item type of a batch'
  task :change_item_type, %i[path_to_file current_lib new_itype
                             email comments] => :environment do |_t, args|
    barcodes = IO.read(args[:path_to_file]).split("\n").uniq
    @uni_updates_batch = UniUpdatesBatch.create(batch_date: Time.current,
                                                user_name: 'batch',
                                                user_email: args[:email],
                                                action: 'UPDITEMTYPE',
                                                orig_lib: args[:current_lib],
                                                new_itype: args[:new_itype],
                                                priority: 2,
                                                export_yn: 'N',
                                                check_bc_first: 'N',
                                                total_bcs: barcodes.length,
                                                pending: 'Y',
                                                comments: args[:comments])
    filtered_item_ids = UniUpdates.filter_duplicates(barcodes)
    uniques = filtered_item_ids[0]
    duplicates = filtered_item_ids[1].join(' ')
    UniUpdates.create_for_batch(uniques, @uni_updates_batch)
    puts "Batch id #{@uni_updates_batch.batch_id} created"
    WebformsMailer.batch_upload_email(@uni_updates_batch, duplicates).deliver_now
  end
end
namespace :webforms do
  desc 'Delete a batch'
  task :delete_batch, [:batch_id] => :environment do |_t, args|
    uni_updates_batch = UniUpdatesBatch.find(args[:batch_id])
    puts "Deleting batch id #{uni_updates_batch.batch_id}"
    uni_updates_batch.destroy
    WebformsMailer.batch_delete_email(uni_updates_batch).deliver_now
  end
end
