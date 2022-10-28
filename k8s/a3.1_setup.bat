cd ./manifests/k8s
kind create cluster --name kind-1 --config cluster-config.yaml
kubectl apply -f ./backend-deploy.yaml
kubectl apply -f ./backend-service.yaml
kubectl apply -f ./backend-ingress.yaml

kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
kubectl -nkube-system edit deploy/metrics-server
kubectl -nkube-system rollout restart deploy/metrics-server
timeout /t 120 /nobreak

kubectl get deploy,svc -n kube-system
kubectl apply -f ./backend-hpa.yaml
timeout /t 20 /nobreak
kubectl describe hpa


timeout /t 360 /nobreak
kubectl describe hpa

kubectl port-forward service/backend 8080:8080
