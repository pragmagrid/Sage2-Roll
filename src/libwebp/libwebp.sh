export LIBWEBP_HOME=/opt/libwebp
BIN=${LIBWEBP_HOME}/bin

if [ -d ${BIN} ]; then
	if ! echo ${PATH} | /bin/grep -q ${BIN} ; then
        	export PATH=${PATH}:${BIN}
	fi
fi
