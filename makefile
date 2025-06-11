.PHONY: update-context

update-context:
	aws eks update-kubeconfig --region us-east-1 --name eks-cluster-demo

eks_cluster_id=$(shell cd infra && terraform output eks_cluster_name)
aws_eks_cluster_endpoint=$(shell cd infra && terraform output aws_eks_cluster_endpoint)
eks_oidc_provider_arn=$(shell cd infra && terraform output eks_oidc_provider_arn)
eks_cluster_version=$(shell cd infra && terraform output eks_cluster_version)

create-lb:
	cd infra && \
	terraform apply \
	-var='addon_context={
		"eks_cluster_id": ${eks_cluster_id},
		"aws_eks_cluster_endpoint": "${aws_eks_cluster_endpoint}",
		"eks_oidc_provider_arn": "${aws_eks_cluster_endpoint}"
	}' \
	-var='eks_cluster_version="${aws_eks_cluster_version}"'

	terraform apply \
	-var='addon_context={
		"eks_cluster_id": "eks-cluster-demo",
		"aws_eks_cluster_endpoint": "https://DAE9DE54D74732DBD6A6C1C0AA2AA8F4.gr7.us-east-1.eks.amazonaws.com",
		"eks_oidc_provider_arn": "arn:aws:iam::730335280948:oidc-provider/oidc.eks.us-east-1.amazonaws.com/id/DAE9DE54D74732DBD6A6C1C0AA2AA8F4"
	}' \
	-var='eks_cluster_version="1.31"'

