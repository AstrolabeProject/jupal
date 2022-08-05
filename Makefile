ALDATA=${PWD}/data
ALWORK=${PWD}/work
ENVLOC=/etc/trhenv
IMG=astrolabe/jupal
JOPTS='_JAVA_OPTIONS=-Xms512m -Xmx8192m -Djava.security.egd=file:///dev/urandom'
NAME=jupal
PORT=9999

.PHONY: help docker exec stop

help:
	@echo 'Make what? help, run, stop'
	@echo '  where: help   - show this help message'
	@echo '         run    - start the customized standalone JupyterLab server'
	@echo '         stop   - stop the customized standalone JupyterLab server'

docker:
	docker build -t ${IMG} .

exec:
	docker cp .bash_env ${NAME}:${ENVLOC}
	docker exec -it ${NAME} bash

run: workdirs
	docker run -it --rm --name ${NAME} -e ${JOPTS} -p${PORT}:8888 -v ${ALWORK}:/home/jovyan/work -v ${ALDATA}:/home/jovyan/data ${IMG}

workdirs:
	if [ ! -d "data" ]; then \
	    mkdir data; \
	fi
	if [ ! -d "work" ]; then \
	    mkdir work; \
	fi

stop:
	docker stop ${NAME}
