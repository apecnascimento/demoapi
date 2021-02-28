create_config:
	aws s3api create-bucket --bucket terraform-state-demoapi

delete_config:
	aws s3 rb s3://terraform-state-demoapi --force