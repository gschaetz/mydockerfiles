i=0
USER='gschaetz'
IMAGES=''

while [ $? == 0 ]
do 
   i=$((i+1))
   IFS=
   TEMP=$(curl https://registry.hub.docker.com/v2/repositories/gschaetz/?page=$i  2>/dev/null|jq '.results[] | .last_updated+" "+.name') > /dev/null 2>&1
   if [[ -n $IMAGES ]]; then
      IMAGES=$(echo -e "$IMAGES\n$TEMP")
   else    
      IMAGES=$TEMP
   fi
   curl https://registry.hub.docker.com/v2/repositories/gschaetz/?page=$i 2>/dev/null |jq '."results"[] | .last_updated+" "+.name' > /dev/null 2>&1 
done
IMAGES=$(echo -e $IMAGES | sed 's/"//g')
SORTIMAGES=$(echo -e $IMAGES | sort )
echo -e $SORTIMAGES

# get the dockerfiles
IFS=$'\n'
DOCKERFILES=( $(find -L . -iname '*Dockerfile' | sed 's|./||' | sort) )
unset IFS
echo $DOCKERFILES

