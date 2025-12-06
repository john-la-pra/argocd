kubectl apply -f argo-ui-sa.yaml

ssh -i <pem path> -L 2746:localhost:2746 <k8s-machine-username>@<k8s-machine-ip>
kubectl port-forward -n argo svc/argo-server 2746:2746
https://localhost:2746
