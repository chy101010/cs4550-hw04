defmodule Practice.Calc do
  def parse_float(text) do
    try do 
      {num, _} = Float.parse(text)
      num
    rescue
      MatchError -> raise ArgumentError, "Invalid Argument Error. Put valid positive Integer"
    end 
  end

  #  Tokenize the expression: (e.g. [+, 1] => [{:op, "+"}, {:num, 1.0}]
  def tokenize(op) do
    case op do
      "+" -> {:op, "+"}
      "-" -> {:op, "-"}
      "/" -> {:op, "/"}
      "*" -> {:op, "*"}
       x  -> {:num, parse_float(x)}
        _  -> raise ArgumentError, "input error func tokenize, calc.ex"
    end
  end

  # Returns the precedence of an operator +, -, *, /
  def precedence(op) do
    case op do
      "+" -> 1
      "-" -> 1
      "*" -> 2
      "/" -> 2
       _ -> raise ArgumentError, "input error func precedence, calc.ex"
    end
  end

  # execute an operation based on the operator 
  def handleOperation(o1, o2, op) do
    errorMsg = "input error func handleOperation, calc.ex"
    if (!o1 || !o2 || (op === "/" && o1 == 0)) do
      raise ArgumentError, errorMsg
    end 
    case op do
      "+" -> o2 + o1
      "-" -> o2 - o1
      "/" -> o2 / o1 
      "*" -> o2 * o1
        _  -> raise ArgumentError, errorMsg
    end
  end


  # Returns true if the precedence of op1 >= op2  
  def push?(op1, op2) do
    precedence(op1) > precedence(op2)
  end

  # Return [:stack new stack, :operators [popped operators]]
  def handleStack(stack, value, acc) do
    if(stack == []) do
      [{:stack, [value]}, {:acc, acc}]
    else
      last = List.last(stack)
      if(push?(last, value)) do
        newStack = List.delete(stack, last)
        handleStack(newStack, value, acc ++ [{:op, last}])
      else
        [{:stack, stack ++ [value]}, {:acc, acc}]
      end
    end
  end

  # The expression is fully processed, appending the left over operators in the stack into the accumulator
  def convertPost([], stack, acc) do
    if(stack == []) do
      acc
    else
      last = List.last(stack)
      convertPost([], List.delete(stack, last), acc ++ [{:op, last}])
    end
  end

  # Processes the expression, adds operators and operants to the stack and accumalators 
  def convertPost([head | tail], stack, acc) do
    case head do
      {:num, value} -> convertPost(tail, stack, acc ++ [{:num, value}])
      {:op, value} -> 
        if(length(stack) === 0) do
          convertPost(tail, stack ++ [value], acc)
        else
          result = handleStack(stack, value, [])
          convertPost(tail, result[:stack], acc ++ result[:acc])
        end
    end
  end

  # Executes a prefix evaluation
  def prefixCalculator(prefix, stack) do
    if(prefix == []) do
      hd stack
    else 
      values = List.pop_at(prefix, length(prefix) - 1)
      case elem(values, 0) do
        {:num, value} -> prefixCalculator(elem(values, 1), stack ++ [value])
        {:op, value} ->
          len = length(stack)
          # right
          pop1 = List.pop_at(stack, len - 1)
          # left
          pop2 = List.pop_at(elem(pop1, 1), len - 2)
          result = handleOperation(elem(pop2, 0), elem(pop1, 0), value)
          prefixCalculator(elem(values, 1), elem(pop2, 1) ++ [result])
      end
    end
  end

  def checkArgument(str) do
    String.contains?(str, ["+", "*", "/"]) && String.length(str) > 1
  end 


  def calc(expr) do
    # This should handle +,-,*,/ with order of operations,
    # but doesn't need to handle parens.
    split = String.split(expr)
    
    if(Enum.any?(split, fn(str) -> checkArgument(str) end)) do
      raise ArgumentError, "Invalid Argument, put space "
    else
      split 
      |> Enum.map(fn value -> tokenize(value) end) 
      |> Enum.reverse
      |> convertPost([], [])
      |> Enum.reverse
      |> prefixCalculator([])
    end 

    # 2
    # Hint:
    # expr
    # |> split
    # |> tag_tokens  (e.g. [+, 1] => [{:op, "+"}, {:num, 1.0}]
    # |> convert to postfix
    # |> reverse to prefix
    # |> evaluate as a stack calculator using pattern matching
  end
end
