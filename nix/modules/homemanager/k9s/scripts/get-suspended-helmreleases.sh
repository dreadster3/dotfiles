kubectl get \
  --context $CONTEXT \
  --all-namespaces \
  helmreleases.helm.toolkit.fluxcd.io \
  -o json \
  | jq -r '.items[] | select(.spec.suspend==true) | [.metadata.namespace,.metadata.name,.spec.suspend] | @tsv' \
  | less -K
