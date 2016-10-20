This repo can be used to test the way polymorphic associations in Rails behave with Single Table Inheritance.
The motivation was the discussion in the documentation [here]
(http://api.rubyonrails.org/classes/ActiveRecord/Associations/ClassMethods.html#module-ActiveRecord::Associations::ClassMethods-label-Polymorphic+Associations).

The documentation suggests that if the polymorphic `belongs_to` association points at a model that implements STI,
e.g. it could receive `MemberPost` or `GuestPost` both inheriting from `Post`, then we need to ensure we store the
base class `Post` in the type field `attachable_type`.

While this makes sense, it further suggests to override the `attachable_type=` method to ensure this happens if we
run `Asset.new(attachable: post)`:
```ruby
class Asset < ActiveRecord::Base
  belongs_to :attachable, polymorphic: true

  def attachable_type=(class_name)
     super(class_name.constantize.base_class.to_s)
  end
end
```

This repo contains the models in the example discussed in the documentation. Its DB is initialized with one `GuestPost`,
one `MemberPost`, and one `Asset` which is assigned to the member post by doing `member_post.assets << asset`.

Playing with this repo suggests that ActiveRecord already stores the base class of the provided model. This is
ActiveRecord's behavior at least all the way up to version 3.2.22.5. Previous versions might also behave this way, I
just didn't test them.

To work with this repo:
  1. In the `Gemfile`, set the ActiveRecord version to the desired version. All available versions can be found [here]
  (https://rubygems.org/gems/activerecord/versions).

  2. Run `bundle/install`.

  3. Optionally, consider uncommenting the `attachable_type=` in Asset. Currently it is commented out, i.e. you're
  testing the scenario in which we do not heed the advice in the documentation.

  4. Execute `bin/run` in your terminal to run the auto-tester.

  5. Optionally, play with additional scenarios by running `bin/console`.
