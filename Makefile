ALNB=${PWD}/notebooks
ENVLOC=/etc/trhenv
IMG=jupal:devel
JOPTS='_JAVA_OPTIONS=-Xms512m -Xmx8192m'
NAME=jupal
NET=vos_net
PORT=9999
STACK=loc

.PHONY: help docker down exec run stop up

help:
	@echo 'Make what? help, docker, down, exec, run, stop, up'
	@echo '  where: help   - show this help message'
	@echo '         docker - build the JupyterLab server image'
	@echo '         down   - stop the JupyterLab server on the VOS network'
	@echo '         exec   - exec into the running JupyterLab server (CLI arg: NAME=containerID)'
	@echo '         run    - start a standalone JupyterLab server (for development)'
	@echo '         stop   - stop a standalone JupyterLab server (for development)'
	@echo '         up     - start a JupyterLab server on the VOS network'

docker:
	docker build -t ${IMG} .

down:
	docker stack rm ${STACK}

exec:
	docker cp .bash_env ${NAME}:${ENVLOC}
	docker exec -it ${NAME} bash

run:
	docker run -it --rm --name ${NAME} --network ${NET} -e ${JOPTS} -p${PORT}:8888 -v ${ALNB}:/home/jovyan/notebooks ${IMG}

stop:
	docker stop ${NAME}

up:
	docker stack deploy -c docker-compose.yml ${STACK}

%:
	@:
