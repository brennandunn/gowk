require File.dirname(__FILE__) + '/test_helper.rb'

class TestParser < Test::Unit::TestCase
  
  context 'parsing a string' do
    
    should 'handle a simple tag' do
      output = Gowk.parse('Welcome to the { PageTitle }')
      assert_equal 'Welcome to the Home Page', output
    end
    
  end
  
end