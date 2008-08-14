module Gowk
  module Tags
    
    @@tags = {}
    
    def tags ; @@tags ; end
    
    def tag(name, &block)
      name = name.to_sym
      raise ArgumentError, 'expected a block' unless block_given?
      
      tags[name] = Tag.new(name, self, &block)
      metaclass = class << self; self; end
      metaclass.send(:define_method, name) { run_tag(tags[name]) }
    end
    
    class Tag
      attr_accessor :name, :parent, :block
      
      def initialize(name, parent, &block)
        self.name = name
        self.parent = parent
        self.block = block or raise ArgumentError, 'tag requires a block'
      end
      
      def full_name
        prefix = parent.respond_to?(:full_name) ? parent.full_name : nil
        [prefix, name.to_s].compact.join(':')
      end
      
    end
    
  end
end