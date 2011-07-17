#--
#           DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                   Version 2, December 2004
#
#  Copyleft meh. [http://meh.paranoid.pk | meh@paranoici.org]
#
#           DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#  TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.
#++

class Reference < BasicObject
  def self.local (&block)
    self.new(block.call, block.binding)
  end

  def self.[] (value)
    self.local { :value }
  end

  BasicObject.instance_methods.each {|meth|
    tmp, $VERBOSE = $VERBOSE, nil
    undef_method meth
    $VERBOSE = tmp
  }

  def initialize (name, vars)
    begin
      @getter = ::Kernel::eval("lambda { #{name} }", vars)
      @setter = ::Kernel::eval("lambda { |v| #{name} = v }", vars)
    rescue ::Exception => e
      ::Kernel::raise ::NameError, "#{name} isn't a valid variable name"
    end
  end
  
  def __get_referenced__
    @getter.call
  end; alias ~ __get_referenced__
  
  def __set_referenced__ (val)
    @setter.call(val)
  end; alias =~ __set_referenced__

  def method_missing (id, *args, &block)
    __get__.__send__(id, *args, &block)
  end

  def __is_a_reference__; end
end
