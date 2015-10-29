#!/bin/bash

COMMON_PROJECTS=( che-parent che-depmgt che-core che-plugins dashboard )
HOSTED_ONLY_PROJECTS=( codenvy-depmgt hosted-infrastructure plugins odyssey factory )
ALL_PROJECTS=( ${COMMON_PROJECTS[@]} che ${HOSTED_ONLY_PROJECTS[@]} cloud-ide platform-api-client-java cli cdec onpremises )
IDE_SDK_PROJECTS=( ${COMMON_PROJECTS[@]} che )
IDE_HOSTED_PROJECTS=( ${COMMON_PROJECTS[@]} ${HOSTED_ONLY_PROJECTS[@]} cloud-ide )
IDE_ONPREM_PROJECTS=( ${IDE_HOSTED_PROJECTS[@]} platform-api-client-java cli cdec onpremises )
