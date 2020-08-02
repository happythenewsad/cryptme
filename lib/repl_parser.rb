require 'clipboard'

module Melon
  class REPLParser
    class << self 
      attr_accessor :melon 

      def validate(&block)
        result = begin
          yield block
        rescue => e
          puts "#{self.class}: Validation error: #{e}"
          false
        end
        puts "Invalid input! \n" << usage unless result 
        result
      end

      def parse(inp)
        case inp.first.to_sym
        when :help
          puts usage
        when :quit
          melon.persist
          exit
        when :list 
          puts melon.list
        when :get
          return unless validate { inp.length == 2 && inp[1] }
          puts "The value of key '#{inp[1]}' has been copied to your clipboard."
          Clipboard.copy melon.get(inp[1])
        when :set
          return unless validate { inp.length == 3 && inp[1] && inp[2] }
          melon.put(inp[1], inp[2])
        when :changepwd
          melon.changepwd
        else
          puts "Invalid command."
        end
      end

      def usage
        <<~HEREDOC
          Available commands:
            help\t\t\tprints available commands 
            quit\t\t\tsaves latest melon state and quits
            list\t\t\tlists current melon keys
            get KEY\t\tprints value of a given key
            set KEY VALUE\t\tsets value of a given key
            changepwd\t\tupdates the current melon's password
        HEREDOC
      end
    end
  end
end