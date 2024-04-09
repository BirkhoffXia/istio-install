
cd /usr/local/
curl -L https://istio.io/downloadIstio | ISTIO_VERSION=1.17.1 TARGET_ARCH=x86_64 sh -
ln -sv istio-1.17.1 /usr/local/istio
ln -sv /usr/local/istio/bin/istioctl /usr/local/bin/

[node1]
crictl pull docker.io/istio/proxyv2:1.17.1
crictl pull docker.io/istio/pilot:1.17.1
[node2]
crictl pull docker.io/istio/proxyv2:1.17.1
crictl pull docker.io/istio/pilot:1.17.1

kubectl label namespace default istio-injection=enabled
kubectl get ns --show-labels
istioctl install --set profile=demo -y
kubectl  get pods -n istio-system
kubectl logs -f istio-ingressgateway-7b9c8f97d9-gldgm  -n istio-system
istioctl version
kubectl get svc -n istio-system : 为了配置ExternalIP 如果安装过MetalLB 自动会分配

##【k8s：1.28.2 Istio：1.17.1】-addon
grafana.yaml:          image: "grafana/grafana:9.0.1"
jaeger.yaml:          image: "docker.io/jaegertracing/all-in-one:1.35"
kiali.yaml:      - image: "quay.io/kiali/kiali:v1.63"
prometheus.yaml:          image: "jimmidyson/configmap-reload:v0.5.0"
prometheus.yaml:          image: "prom/prometheus:v2.34.0"

crictl pull grafana/grafana:9.0.1 &&
crictl pull docker.io/jaegertracing/all-in-one:1.35 &&
crictl pull quay.io/kiali/kiali:v1.63 &&
crictl pull jimmidyson/configmap-reload:v0.5.0 &&
crictl pull prom/prometheus:v2.34.0
kubectl apply -f  /usr/local/istio/samples/addons/ 


kubectl api-resources --api-group=networking.istio.io
istioctl proxy-status

git clone https://github.com/iKubernetes/istio-in-practise.git
开放kiali istio-gateway

#部署bookinfo
kubectl  apply -f /usr/local/istio/samples/bookinfo/platform/kube/bookinfo.yaml
kubectl exec -it "$(kubectl get pod -l app=ratings -o jsonpath='{.items[0].metadata.name}')" -c ratings -- curl productpage:9080/productpage | grep -o "<title>.*</title>"
kubectl edit svc productpage : 修改为NodePort
http://K8S-MASTER IP:NodePort Port/productpage
