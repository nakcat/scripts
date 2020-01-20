#!/usr/bin/env ruby
# Reverse Polish Notation Calculator
# + - * / ** %
# q:quit c:copy d:delete s:switch

def _calc operator
  (operand1, operand2) = @stack.pop 2
  @stack.unshift @stack.first
  @stack.push operand1.send(operator.to_sym, operand2)
end

def _command command
  if command == 'q'
    exit
  end
  if command == 'c'
    @stack.shift
    @stack.push @stack.last
  end
  if command == 'd'
    @stack.pop
    @stack.unshift @stack.first
  end
  if command == 's'
    (operand1, operand2) = @stack.pop 2
    @stack.push(operand2, operand1)
  end
end

def _push num
  @stack.shift
  @stack.push num
end

def _print
  print `clear`
  puts ' Reverse Polish Notation Calculator v0.0.1.a'
  puts ' + - * / ** %'
  puts ' q:quit'
  puts ' c:copy last to next to last'
  puts ' d:delete last'
  puts ' s:switch last and next to last'
  @stack.each_with_index{|st, i| printf("(%d): %16.4f\n", i, st)}
end

def _main
  while true do
    _print
    begin
      print 'rpn>> '
      input = (gets || '').chomp
    rescue Interrupt => e
      _command 'q'
    end
    if input =~ %r!\A(\+|-|\*|/|%|\*\*)\z!
      _calc $1
    elsif input =~ %r!\A(q|c|d|s)\z!
      _command $1
    else
      _push input.to_f
    end
  end
end

@stack = [0.0, 0.0, 0.0, 0.0]
_main
