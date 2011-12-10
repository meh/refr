#--
#           DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                   Version 2, December 2004
#
#           DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#  TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.
#++

require 'blankslate'

class Reference < BlankSlate
	class << self
		def normalize (value)
			if (value.___is_a_reference___ rescue false)
				value.___get_referenced___
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

	def initialize (name, binding)
		begin
			@getter = Kernel::eval("lambda { #{name} }", binding)
			@setter = Kernel::eval("lambda { |v| #{name} = v }", binding)
		rescue Exception => e
			Kernel::raise NameError, "#{name} isn't a valid variable name"
		end
	end

	def ___get_referenced___
		@getter.call
	end; alias ~ ___get_referenced___

	def ___set_referenced___ (val)
		@setter.call(val)
	end; alias =~ ___set_referenced___

	def method_missing (id, *args, &block)
		___get_referenced___.__send__(id, *args, &block)
	end

	def ___is_a_reference___; true; end
end

module Kernel
	def Reference (*args, &block)
		if args.empty? && block
			Reference.local(&block)
		else
			Reference[*args]
		end
	end
end
