asset = Asset.new(attachable: MemberPost.first)
result = asset.attachable_type == 'Post' ? 'good' : 'bad'
active_record_version = ActiveRecord.version rescue ActiveRecord::VERSION::STRING
override_method_text = Asset.respond_to?(:attachable_type=) ? 'overrides' : 'does not override'

puts nil
puts "ActiveRecord version #{active_record_version }"
puts "Asset #{override_method_text} `attachable_type=`"
puts nil
puts "Asset.new(attachable: MemberPost.first).attachable_type == '#{asset.attachable_type}' (#{result})"
print 'Trying to destroy MemberPost and its dependent assets...'

begin
  MemberPost.first.destroy
  print 'OK'
rescue
  print 'Error'
end

puts nil
