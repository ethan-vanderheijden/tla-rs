---- MODULE flat_variables ----
EXTENDS Sequences
CONSTANT NodeIds
VARIABLES nodeStatus, nodeQueue

Init ==
    /\ nodeStatus = [n \in NodeIds |-> "up"]
    /\ nodeQueue = [n \in NodeIds |-> <<>>]

GoDown(n) ==
    /\ nodeStatus[n] = "up"
    /\ nodeStatus' = [nodeStatus EXCEPT ![n] = "down"]
    /\ UNCHANGED <<nodeQueue>>

GoUp(n) ==
    /\ nodeStatus[n] = "down"
    /\ nodeQueue[n] = <<>>
    /\ nodeStatus' = [nodeStatus EXCEPT ![n] = "up"]
    /\ UNCHANGED <<nodeQueue>>

Enqueue(n) ==
    /\ nodeStatus[n] = "up"
    /\ Len(nodeQueue[n]) < 1
    /\ nodeQueue' = [nodeQueue EXCEPT ![n] = Append(@, "msg")]
    /\ UNCHANGED <<nodeStatus>>

Dequeue(n) ==
    /\ Len(nodeQueue[n]) > 0
    /\ nodeQueue' = [nodeQueue EXCEPT ![n] = Tail(@)]
    /\ UNCHANGED <<nodeStatus>>

Next ==
    \E n \in NodeIds :
        \/ GoDown(n)
        \/ GoUp(n)
        \/ Enqueue(n)
        \/ Dequeue(n)
====
