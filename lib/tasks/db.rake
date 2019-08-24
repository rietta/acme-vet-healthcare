namespace :db do
 desc 'Scan for missing foreign key indexes. Based on the blog by Alex Peattie at https://alexpeattie.com/blog/stop-forgetting-foreign-key-indexes-in-rails-post-migration-script.'
 task find_missing_fk_indexes: :environment do
   tables = ActiveRecord::Base.connection.tables
   all_foreign_keys = tables.flat_map do |table_name|
     ActiveRecord::Base.connection.columns(table_name).map { |c| [table_name, c.name].join('.') }
   end.select { |c| c.ends_with?('_id') || c.ends_with?('_uuid') }

   indexed_columns = tables.map do |table_name|
     ActiveRecord::Base.connection.indexes(table_name).map do |index|
       columns = if index.columns.is_a? String
                   [index.columns]
                 else
                   index.columns
                 end
       columns.map { |c| [table_name, c].join('.') }
     end
   end.flatten

   unindexed_foreign_keys = (all_foreign_keys - indexed_columns)

   if unindexed_foreign_keys.any?
     warn(
       "WARNING: The following foreign key columns don't have an index, " \
       'which can hurt performance. Consider adding the following to ' \
       'a migration.'
     )

     unindexed_foreign_keys.each do |unindexed|
       parts = unindexed.split('.', 2)
       warn("add_index :#{parts[0].to_sym}, :#{parts[1].to_sym}\n")
     end

   end
 end

 Rake::Task['db:migrate'].enhance do
   Rake::Task['db:find_missing_fk_indexes'].invoke
 end
end
