defmodule Practice.Factor do
    def parse_int(text) do
        num = String.to_integer(text)
        num
    end

    def recursiveDive(value, i, acc) do
        if(rem(value, i) === 0) do
            recursiveDive(div(value, i), i, acc ++ [i])
        else
            [{:value, value}, {:acc, acc}]
        end
    end

    def findFactors(value, i, acc) do
        if(value <= 0) do
            raise ArgumentError, "Positive value only"
        end 
        if(rem(value, 2) === 0) do
            findFactors(div(value, 2), i, acc ++ [2])
        else
            if(i <= :math.sqrt(value)) do
                if(rem(value, i) === 0 ) do
                    recursiveDive(value, i, acc)
                    |> (fn(tuple) -> findFactors(tuple[:value], i + 2, tuple[:acc]) end).()
                else
                    findFactors(value, i + 2, acc)
                end
            else 
                if(value > 2) do
                    acc ++ [value]
                else
                    acc
                end
            end
        end
    end

    def factor(expr) do
        if(is_integer(expr)) do
            findFactors(expr, 3, [])
        else 
            parse_int(expr)
            |> findFactors(3, [])
        end
    end
end