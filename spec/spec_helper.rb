require File.dirname(__FILE__) + '/../lib/highrise'

def turn_methods_public(klass, method_name = nil)
  if method_name
    klass.class_eval do
      public method_name
    end
  else
    turn_all_methods_public klass
  end
end

def turn_all_methods_public(klass)
  klass.class_eval do
    private_instance_methods.each { |instance_method| public instance_method }
    private_methods.each { |method| public_class_method method } 
    protected_instance_methods.each { |instance_method| public instance_method }
    protected_methods.each { |method| public_class_method method } 
  end  
end
