#! /usr/bin/env ruby
require 'rubygems'
require 'refr'

describe Reference do
  describe '.local' do
    it 'changes correctly the referenced variable' do
      lol = 2
      ref = Reference{:lol}

      ref =~ 3
      lol.should == 3
    end
  end
end
