suspended=$(
  kubectl --context $CONTEXT get helmreleases \
    -n $NAMESPACE \
    $NAME \
    -o=custom-columns=TYPE:.spec.suspend \
    | tail -1
)
verb=$([ $suspended = "true" ] && echo "resume" || echo "suspend")

flux $verb helmrelease \
  --context $CONTEXT \
  -n $NAMESPACE \
  $NAME \
  | less -K
