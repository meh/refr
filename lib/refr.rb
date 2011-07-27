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

class Reference
  class << self
    def normalize (value)
      if (value.___is_a_reference___ rescue false)
        value.__get_referenced__
      else
        value
      end
    end; alias - normalize

    def local (&block)
      self.new(block.call, block.binding)
    end

    def [] (value, force=false)
      if (value.___is_a_reference___ rescue false) && !force
        value
      else
        self.local { :value }
      end
    end
  end

  tmp, $VERBOSE = $VERBOSE, nil
  Object.instance_methods.each {|meth|
    undef_method meth
  }
  $VERBOSE = tmp

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
    __get_referenced__.__send__(id, *args, &block)
  end

  def ___is_a_reference___; true; end
end
