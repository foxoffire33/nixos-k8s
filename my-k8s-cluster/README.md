helm install ingress-nginx ingress-nginx/ingress-nginx 



--namespace ingress-nginx --create-namespace





sudo ip link add link wlp194s0 name macvtap0 type macvtap mode bridge
sudo ip link set macvtap0 up