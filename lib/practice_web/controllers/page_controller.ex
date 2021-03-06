defmodule PracticeWeb.PageController do
  use PracticeWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def double(conn, %{"x" => x}) do
    {x, _} = Integer.parse(x)
    y = Practice.double(x)
    render conn, "double.html", x: x, y: y
  end

  def calc(conn, %{"expr" => expr}) do
    try do
      y = Practice.calc(expr)
      render conn, "calc.html", expr: expr, y: y
    rescue
      ArgumentError ->
      y = "Invalid Argument Error. Put a space inbetween operators and operants. Dosn't support 0 division"
      render conn, "calc.html", expr: expr, y: y
    end 
  end

  def factor(conn, %{"x" => x}) do
    try do
      y = Enum.join(Practice.factor(x), ", ")  
      render conn, "factor.html", x: x, y: y
    rescue
      ArgumentError ->
      y = "Invalid Argument Error. Put valid positive Integer"
      render conn, "factor.html", x: x, y: y
    end 
  end

  # TODO: Add an action for palindrome.
  # TODO: Add a template for palindrome over in lib/*_web/templates/page/??.html.eex
  def palindrome(conn, %{"expr" => expr}) do
    result = Practice.palindrome(expr)    
    render conn, "palindrome.html", expr: expr, result: result
  end
end
