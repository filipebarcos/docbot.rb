require 'rdoc'
require 'stringio'

module Docbot
  class Documentation
    def initialize
      @ri = RDoc::RI::Driver.new(RDoc::RI::Driver.process_args(%w[-T --format=markdown]))
      @ri.use_stdout = true
      @output = ''
      $stdout = StringIO.new(@output)
    end

    def for(name)
      return unless name
      @ri.display_name(name)
      $stdout = STDOUT
      @output
    rescue RDoc::RI::Driver::NotFoundError
      nil
    end
  end
end
