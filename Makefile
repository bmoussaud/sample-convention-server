IMAGE_NAME=harbor.mytanzu.xyz/library/sample-convention-server

build:
	./mvnw spring-boot:build-image -Dspring-boot.build-image.imageName=$(IMAGE_NAME)
	docker push $(IMAGE_NAME)

deploy-convention:
	kbld -f k8s/server-for-tap1.1.yaml | kapp deploy -a sample-convention -f - -c -y

undeploy-convention:
	kapp delete -a sample-convention -y

deploy-intent:
	kubectl apply -f mysample-podintent.yaml

undeploy-intent:
	kubectl apply -f mysample-podintent.yaml
