LABELS=$(
  kubectl get $RESOURCE_NAME $NAME \
    -n $NAMESPACE \
    --context $CONTEXT \
    --show-labels \
    | awk '{print $NF}' \
    | awk '{if(NR>1)print}'
)

krr simple --cluster $CONTEXT --selector $LABELS

echo "Press 'q' to exit"
while : ; do
  read -n 1 k <&1
  if [[ $k = q ]] ; then
    break
  fi
done
