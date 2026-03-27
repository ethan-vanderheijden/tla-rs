---- MODULE bool_per_process ----
VARIABLES p1, p2, p3

Init ==
    /\ p1 = FALSE
    /\ p2 = FALSE
    /\ p3 = FALSE

Toggle1 ==
    /\ p1' = ~p1
    /\ UNCHANGED <<p2, p3>>

Toggle2 ==
    /\ p2' = ~p2
    /\ UNCHANGED <<p1, p3>>

Toggle3 ==
    /\ p3' = ~p3
    /\ UNCHANGED <<p1, p2>>

Next ==
    \/ Toggle1
    \/ Toggle2
    \/ Toggle3
====
