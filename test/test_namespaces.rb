require File.dirname(__FILE__) + '/test_helper.rb'

class TestNamespaces < Test::Unit::TestCase

  context 'defining namespaces' do
    
    should 'fail if namespace is not passed a block' do
      assert_raises ArgumentError do
        BasicTags.namespace(:bad_fruits)
      end
    end
    
    should 'find tags/namespaces from subclasses' do
      assert Gowk::Bundle.namespaces.key?(:system)
    end
    
    should 'create a basic namespace' do
      BasicTags.namespace(:fruits) {}
      assert BasicTags.namespaces.key?(:fruits)
    end
    
    should 'support nested namespaces' do
      BasicTags.namespace(:fruits) { namespace(:melons) {} }
      assert BasicTags.namespaces[:fruits].namespaces.key?(:melons)
    end
    
  end
  
  context 'defining tasks within namespaces' do
    
    should 'have one task within a namespace' do
      BasicTags.namespace(:fruits) { tag(:honeydew) {} }
      assert BasicTags.namespaces[:fruits].tags.key?(:honeydew)
    end
    
    should 'have tasks within nested namespaces' do
      BasicTags.namespace(:fruits) { namespace(:red) { tag(:apple) {} } }
      assert BasicTags.namespaces[:fruits].namespaces[:red].tags.key?(:apple)
    end
    
  end
  
  context 'readable namespace and task names' do
    
    should 'have a single namespace reflect itself' do
      BasicTags.namespace(:fruits) {}
      assert_equal 'fruits', BasicTags.namespaces[:fruits].full_name
    end
    
    should 'have nested namespaces be joined by colons' do
      BasicTags.namespace(:fruits) { namespace(:melons) {} }
      assert_equal 'fruits:melons', BasicTags.namespaces[:fruits].namespaces[:melons].full_name
    end
    
  end
  
end
