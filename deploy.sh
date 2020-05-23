docker build -t jonaskay/multi-client:latest -t jonaskay/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jonaskay/multi-server:latest -t jonaskay/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jonaskay/multi-worker:latest -t jonaskay/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push jonaskay/multi-client:latest
docker push jonaskay/multi-server:latest
docker push jonaskay/multi-worker:latest

docker push jonaskay/multi-client:$SHA
docker push jonaskay/multi-server:$SHA
docker push jonaskay/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=jonaskay/multi-server:$SHA
kubectl set image deployments/client-deployment client=jonaskay/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=jonaskay/multi-worker:$SHA
