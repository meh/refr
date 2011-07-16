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
  Environment = ::Class.new(::BasicObject) {
    def method_missing (id, *args, &block)
      id
    end
  }.new

  def initialize (name, vars)
    @getter = ::Kernel::eval("lambda { #{name} }", vars)
    @setter = ::Kernel::eval("lambda { |v| #{name} = v }", vars)
  end
  
  def __get__
    @getter.call
  end; alias ~ __get__
  
  def __set__ (val)
    @setter.call(val)
  end; alias =~ __set__

  def method_missing (id, *args, &block)
    if __get__.respond_to? id
      __get__.__send__(id, *args, &block)
    else
      super
    end
  end
end

def ref (&block)
  Reference.new(Reference::Environment.instance_eval(&block), block.binding)
end
