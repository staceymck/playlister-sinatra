module Slugifiable

  module InstanceMethods
    def slug
      slug = self.name.strip.downcase

      slug.gsub!(/['`]/,"")
      slug.gsub!(/[$]/, "s")
      slug.gsub!(/\s*@\s*/, " at ")
      slug.gsub!(/\s*&\s*/, " and ")
      slug.gsub!(/feat.|ft./, "ft")
      slug.gsub!(/_+/,"_")
      slug.gsub!(/\s*[^A-Za-z0-9\.\_]\s*/, '-')
      slug.gsub!(/\A[-\.]+|[-\.]+\z/,"")

      slug
    end
  end 

  module ClassMethods
    def find_by_slug(slug)
      self.find {|artist| artist.slug == slug}
    end
  end
end