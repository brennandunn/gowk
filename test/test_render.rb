require File.dirname(__FILE__) + '/test_helper.rb'

class TestRender < Test::Unit::TestCase
  
  context 'the execution of a tag' do
    
    should 'test the hello world tag' do
      output = Gowk.render_tag(:hello_world)
      assert_equal 'hello world', output
    end
    
  end
  
  context 'output with contexts' do
    
    should 'be a cunning linguist' do
      assert_equal 'hello world in english', Gowk.render_tag(:i18n_hello_world)
      assert_equal 'hello world in espanol', Gowk.render_tag(:i18n_hello_world, :context => :spanish)
    end
        
  end
  
  context 'output with hooks' do
    
    should 'count to three' do
      # execution stack: one, two, three
      assert_equal 3, Gowk.render_tag(:counting, :three)
    end
    
    should 'display the counting output differently depending on context' do
      assert_equal '3', Gowk.render_tag(:counting, :display, :context => :number)
      assert_equal 'three', Gowk.render_tag(:counting, :display, :context => :word)
      assert_equal 'iii', Gowk.render_tag(:counting, :display, :context => :roman)
    end
    
  end
  
end