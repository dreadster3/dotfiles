flux-operator reconcile inputprovider \
  --kube-context $CONTEXT \
  -n $NAMESPACE \
  $NAME \
  | less -K
