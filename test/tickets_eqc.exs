defmodule TicketsEqc do
	use ExUnit.Case, async: false
	use EQC.ExUnit
	use EQC.StateM

	alias TicketAgent, as: SUT

	def initial_state() do 0 end
	
## reset command
	def reset_args(_state), do: [var: :pid]
    
	def reset(pid), do: SUT.reset(pid)

	def reset_next(_state, _var, [_pid]), do: 0
	
	def reset_post(_state, [_pid], result), do:	satisfy result == :ok

  def reset_features(state, [_], result) do
    [{:reset_at, state}]
  end

## take command
	def take_args(_state), do: [var: :pid] 

	def take(pid), do: SUT.take(pid)

	def take_next(state, _var, [_pid]), do: state+1 
	
	def take_post(state, [_pid], result), do: satisfy result == state+1

  def take_features(state, [_], _) do
    if state == 10 do
      [:have_taken_10_tickets]
    else
      []
    end
  end

	weight state,
	   take: 10,
     reset: state

	property "random_ticket_sequence" do
		forall cmds <- commands(__MODULE__) do
			{:ok, agent} = SUT.start()
			run_result =
				run_commands(__MODULE__, cmds, [pid: agent])
			SUT.stop(agent)
      fs = :eqc_statem.call_features(run_result[:history])
			pretty_commands(__MODULE__, cmds, run_result,
        aggregate names: command_names(cmds), features: fs do
					 run_result[:result] == :ok
         end)
		end
	end
  
end

