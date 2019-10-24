#!/bin/bash
set -e
set -o pipefail
set -x

SCRIPT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/$(basename "${BASH_SOURCE[0]}")"
REPO_URL="gschaetz"
JOBS=${JOBS:-2}
BUILDNUM=${BUILDNUM:-5}

ERRORS="$(pwd)/errors"

build_and_push(){
	base=$1
	suite=$2
	build_dir=$3

	echo "Building ${REPO_URL}/${base}:${suite} for context ${build_dir}"
	docker build --rm --force-rm -t ${REPO_URL}/${base}:${suite} ${build_dir} || return 1
	#img build -t ${REPO_URL}/${base}:${suite} ${build_dir} || true

	# on successful build, push the image
	echo "                       ---                                   "
	echo "Successfully built ${base}:${suite} with context ${build_dir}"
	echo "                       ---                                   "

	echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
    
	# try push a few times because notary server sometimes returns 401 for
	# absolutely no reason
	n=0
	until [ $n -ge 5 ]; do
		docker push --disable-content-trust=true ${REPO_URL}/${base}:${suite} && break
		echo "Try #$n failed... sleeping for 15 seconds"
		n=$[$n+1]
		sleep 15
	done

	# also push the tag latest for "stable" (chrome), "tools" (wireguard) or "3.5" tags for zookeeper
	if [[ "$suite" == "stable" ]] || [[ "$suite" == "3.5" ]] || [[ "$suite" == "tools" ]]; then
		docker tag ${REPO_URL}/${base}:${suite} ${REPO_URL}/${base}:latest
		docker push --disable-content-trust=false ${REPO_URL}/${base}:latest
	fi
}

dofile() {
	f=$1
	image=${f%Dockerfile}
	base=${image%%\/*}
	build_dir=$(dirname $f)
	suite=${build_dir##*\/}

	if [[ -z "$suite" ]] || [[ "$suite" == "$base" ]]; then
		suite=latest
	fi

	{
		$SCRIPT build_and_push "${base}" "${suite}" "${build_dir}"
	} || {
	# add to errors
	echo "${base}:${suite}" >> $ERRORS
}
echo
echo
}

main(){
	i=1
	images=''
	IFS=$'\n'
	tempimages=($(find ./ -maxdepth 1 -type d \( ! -name .git \) -not -path "./" | sed 's|./||' ) )
	unset IFS
	for i in ${tempimages[@]}
	do 
		IFS=$'\n'
		temp=( $(curl https://registry.hub.docker.com/v2/repositories/gschaetz/$i  2>/dev/null|jq '.last_updated+","+.name' | sed 's/"//g') ) > /dev/null 2>&1
		curl -vvv https://registry.hub.docker.com/v2/repositories/gschaetz/$i  2>/dev/null|jq '.last_updated+","+.name' | sed 's/"//g' 		
		echo $temp
		unset IFS
		if [[ $temp == '","' ]]; then
			temp="0000,$i"
		fi 
		if [[ -n $images ]]; then
			images=("${images[@]}" "${temp[@]}")
		else    
			echo "gary"$temp
			images=$temp
		fi  
	done
	echo ${images[@]}

	IFS=$'\n' 
	sortimages=($(sort <<< "${images[*]}") )
	dockerfiles=($(find -L . -iname '*dockerfile' | sed 's|./||' | sort))
	unset IFS
	
	echo ${sortimages[@]}
	n=0
	for i in ${sortimages[@]}
	do
		image=$(echo $i | cut -d',' -f2)
		for x in ${dockerfiles[@]}
		do
			docker=$(echo $x | cut -d'/' -f1)
			if [[ $image == $docker ]]; then
			files=("${files[@]}" "${x[@]}")
			n=$[$n+1]
			fi  
		done

		# #n=$[$n+1]
		if [[ n -ge $BUILDNUM ]]; then
			break
		fi
	done
	echo ${files[@]}

	# build all dockerfiles
	# echo "Running in parallel with ${JOBS} jobs."
	# parallel --tag --verbose --ungroup -j"${JOBS}" $SCRIPT dofile "{1}" ::: "${files[@]}"

	# if [[ ! -f $ERRORS ]]; then
	# 	echo "No errors, hooray!"
	# else
	# 	echo "[ERROR] Some images did not build correctly, see below." >&2
	# 	echo "These images failed: $(cat $ERRORS)" >&2
	# 	exit 1
	# fi
}

run(){
	args=$@
	f=$1

	if [[ "$f" == "" ]]; then
		main $args
	else
		$args
	fi
}

run $@
