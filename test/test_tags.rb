require File.dirname(__FILE__) + '/test_helper.rb'

class TestTags < Test::Unit::TestCase
  
  context 'test naming' do
    
    should 'be itself without a namespace' do
      BasicTags.tag(:fruit) {}
      assert_equal 'fruit', BasicTags.tags[:fruit].full_name
    end
    
    should 'include namespace full name' do
      BasicTags.namespace(:fruits) { tag(:berry) {} }
      assert_equal 'fruits:berry', BasicTags.namespaces[:fruits].tags[:berry].full_name
    end
        
  end
  
end