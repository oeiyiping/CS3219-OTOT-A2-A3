cd ./manifests/k8s
kind create cluster --name kind-1 --config cluster-config.yaml
kubectl cluster-info
docker ps

kubectl apply -f ./backend-deploy-zone-aware.yaml
timeout /t 180 /nobreak
kubectl get deployment/backend

kubectl apply -f ./backend-service.yaml
kubectl get svc

kubectl apply -f ./backend-ingress.yaml
kubectl get ingress

kubectl port-forward service/backend 8080:8080