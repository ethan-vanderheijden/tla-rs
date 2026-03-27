---- MODULE function_state ----
CONSTANT Proc
VARIABLE ready

Init == ready = [p \in Proc |-> FALSE]

Toggle(p) ==
    /\ ready' = [ready EXCEPT ![p] = ~@]

Next == \E p \in Proc : Toggle(p)
====
