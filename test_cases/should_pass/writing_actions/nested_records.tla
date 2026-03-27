---- MODULE nested_records ----
EXTENDS Sequences
CONSTANT NodeIds
VARIABLE nodes

Init ==
    nodes = [n \in NodeIds |-> [status |-> "up", queue |-> <<>>]]

GoDown(n) ==
    /\ nodes[n].status = "up"
    /\ nodes' = [nodes EXCEPT ![n] = [@ EXCEPT !.status = "down"]]

GoUp(n) ==
    /\ nodes[n].status = "down"
    /\ nodes[n].queue = <<>>
    /\ nodes' = [nodes EXCEPT ![n] = [@ EXCEPT !.status = "up"]]

Enqueue(n) ==
    /\ nodes[n].status = "up"
    /\ Len(nodes[n].queue) < 1
    /\ nodes' = [nodes EXCEPT ![n] = [@ EXCEPT !.queue = Append(@, "msg")]]

Dequeue(n) ==
    /\ Len(nodes[n].queue) > 0
    /\ nodes' = [nodes EXCEPT ![n] = [@ EXCEPT !.queue = Tail(@)]]

Next ==
    \E n \in NodeIds :
        \/ GoDown(n)
        \/ GoUp(n)
        \/ Enqueue(n)
        \/ Dequeue(n)
====
