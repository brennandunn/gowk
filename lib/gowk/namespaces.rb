module Gowk
  module Namespaces
    
    @@namespaces = {}
    
    def namespaces ; @@namespaces ; end
    
    def namespace(name, &block)
      name = name.to_sym
      raise ArgumentError, 'expected a block' unless block_given?
      
      namespaces[name] = Space.new(name, self)
      namespaces[name].instance_eval(&block)
    end
    
    class Space
      include Namespaces, Tags
      
      attr_accessor :name, :parent
      
      def initialize(name, parent)
        self.name = name
        self.parent = parent
      end
      
      def full_name
        prefix = parent.is_a?(Space) ? parent.full_name : nil
        [prefix, self.name.to_s].compact.join(':')
      end
      
    end
    
  end
end