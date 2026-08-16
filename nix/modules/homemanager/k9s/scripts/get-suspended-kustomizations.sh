kubectl get \
  --context $CONTEXT \
  --all-namespaces \
  kustomizations.kustomize.toolkit.fluxcd.io \
  -o json \
  | jq -r '.items[] | select(.spec.suspend==true) | [.metadata.name,.spec.suspend] | @tsv' \
  | less -K
