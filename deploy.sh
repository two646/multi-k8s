docker build -t two646/multi-client:latest -t two646/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t two646/multi-worker:latest -t two646/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker build -t two646-multi-server:latest -t two646/multi-server:$SHA -f ./server/Dockerfile ./server
docker push two646/multi-client:latest
docker push two646/multi-worker:latest
docker push two646/multi-server:latest
docker push two646/multi-client:$SHA
docker push two646/multi-worker:$SHA
docker push two646/multi-server:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=two646/multi-server:$SHA
kubectl set image deployments/client-deployment client=two646/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=two646/multi-worker:$SHA
