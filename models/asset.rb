class Asset < ActiveRecord::Base
  belongs_to :attachable, polymorphic: true

  # Uncomment this out if you want to test what is suggested in the documentation.
  # def attachable_type=(class_name)
  #   super(class_name.constantize.base_class.to_s)
  # end
end
