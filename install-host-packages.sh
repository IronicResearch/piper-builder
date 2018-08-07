#!/bin/bash

# install host packages
cat host-packages |
	while IFS=: read p
	do
		echo $p
		apt list $p
		RESULT=$?
		if [ $RESULT -ne 0 ]; then
			apt install $p
		fi
	done

exit $?
