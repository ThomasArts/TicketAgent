defmodule TemplateEqc do
	use ExUnit.Case, async: false
	use EQC.ExUnit
	use EQC.StateM

	def initial_state() do
    # A map abstracting the state the SUT can be in
    %{}
  end
	
  ## command
	def COMMAND_args(state) do
    # a list with generators for the arguments on command
    [gen1, gen2, ...]
  end

  def COMMAND_pre(state) do
    # A condition depending on the state
    # If false, then COMMAND is not selected as next command in the test sequence
    true
  end

  def COMMAND_pre(state, [arg1, arg2, ...]) do
    # A condition depending on the state and the generated arguments
    # If false, then COMMAND is not selected as next command in the test sequence
    true
  end
    
	def COMMAND(arg1, arg2, ...) do
    # A wrapper for the actual command
    # Here you call the SUT
    SUT.command(.....)
  end

	def COMMAND_next(state, _var, [arg1, arg2, ...]) do
    # Update the model state
    # Given the present state and a call to COMMAND(arg1, arg2, ...),
    # what should the next odel state be?
  end
	
	def COMMAND_post(state, [arg1, arg2, ...], result) do
    # Given the present state (before the call) a call to COMMAND(arg1, arg2, ...)
    # what condition should hold for the result
	  true
  end

	property "StateM property" do
		forall cmds <- commands(__MODULE__) do
			setup_per_test()
			run_result =
				run_commands(__MODULE__, cmds)
			teardown_per_test()
			pretty_commands(__MODULE__, cmds, run_result,
        aggregate names: command_names(cmds) do
					 run_result[:result] == :ok
         end)
		end
	end
  
end

