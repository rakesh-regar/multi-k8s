docker build -t rakesh8sb/multi-client:latest -t rakesh8sb/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t rakesh8sb/multi-server:latest -t rakesh8sb/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t rakesh8sb/multi-worker:latest -t rakesh8sb/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push rakesh8sb/multi-client:latest
docker push rakesh8sb/multi-server:latest
docker push rakesh8sb/multi-worker:latest

docker push rakesh8sb/multi-client:$SHA
docker push rakesh8sb/multi-server:$SHA
docker push rakesh8sb/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=rakesh8sb/multi-server:$SHA
kubectl set image deployments/client-deployment client=rakesh8sb/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=rakesh8sb/multi-worker:$SHA