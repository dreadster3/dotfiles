flux reconcile image repository \
  --context $CONTEXT \
  -n $NAMESPACE \
  $NAME \
  | less -K
