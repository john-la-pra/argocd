kubectl create namespace argo-events

kubectl apply -f https://raw.githubusercontent.com/argoproj/argo-events/stable/manifests/install.yaml
kubectl get pods -n argo-events

kubectl apply -f argo-event-bus.yaml
kubectl get eventbus -n argo-events
kubectl get pods -n argo-events

kubectl apply -f aws-sso-secret.yaml

kubectl apply -f sqs-events.yaml
kubectl get eventsources -n argo-events
kubectl get pods -n argo-events  # you should see sqs adapter pod

kubectl apply -f sqs-sensor.yaml
kubectl get sensors -n argo-events

# test
aws sqs send-message \
  --queue-url https://sqs.us-west-2.amazonaws.com/.../my-queue \
  --message-body '{"status":"ok","msg":"test"}'

kubectl get pods -n default -w
# hello-from-sqs-xxxxx   Completed
