reconcile=$(
  kubectl --context $CONTEXT get fluxinstance \
    -n $NAMESPACE \
    $NAME \
    -o=custom-columns='TYPE:.metadata.annotations.fluxcd\.controlplane\.io/reconcile' \
    | tail -1
)
verb=$([ $reconcile = "disabled" ] && echo "resume" || echo "suspend")

flux-operator $verb instance \
  --kube-context $CONTEXT \
  -n $NAMESPACE \
  $NAME \
  | less -K
