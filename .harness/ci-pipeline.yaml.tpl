pipeline:
  name: ${APP_NAME}
  identifier: ${APP_NAME}
  projectIdentifier: ${HARNESS_PROJECT_ID}
  orgIdentifier: woolworthslimited
  # This references the global template
  template:
    templateRef: account.Standard_Microservice_Pipeline
    versionLabel: v1
    templateInputs:
      stages:
        - stage:
            identifier: build_stage
            type: CI
            spec:
              execution:
                steps:
                  - step:
                      identifier: Build_Docker_Image
                      type: Run
                      spec:
                        # Passing the specific tag for this app
                        command: "${DOCKER_REGISTRY}/${APP_NAME}:${APP_VERSION}"
