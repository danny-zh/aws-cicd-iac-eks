.PHONY: helm-install helm-upgrade helm-uninstall

app_name="app2"
chart_name="appchart"
secret_file="secret_data.yml"
cluster-name="YOUR_CLUSTER_NAME"


helm-install:
	helm install ${app_name} ${chart_name} -f ${secret_file} 

helm-upgrade:
	helm upgrade ${app_name} ${chart_name} -f ${secret_file} 

helm-uninstall:
	@echo "uninstalling helm application: ${app_name}"
	helm uninstall ${app_name}

eks-update:
	aws eks update-kubeconfig --name ${cluster-name} --region us-east-1