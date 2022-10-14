cd ./manifests/k8s
kind create cluster --name kind-1 --config cluster-config.yaml
kubectl apply -f ./backend-deploy.yaml
kubectl apply -f ./backend-service.yaml
kubectl apply -f ./backend-ingress.yaml