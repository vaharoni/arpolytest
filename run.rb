active_record_version = ActiveRecord.version rescue ActiveRecord::VERSION::STRING
override_method_text = Asset.respond_to?(:attachable_type=) ? 'overrides' : 'does not override'

asset1 = Asset.create!(attachable: MemberPost.first, url: 'http://www.google.com/url2')
result1 = asset1.attachable_type == 'Post' ? 'good' : 'bad'

asset2 = Asset.create!(attachable_type: GuestPost.name, attachable_id: GuestPost.first.id, url: 'http://www.google.com/url3')
result2 = asset2.attachable_type == 'Post' ? 'good' : 'bad'



puts nil
puts "ActiveRecord version #{active_record_version }"
puts "Asset #{override_method_text} `attachable_type=`"
puts nil
puts "Asset.new(attachable: MemberPost.first).attachable_type == '#{asset1.attachable_type}' (#{result1})"

member_post = MemberPost.first.destroy
result3 = Asset.where(attachable_id: member_post.id).count == 0 ? 'OK: Assets deleted' : 'Error: Assets left'
print "Destroying MemberPost and its dependent assets...#{result3}"

puts nil, nil
puts "Asset.new(attachable_type: GuestPost.name, attachable_type: GuestPost.first.id) == '#{asset2.attachable_type}' (#{result2})"

guest_post = GuestPost.first.destroy
result4 = Asset.where(attachable_id: guest_post.id).count == 0 ? 'OK: Assets deleted' : 'Error: Assets left'
print "Destroying GuestPost and its dependent assets...#{result4}"

puts nil, nil
puts "DB counts: There are #{Asset.count} assets, #{GuestPost.count} guest posts, #{MemberPost.count} member posts. All counts should be 0."

puts nil

