defmodule Test do
  def processing() do
    take = Processing.take([1,2,3,4,5], 2)
    drop = Processing.drop([1,2,3,4,5], 2)
    append = Processing.append([1,2,3,4,5], [6,7,8,9,10])
    member = Processing.member([1,2,3,4,5], 3)
    position = Processing.position([1,2,3,4,5], 3)
    {
      :take, take,
      :drop, drop,
      :append, append,
      :member, member,
      :position, position
    }
  end

  def single() do
    state = {[:a,:b],[:c,:d],[:e,:f]}
    state1 = Moves.single({:one,1}, state)
    state2 = Moves.single({:two,1}, state1)
    state3 = Moves.single({:one,-2}, state2)
    {
      :state, state,
      :state1, state1,
      :state2, state2,
      :state3, state3
    }
  end

  def multiple() do
    states = Moves.move([{:one, 1},{:two, 1},{:one, -1}], {[:a,:b],[],[]})
    {
      :states, states
    }
  end
end
