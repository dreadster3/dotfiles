suspended=$(
  kubectl --context $CONTEXT get kustomizations \
    -n $NAMESPACE \
    $NAME \
    -o=custom-columns=TYPE:.spec.suspend \
    | tail -1
)
verb=$([ $suspended = "true" ] && echo "resume" || echo "suspend")

flux $verb kustomization \
  --context $CONTEXT \
  -n $NAMESPACE \
  $NAME \
  | less -K
