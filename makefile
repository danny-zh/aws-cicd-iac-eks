.PHONY: helm-install helm-upgrade helm-uninstall

app_name="app"
chart_name="appchart"
secret_file="secret_data.yml"
cluster-name="dherrera-eks-cluster-egqic"


app-install:
	helm install ${app_name} ${chart_name} -f ${secret_file} 

app-upgrade:
	helm upgrade --install ${app_name} ${chart_name} -f ${secret_file} 

app-lint:
	helm lint ${chart_name} -f ${secret_file} 

app-uninstall:
	@echo "uninstalling helm application: ${app_name}"
	helm uninstall ${app_name}

eks-update:
	aws eks update-kubeconfig --name ${cluster-name} --region us-east-1


