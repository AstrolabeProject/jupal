ALDATA=${PWD}/data
ALWORK=${PWD}/work
ENVLOC=/etc/trhenv
IMG=jupal:1H
JOPTS='_JAVA_OPTIONS=-Xms512m -Xmx8192m -Djava.security.egd=file:///dev/urandom'
NAME=jupal
NET=vos_net
PORT=9999
STACK=vos

.PHONY: help docker down exec run runvos stop up

help:
	@echo 'Make what? help, docker, down, exec, run, runvos, stop, up'
	@echo '  where: help   - show this help message'
	@echo '         docker - build the JupyterLab server image'
	@echo '         down   - STOP THE ENTIRE VOS STACK !!'
	@echo '         exec   - exec into the running JupyterLab server (CLI arg: NAME=containerID)'
	@echo '         run    - start a standalone JupyterLab server (for development)'
	@echo '         runvos - start a JupyterLab server on the VOS network'
	@echo '         stop   - stop a standalone JupyterLab server (for development)'
	@echo '         up     - start a JupyterLab server on the (running) VOS stack'

docker:
	docker build -t ${IMG} .

down:
	docker stack rm ${STACK}

exec:
	docker cp .bash_env ${NAME}:${ENVLOC}
	docker exec -it ${NAME} bash

run:
	docker run -it --rm --name ${NAME} -e ${JOPTS} -p${PORT}:8888 -v ${ALWORK}:/home/jovyan/work -v ${ALDATA}:/home/jovyan/data ${IMG}

runvos:
	docker run -it --rm --name ${NAME} --network ${NET} -e ${JOPTS} -p${PORT}:8888 -v ${ALWORK}:/home/jovyan/work -v ${ALDATA}:/home/jovyan/data ${IMG}

stop:
	docker stop ${NAME}

up:
	docker stack deploy -c docker-compose.yml ${STACK}
