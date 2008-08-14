module Gowk
  class Bundle
    extend Namespaces, Tags
    
    class << self
      
      def find_tag(tag)
        breadcrumbs = tag.to_s.split(':')
        tail  = breadcrumbs.pop.to_sym
        
        ns = self
        until breadcrumbs.empty?
          next_crumb = breadcrumbs.shift
          ns = next_crumb.empty? ? nil : ns.namespaces[next_crumb.to_sym]
          return nil if ns.nil?
        end
        
        ns.tags[tail]
      end
      
    end
    
  end
end