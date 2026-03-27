---- MODULE separate_vars ----
EXTENDS Naturals
CONSTANTS Users, MaxVal
VARIABLES phase, count, owner

Init ==
    /\ phase = [u \in Users |-> "idle"]
    /\ count = 0
    /\ owner = "none"

Request(u) ==
    /\ phase[u] = "idle"
    /\ owner = "none"
    /\ phase' = [phase EXCEPT ![u] = "requesting"]
    /\ UNCHANGED <<count, owner>>

Grant(u) ==
    /\ phase[u] = "requesting"
    /\ owner = "none"
    /\ phase' = [phase EXCEPT ![u] = "granted"]
    /\ owner' = u
    /\ UNCHANGED <<count>>

Release(u) ==
    /\ phase[u] = "granted"
    /\ owner = u
    /\ count < MaxVal
    /\ phase' = [phase EXCEPT ![u] = "idle"]
    /\ count' = count + 1
    /\ owner' = "none"

Next ==
    \E u \in Users :
        \/ Request(u)
        \/ Grant(u)
        \/ Release(u)
====
