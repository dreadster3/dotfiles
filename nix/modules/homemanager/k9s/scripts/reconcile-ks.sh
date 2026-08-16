flux reconcile kustomization \
  --context $CONTEXT \
  -n $NAMESPACE \
  $NAME \
  | less -K
