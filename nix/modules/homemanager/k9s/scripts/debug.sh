kubectl debug -it \
  --context $CONTEXT \
  -n=$NAMESPACE \
  $POD \
  --target=$NAME \
  --image=$INPUT_IMAGE \
  --profile=$INPUT_PROFILE \
  $([ "$INPUT_SHARE_PROCESSES" = "true" ] && echo "--share-processes") \
  -- sh
