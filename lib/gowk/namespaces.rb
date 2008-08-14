module Gowk
  module Namespaces
    
    @@namespaces = {}
    
    def namespaces ; @@namespaces ; end
    
    def namespace(name, &block)
      name = name.to_sym
      raise ArgumentError, 'expected a block' unless block_given?
      
      namespaces[name] = Space.new(name)
      namespaces[name].instance_eval(&block)
    end
    
    class Space
      include Namespaces, Tags
      
      attr_accessor :name
      
      def initialize(name = nil)
        self.name = name
      end
      
    end
    
  end
end