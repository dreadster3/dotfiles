flux reconcile image update \
  --context $CONTEXT \
  -n $NAMESPACE \
  $NAME \
  | less -K
