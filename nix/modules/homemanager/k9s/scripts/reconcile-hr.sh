flux reconcile helmrelease \
  --context $CONTEXT \
  -n $NAMESPACE \
  $NAME \
  | less -K
