docker build -t rakesh8sb/multi-client-k8s:latest -t rakesh8sb/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t rakesh8sb/multi-server-k8s:latest -t rakesh8sb/multi-server-k8s:$SHA -f ./server/Dockerfile ./server
docker build -t rakesh8sb/multi-worker-k8s:latest -t rakesh8sb/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push rakesh8sb/multi-client-k8s:latest
docker push rakesh8sb/multi-server-k8s:latest
docker push rakesh8sb/multi-worker-k8s:latest

docker push rakesh8sb/multi-client-k8s:$SHA
docker push rakesh8sb/multi-server-k8s:$SHA
docker push rakesh8sb/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=rakesh8sb/multi-server-k8s:$SHA
kubectl set image deployments/client-deployment client=rakesh8sb/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=rakesh8sb/multi-worker-k8s:$SHA