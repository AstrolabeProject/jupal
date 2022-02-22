ALDATA=${PWD}/data
ALWORK=${PWD}/work
ENVLOC=/etc/trhenv
IMG=astrolabe/jupal
JOPTS='_JAVA_OPTIONS=-Xms512m -Xmx8192m -Djava.security.egd=file:///dev/urandom'
NAME=jupal
NET=vos_net
PORT=9999

.PHONY: help docker exec run stop

help:
	@echo 'Make what? help, docker, exec, run, stop'
	@echo '  where: help   - show this help message'
	@echo '         docker - build a custom JupyterLab server image (for developers)'
	@echo '         exec   - exec into the running JupyterLab server (CLI arg: NAME=containerID)'
	@echo '         run    - start a standalone JupyterLab server'
	@echo '         stop   - stop a standalone JupyterLab server'

docker:
	docker build -t ${IMG} .

exec:
	docker cp .bash_env ${NAME}:${ENVLOC}
	docker exec -it ${NAME} bash

run:
	docker run -it --rm --name ${NAME} --network ${NET} -e ${JOPTS} -p${PORT}:8888 -v ${ALWORK}:/home/jovyan/work -v ${ALDATA}:/home/jovyan/data ${IMG}

stop:
	docker stop ${NAME}
