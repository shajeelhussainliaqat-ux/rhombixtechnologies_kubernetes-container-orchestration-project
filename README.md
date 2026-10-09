# Kubernetes Container Orchestration Project

A beginner-friendly Kubernetes project using **Docker Desktop Kubernetes** and NGINX. It demonstrates Deployments, Pods, Services, scaling, self-healing, rolling updates, and rollbacks.

## Prerequisites
- Docker Desktop installed and running, with Kubernetes enabled
- `kubectl` configured for your Docker Desktop cluster
- Git and a GitHub account

Check the cluster:
```bash
kubectl config current-context
kubectl get nodes
```
Make sure the node is `Ready`.

## Project structure
```text
kubernetes-container-orchestration-project/
├── deployment.yaml
├── service.yaml
├── command.sh
└── README.md
```

## 1. Deploy the application
Run from the project directory:
```bash
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
kubectl get deployments
kubectl get pods
kubectl get services
```

## 2. Open the application
Port-forwarding is a reliable option for Docker Desktop:
```bash
kubectl port-forward service/kubernetes-demo 8080:80
```
Keep that terminal open and visit http://localhost:8080. Press `Ctrl+C` to stop port-forwarding.

## 3. Scale up and down
```bash
kubectl scale deployment/kubernetes-demo --replicas=3
kubectl get pods

kubectl scale deployment/kubernetes-demo --replicas=1
kubectl get pods

kubectl scale deployment/kubernetes-demo --replicas=2
kubectl get pods
```

## 4. Test self-healing
List Pods and copy one actual Pod name:
```bash
kubectl get pods
kubectl delete pod <POD_NAME>
kubectl get pods --watch
```
Replace `<POD_NAME>` with a real Pod name. Press `Ctrl+C` to stop watching. Kubernetes should create a replacement to maintain the desired replica count.

## 5. Rolling update and rollback
```bash
kubectl set image deployment/kubernetes-demo kubernetes-demo=nginx:1.27
kubectl rollout status deployment/kubernetes-demo
kubectl rollout history deployment/kubernetes-demo

kubectl rollout undo deployment/kubernetes-demo
kubectl rollout status deployment/kubernetes-demo
```

## Troubleshooting
```bash
kubectl config current-context
kubectl get nodes
kubectl get deployments -A
kubectl get pods -A
kubectl describe deployment kubernetes-demo
kubectl describe service kubernetes-demo
kubectl get events --sort-by=.metadata.creationTimestamp
```
If `kubectl get deployments` reports no resources, verify the current context and namespace, then apply the manifests from this project directory.

## Cleanup
```bash
kubectl delete -f service.yaml
kubectl delete -f deployment.yaml
```

## Notes
- The project uses the public NGINX image; no Docker image build is required.
- The Service defines NodePort `30080`. If `http://localhost:30080` does not work in your Docker Desktop setup, use port-forwarding as shown above.

## Author
Created as a learning project for practicing Kubernetes container orchestration.
