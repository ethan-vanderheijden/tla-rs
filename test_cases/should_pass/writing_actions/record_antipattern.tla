---- MODULE record_antipattern ----
EXTENDS Naturals
CONSTANTS Users, MaxVal
VARIABLE system

Init ==
    system = [phase |-> [u \in Users |-> "idle"],
              count |-> 0,
              owner |-> "none"]

Request(u) ==
    /\ system.phase[u] = "idle"
    /\ system.owner = "none"
    /\ system' = [system EXCEPT !.phase = [@ EXCEPT ![u] = "requesting"]]

Grant(u) ==
    /\ system.phase[u] = "requesting"
    /\ system.owner = "none"
    /\ system' = [system EXCEPT !.phase = [@ EXCEPT ![u] = "granted"],
                                !.owner = u]

Release(u) ==
    /\ system.phase[u] = "granted"
    /\ system.owner = u
    /\ system.count < MaxVal
    /\ system' = [system EXCEPT !.phase = [@ EXCEPT ![u] = "idle"],
                                !.count = @ + 1,
                                !.owner = "none"]

Next ==
    \E u \in Users :
        \/ Request(u)
        \/ Grant(u)
        \/ Release(u)
====
