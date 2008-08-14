require File.dirname(__FILE__) + '/test_helper.rb'

class TestRender < Test::Unit::TestCase
  
  context 'the execution of a tag' do
    
    should 'test the hello world tag' do
      output = Gowk.render_tag(:hello_world)
      assert_equal 'hello world', output
    end
    
  end
  
  context 'output for contexts' do
    
    should 'be a cunning linguist' do
      assert_equal 'hello world in english', Gowk.render_tag(:i18n_hello_world)
      assert_equal 'hello world in espanol', Gowk.render_tag(:i18n_hello_world, :context => :spanish)
    end
        
  end
  
end