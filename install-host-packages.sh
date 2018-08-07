#!/bin/bash

# install host packages
cat host-packages |
	while IFS=: read p
	do
		echo $p
		apt list $p
		RESULT=$?
		if [ $RESULT -eq 0 ]; then
			apt install -y $p
		fi
	done

exit $?
