module Slugged
  module InstanceMethods
    def slug
      self.username.parameterize
    end
  end
  
  module ClassMethods
    def find_by_slug(slug)
      self.all.find {|instance| instance.slug == slug}
    end
  end
end