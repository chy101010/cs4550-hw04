defmodule Practice.PracticeTest do
  use ExUnit.Case
  import Practice

  test "double some numbers" do
    assert double(4) == 8
    assert double(3.5) == 7.0
    assert double(21) == 42
    assert double(0) == 0
  end

  test "factor some numbers" do
    assert factor(5) == [5]
    assert factor(8) == [2,2,2]
    assert factor(12) == [2,2,3]
    assert factor(226037113) == [3449, 65537]
    assert factor(1575) == [3,3,5,5,7]
  end

  test "evaluate some expressions" do
    assert calc("5") == 5
    assert calc("5 + 1") == 6
    assert calc("5 * 3") == 15
    assert calc("10 / 2") == 5
    assert calc("10 - 2") == 8
    assert calc("5 * 3 + 8") == 23
    assert calc("8 + 5 * 3") == 23
    # more tests
    assert calc("8 + 5 * 10 / 10 + 20") == 33
    assert calc("8 * 5 * 10 - 10 * 20") == 200
    assert calc("10 - -5 - 10 - 10 * 20") == -195
    assert calc("10 + 5 / 5 * 10") == 20
    assert calc("10 + 5 / 5 * -2") == 8
  end

  # TODO: Add two unit tests for palindrome.
  test "some strings" do
    assert palindrome("aba") === true
    assert palindrome("vaa") === false
    assert palindrome("12345|54321") === true
    assert palindrome("abccba") === true
    assert palindrome("abba") === true
  end
end
