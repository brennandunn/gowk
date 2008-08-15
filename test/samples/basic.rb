class BasicTags < Gowk::Bundle
  
  tag :hello_world do
    'hello world'
  end
  
  tag :i18n_hello_world do
    world = 'hello world '
    
    output_for :default, :english do
      world += 'in english'
    end
    
    output_for :spanish do
      world += 'in espanol'
    end
    
    world
  end
  
  namespace :counting do
    
    tag :one do
      @count = 1
    end
    
    tag :two, :before => ['one'] do
      @count += 1
    end
    
    tag :three, :before => ['two'] do
      @count += 1
    end

    tag :display, :before => ['three'] do
      output_for(:number) { @count = @count.to_s }
      output_for(:word) { @count = 'three' if @count == 3 }
      output_for(:roman) { @count = 'iii' if @count == 3 }
      @count
    end
    
  end
  
  namespace :system do
    tag :uname do
      
    end
  end
  
end