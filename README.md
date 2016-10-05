# Tickets

A simple ticket dispenser to be used in QuickCheck course.

The ticket dispenser has a simple interface:

   1. Start the ticket server

    ```elixir
    {:ok, agent} = TicketAgent.start
    ```

   2. Take a ticket and store it in variable n

    ```elixir
    n = TicketAgent.take(agent)
    ```

   3. Reset the ticket role such that next taken ticket is 1
   
    ```elixir
    TicketAgent.reset(agent)
    ```

   4. Stop the ticket server

    ```elixir
    TicketAgent.stop(agent)
    ```


