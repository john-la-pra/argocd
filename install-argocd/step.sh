kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

kubectl -n argocd port-forward svc/argocd-server 8080:443

kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
zWjLo72PcK1wxIaD

ssh -i <pem path> -L 8080:localhost:8080 <k8s-machine-username>@<k8s-machine-ip>

https://localhost:8080
username: admin
password: zWjLo72PcK1wxIaD

ssh-keygen -t ed25519 -C "kuaijicpa@gmail.com"
/home/epic/.ssh/argocd_ssh_key
# ~/.ssh/argocd_ssh_key        ← private key (keep secret!)
# ~/.ssh/argocd_ssh_key.pub    ← public key (this goes to GitHub)


# use private key in argocd

kubectl -n argocd get pods
kubectl -n argocd exec -it argocd-repo-server-558c787f86-gjqnk -- /bin/sh
ssh -T git@github.com

GIT_SSH_COMMAND="ssh -i ~/.ssh/argocd_ssh_key -o StrictHostKeyChecking=no" git clone git@github.com:john-la-pra/argocd.git /tmp/test


# let argocd get host ssh
ssh-keyscan github.com > ~/known_hosts_github
ls -l ~/known_hosts_github
cat ~/known_hosts_github
kubectl -n argocd create configmap argocd-ssh-known-hosts-cm \
  --from-file=ssh_known_hosts=/home/epic/known_hosts_github \
  -o yaml --dry-run=client | kubectl apply -f -
kubectl -n argocd rollout restart deployment argocd-repo-server

# test network
kubectl run -i --tty busybox --image=busybox --restart=Never -- sh
ping 8.8.8.8
ping google.com

git ls-remote https://john-la-pra:token@github.com/john-la-pra/argocd.git

$ git ls-remote https://john-la-pra:<token>@github.com/john-la-pra/argocd.git
command terminated with exit code 137

# temp pod test network
kubectl run -i --tty test-network --image=ubuntu --restart=Never -- bash
apt update
apt install -y iputils-ping dnsutils curl git
ping github.com
nslookup github.com
git ls-remote git@github.com:john-la-pra/argocd.git
git ls-remote https://github.com/john-la-pra/argocd.git

kubectl -n argocd exec -it argocd-repo-server-558c787f86-gjqnk -- /bin/sh
Defaulted container "argocd-repo-server" out of: argocd-repo-server, copyutil (init)
$ git ls-remote https://john-la-pra:<token>@github.com/john-la-pra/argocd.git
c6dad4d126de4a38cca35b19dc68a1d8d29f10a8        HEAD
c6dad4d126de4a38cca35b19dc68a1d8d29f10a8        refs/heads/main

# then argo app
k apply -f john-project.yaml -n argocd
kubectl apply -f john-app.yaml -n argocd

# sync up
kubectl -n argocd argo app sync john-app
