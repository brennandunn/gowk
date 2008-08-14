module Gowk
  module Tags
    
    @@tags = {}
    
    def tags ; @@tags ; end
    
    def tag(name, &block)
      name = name.to_sym
      raise ArgumentError, 'expected a block' unless block_given?
      
      tags[name] = Tag.new(name, self, &block)
    end
    
    class Tag
      
      def initialize(name, parent, &block)
        
      end
      
    end
    
  end
end