.PHONY: helm-install helm-upgrade helm-uninstall

app_name="app"
chart_name="appchart"
secret_file="secret_data.yml"

helm-install:
	helm install ${app_name} ${chart_name} -f ${secret_file} 

helm-upgrade:
	helm upgrade ${app_name} ${chart_name} -f ${secret_file} 

helm-uninstall:
	@echo "uninstalling helm application: ${app_name}"
	helm uninstall ${app_name}

eks-update:
	aws eks update-kubeconfig --name scrumptious-indie-hideout --region us-east-1