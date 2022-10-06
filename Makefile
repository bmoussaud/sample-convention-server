IMAGE_NAME=akseutap2registry.azurecr.io/sample-convention-server

build:
	./mvnw spring-boot:build-image -Dspring-boot.build-image.imageName=$(IMAGE_NAME)
	docker push $(IMAGE_NAME)

deploy-convention:
	ytt -f k8s --ignore-unknown-comments --data-value image=$(IMAGE_NAME) | kbld -f- | kapp deploy -a sample-convention -f - -c -y

undeploy-convention:
	kapp delete -a sample-convention -y

deploy-intent:
	kubectl apply -f mysample-podintent.yaml

undeploy-intent:
	kubectl delete -f mysample-podintent.yaml
