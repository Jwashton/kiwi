defmodule CalculatorTest do
  use ExUnit.Case, async: true

  test "a calculator's starting value is 0" do
    calculator = Calculator.start()

    assert Calculator.value(calculator) == 0
  end

  test "a bunch of operations" do
    calculator = Calculator.start()

    Calculator.add(calculator, 10)
    Calculator.sub(calculator, 5)
    Calculator.mul(calculator, 3)
    Calculator.div(calculator, 5)

    assert Calculator.value(calculator) == 3
  end
end
