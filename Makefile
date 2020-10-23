include .env
mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
current_dir := $(notdir $(patsubst %/,%,$(dir $(mkfile_path))))

VERSION ?= dev

#
import-image:
	docker import cEOS-lab-${CEOS_VERSION}.tar.tar ${REGISTRY_HOST}/ceos:${CEOS_VERSION}

docker-delete-unused-images:
	$(eval docker-unused-image-id-list := $(shell docker images | grep '<none>' | awk '{print $$3}'))
	@echo ${docker-unused-image-id-list}	
	docker rmi -f ${docker-unused-image-id-list}

ceos-stack-up:
	docker-compose up -d 
# 	make tail-log-iperf 

ceos1Cli-up:
	docker exec -it nanog80_ceos-switch-net1_1 Cli

ceos2Cli-up:
	docker exec -it nanog80_ceos-switch-net3_1 Cli

ceos-net1-bash:
	docker exec -it nanog80_ceos-switch-net1_1 bash

ceos-net3-bash:
	docker exec -it nanog80_ceos-switch-net3_1 bash

iperf3-net1-up:
	docker exec -it nanog80_iperf3-net1_1 bash	

iperf3-net3-up:
	docker exec -it nanog80_iperf3-net3_1 bash	

tail-log-iperf:
	docker-compose logs -f iperf3-net1 iperf3-net3

ntp-update:
	sudo ntpdate ntp.ubuntu.com




	