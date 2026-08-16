flux reconcile source oci \
  --context $CONTEXT \
  -n $NAMESPACE \
  $NAME \
  | less -K
