reconcile=$(
  kubectl --context $CONTEXT get resourceset \
    -n $NAMESPACE \
    $NAME \
    -o=custom-columns='TYPE:.metadata.annotations.fluxcd\.controlplane\.io/reconcile' \
    | tail -1
)
verb=$([ $reconcile = "disabled" ] && echo "resume" || echo "suspend")

flux-operator $verb rset \
  --kube-context $CONTEXT \
  -n $NAMESPACE \
  $NAME \
  | less -K
