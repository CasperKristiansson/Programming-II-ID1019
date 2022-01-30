defmodule Emulator do
  @moduledoc """
    This module is the heart of the system. It should be able
    to take a program, transform it to a code and data segment and then
    execute the program and return the output.
  """
  def run(prgm) do
    {code, data} = Program.load(prgm)
    out = Out.new()
    reg = Register.new()
    run(0, code, reg, data, out)
  end

  def run(pc, code, reg, mem, out) do
    next = Program.read_instruction(code, pc)
    break = false

    case next do
      :halt ->
        Out.close(out)
        break = true

      {:out, rs} ->
        s = Register.read(reg, rs)
        out = Out.put(out, s)

      {:add, rd, rs, rt} ->
        IO.write('Add')
        s = Register.read(reg, rs)
        t = Register.read(reg, rt)

      {:sub, rd, rs, rt} ->
        IO.write('sub')
        s = Register.read(reg, rs)
        t = Register.read(reg, rt)

      {:addi, rt, rs, imm} ->
        IO.write('Addi')
        s = Register.read(reg, rs)

      {:lw, rt, rs, imm} ->
        IO.write('Lw')
        s = Register.read(reg, rs)

      {:sw, rt, rs, imm} ->
        IO.write('Sw')
        s = Register.read(reg, rs)

      {:beq, rs, rt, imm} ->
        IO.write('Beq')
        s = Register.read(reg, rs)
    end

    if !break do
      pc = pc + 4
      run(pc, code, reg, mem, out)
    end
  end
end
