class Revision < ActiveRecord::Base
  belongs_to :versionable, polymorphic: true
  belongs_to :version
end
