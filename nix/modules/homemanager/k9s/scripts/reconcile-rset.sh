flux-operator reconcile rset \
  --kube-context $CONTEXT \
  -n $NAMESPACE \
  $NAME \
  | less -K
