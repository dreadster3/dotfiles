flux-operator reconcile instance \
  --kube-context $CONTEXT \
  -n $NAMESPACE \
  $NAME \
  | less -K
