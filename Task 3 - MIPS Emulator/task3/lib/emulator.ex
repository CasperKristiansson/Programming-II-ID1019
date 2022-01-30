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
    case next do
      :halt ->
        { reg, mem, out}

      {:out, rs} ->
        s = Register.read(reg, rs)
        out = Out.put(out, s)

        pc = pc + 4
        run(pc, code, reg, mem, out)

      {:add, rd, rs, rt} ->
        IO.write('Add')
        s = Register.read(reg, rs)
        t = Register.read(reg, rt)
        reg = Register.write(reg, rd, s + t)

        pc = pc + 4
        run(pc, code, reg, mem, out)

      {:sub, rd, rs, rt} ->
        IO.write('sub')
        s = Register.read(reg, rs)
        t = Register.read(reg, rt)
        reg = Register.write(reg, rd, s - t)

        pc = pc + 4
        run(pc, code, reg, mem, out)

      {:addi, rt, rs, imm} ->
        IO.write('Addi')
        s = Register.read(reg, rs)
        reg = Register.write(reg, rt, s + imm)

        pc = pc + 4
        run(pc, code, reg, mem, out)

      {:lw, rt, rs, imm} ->
        address = Program.load_address(mem, imm) + rs
        reg = Register.write(reg, rt, address)

        pc = pc + 4
        run(pc, code, reg, mem, out)

      {:sw, rt, rs, imm} ->
        IO.write('Sw')
        s = Register.read(reg, rt)
        address = Program.load_address(mem, imm) + rs
        mem = Program.write(mem, address, s)

        pc = pc + 4
        run(pc, code, reg, mem, out)

      {:beq, rs, rt, imm} ->
        IO.write('Beq')
        s = Register.read(reg, rs)
        t = Register.read(reg, rt)

        if s == t do
          pc = imm + 4
        else
          pc = pc + 4
        end
        run(pc, code, reg, mem, out)

      {:label, label} ->

    end
  end
end
