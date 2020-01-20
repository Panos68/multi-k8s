docker build -t panos686/multi-client:latest -t panos686/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t panos686/multi-server:latest -t panos686/multi-server:$SHA  -f ./server/Dockerfile ./server
docker build -t panos686/multi-worker:latest -t panos686/multi-worker:$SHA  -f ./worker/Dockerfile ./worker

docker push panos686/multi-client:latest
docker push panos686/multi-server:latest
docker push panos686/multi-worker:latest

docker push panos686/multi-client:$SHA
docker push panos686/multi-server:$SHA
docker push panos686/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=panos686/multi-server:$SHA
kubectl set image deployments/client-deployment client=panos686/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=panos686/multi-worker:$SHA