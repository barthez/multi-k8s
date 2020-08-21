docker build \
  -t bartekbulat/multi-client:latest \
  -t bartekbulat/multi-client:$SHA \
  -f ./client/Dockerfile ./client

docker build \
  -t bartekbulat/multi-server:latest \
  -t bartekbulat/multi-server:$SHA \
  -f ./server/Dockerfile ./server

docker build \
  -t bartekbulat/multi-worker:latest \
  -t bartekbulat/multi-worker:$SHA \
  -f ./worker/Dockerfile ./worker


docker push bartekbulat/multi-client:latest
docker push bartekbulat/multi-client:$SHA

docker push bartekbulat/multi-server:latest
docker push bartekbulat/multi-server:$SHA

docker push bartekbulat/multi-worker:latest
docker push bartekbulat/multi-worker:$SHA


kubectl apply -f k8s

kubectl set image deployments/server-deployment server=bartekbulat/multi-server:$SHA
kubectl set image deployments/client-deployment client=bartekbulat/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=bartekbulat/multi-worker:$SHA
