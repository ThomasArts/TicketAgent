defmodule TicketAgent do

	def start() do
		Agent.start_link(fn () -> 1 end)
	end

	def stop(agent) do
		Agent.stop(agent)
	end

	def take(agent) do
    n = Agent.get(agent, fn x -> x end)
    Agent.update(agent, fn x -> x+1 end)
    n
	end
	
	def reset(agent) do
		Agent.update(agent, fn _ -> 1 end)
	end

end
