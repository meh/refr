Gem::Specification.new {|s|
	s.name         = 'refr'
	s.version      = '0.0.6'
	s.author       = 'meh.'
	s.email        = 'meh@paranoici.org'
	s.homepage     = 'http://github.com/meh/refr'
	s.platform     = Gem::Platform::RUBY
	s.summary      = 'Simple reference implementation'
	s.files        = Dir.glob('lib/**/*.rb')
	s.require_path = 'lib'

	s.add_dependency 'blankslate'

	s.add_development_dependency 'rake'
	s.add_development_dependency 'rspec'
}
