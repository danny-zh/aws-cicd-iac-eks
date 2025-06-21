.PHONY: helm-install helm-upgrade helm-uninstall

app_name="app"
chart_name="appchart"
secret_file="secret_data.yml"
cluster-name=$(shell cd infra && terraform output eks_cluster_name)
region=$(shell cd infra && terraform output eks_cluster_region)

app-install:
	@echo "Installing or upgrading helm application: ${app_name}"
	@helm upgrade --install ${app_name} ${chart_name} -f ${secret_file} 

app-lint:
	@echo "Linting helm chart: ${chart_name} with secret file: ${secret_file}"
	@helm lint ${chart_name} -f ${secret_file} 

app-uninstall:
	@echo "uninstalling helm application: ${app_name}"
	@helm uninstall ${app_name}

eks-update:
	@echo "Updating ~/.kube/config use eks cluster: ${cluster-name} in region: ${region}"
	@aws eks update-kubeconfig --name ${cluster-name} --region ${region} 


