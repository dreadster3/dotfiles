flux reconcile source git \
  --context $CONTEXT \
  -n $NAMESPACE \
  $NAME \
  | less -K
