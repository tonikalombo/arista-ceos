include .env
mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
current_dir := $(notdir $(patsubst %/,%,$(dir $(mkfile_path))))

VERSION ?= dev

#
import-image:
	docker import cEOS-lab-${CEOS_VERSION}.tar.tar ${REGISTRY_HOST}/ceos:${CEOS_VERSION}

	
ceos-stack-up:
	docker-compose up -d --scale ceos-switch=2 --scale iperf3=1

ceos1Cli-up:
	docker exec -it nanog80_ceos-switch_1 Cli

ceos2Cli-up:
	docker exec -it nanog80_ceos-switch_2 Cli




	