defmodule Practice.Palindrome do
    def palindrome(expr) do
        expr === String.reverse(expr)
    end 
end