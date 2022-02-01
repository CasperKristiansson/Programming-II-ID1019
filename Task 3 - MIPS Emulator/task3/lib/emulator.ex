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
        out = Out.close(out)
        { reg, mem, out }

      {:out, rs} ->
        s = Register.read(reg, rs)
        out = Out.put(out, s)

        pc = pc + 4
        run(pc, code, reg, mem, out)

      {:add, rd, rs, rt} ->
        s = Register.read(reg, rs)
        t = Register.read(reg, rt)
        reg = Register.write(reg, rd, s + t)

        pc = pc + 4
        run(pc, code, reg, mem, out)

      {:sub, rd, rs, rt} ->
        s = Register.read(reg, rs)
        t = Register.read(reg, rt)
        reg = Register.write(reg, rd, s - t)

        pc = pc + 4
        run(pc, code, reg, mem, out)

      {:addi, rt, rs, imm} ->
        s = Register.read(reg, rs)
        reg = Register.write(reg, rt, s + imm)

        pc = pc + 4
        run(pc, code, reg, mem, out)

      {:lw, rt, rs, imm} ->
        s = Register.read(reg, rs)
        value = Program.read_value(mem, s + imm)
        reg = Register.write(reg, rt, value)

        pc = pc + 4
        run(pc, code, reg, mem, out)

      {:sw, rt, rs, imm} ->
        t = Register.read(reg, rt)
        s = Register.read(reg, rs)
        mem = Program.write(mem, s + imm, t)

        pc = pc + 4
        run(pc, code, reg, mem, out)

      {:beq, rs, rt, imm} ->
        s = Register.read(reg, rs)
        t = Register.read(reg, rt)

        if s == t do
          address = Program.read_address(mem, imm)
          pc = address + 4
          run(pc, code, reg, mem, out)
        else
          pc = pc + 4
          run(pc, code, reg, mem, out)
        end

      {:label, label} ->
        mem = Program.write(mem, pc, label)
        pc = pc + 4
        run(pc, code, reg, mem, out)
    end
  end
end
