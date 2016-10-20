Post.delete_all
Asset.delete_all

GuestPost.create! title: 'Guest post 1'

member_post = MemberPost.create! title: 'Member post 1'
asset = Asset.create! url: 'http://www.google.com/url1'
member_post.assets << asset
