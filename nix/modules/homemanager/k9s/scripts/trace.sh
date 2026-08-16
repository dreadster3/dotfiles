if [ -n "$RESOURCE_GROUP" ]; then
    api_endpoint="/apis/$RESOURCE_GROUP/$RESOURCE_VERSION";
else
    api_endpoint="/api/$RESOURCE_VERSION";
fi;
api_resource=$(kubectl get --raw "${api_endpoint}" | jq -r ".resources[] | select(.name==\"$RESOURCE_NAME\")");
kind=$(echo ${api_resource} | jq -r '.kind');
namespace_arg=$(echo ${api_resource} | jq -r "if .namespaced == true then \"--namespace $NAMESPACE\" else \"\" end");

[ -n "$RESOURCE_GROUP" ] && api_version=$RESOURCE_GROUP/;
api_version=${api_version}$RESOURCE_VERSION;

flux trace --context $CONTEXT --kind ${kind} --api-version ${api_version} ${namespace_arg} $NAME |& less -K
