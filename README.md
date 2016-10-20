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

This repo contains the models in the example discussed in the documentation. Playing with it suggests that ActiveRecord
already stores the base class of the provided model, all the way up to ActiveRecord version 3.2.22.5 (previous versions
might also support it, they were simply not tested).

Usage:
  1. In the `Gemfile`, set the ActiveRecord version to the desired version. All available versions can be found [here]
  (https://rubygems.org/gems/activerecord/versions).
  2. Execute `bin/run` in your terminal.

To play with additional scenarios, run `bin/console` in your terminal.

