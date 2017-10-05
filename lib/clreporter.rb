require 'command_line_reporter'
require 'colorize'
require 'colorized_string'

class Example
  include CommandLineReporter

  def run
    suppress_output

    table border: true do
      row do
        column 'MY NAME IS REALLY LONG AND WILL WRAP AND HOPE', width: 20, align: 'center', color: 'blue'
        column 'ADDRESS', width: 30, padding: 5
        column 'CITY', width: 15
      end
      row bold: true do
        column 'caeser'
        column '1 Appian Way'
        column 'Rome'
      end
      row do
        column 'Richard Feynman'
        column '1 Golden Gate'
        column 'Quantum Field'
      end
    end

    return capture_output
  end
end

FORMAT = Example.new
