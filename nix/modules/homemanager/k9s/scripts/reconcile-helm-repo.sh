flux reconcile source helm \
  --context $CONTEXT \
  -n $NAMESPACE \
  $NAME \
  | less -K
