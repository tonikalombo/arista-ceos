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
	docker-compose up -d --scale ceos-switch=2 
# 	docker-compose up -d --scale ceos-switch=2 --scale iperf3=1
# 	make tail-log-iperf 

ceos1Cli-up:
	docker exec -it nanog80_ceos-switch_1 Cli

ceos2Cli-up:
	docker exec -it nanog80_ceos-switch_2 Cli

tail-log-iperf:
	docker-compose logs -f iperf3

ntp-update:
	sudo ntpdate ntp.ubuntu.com




	