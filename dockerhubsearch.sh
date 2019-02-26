set -e 

i=0
user='gschaetz'
numberofdockerfiles=10
images=''

count=$(curl https://registry.hub.docker.com/v2/repositories/gschaetz/?page=1 2>/dev/null |jq '."count"') > /dev/null 2>&1
count=$(($count / 10 ))
while [ $i -le $count ]
do 
   echo $i
   i=$((i+1))
   IFS=$'\n'
   temp=( $(curl https://registry.hub.docker.com/v2/repositories/$user/?page=$i  2>/dev/null|jq '.results[] | .last_updated+","+.name' | sed 's/"//g') ) > /dev/null 2>&1
   unset IFS
   if [[ -n $images ]]; then
      images=("${images[@]}" "${temp[@]}")
   else    
      images=$temp
   fi
   curl https://registry.hub.docker.com/v2/repositories/gschaetz/?page=$i 2>/dev/null |jq '."results"[] | .count' > /dev/null 2>&1
done

IFS=$'\n' 
sortimages=($(sort <<< "${images[*]}") )
dockerfiles=($(find -L . -iname '*dockerfile' | sed 's|./||' | sort))
unset IFS

n=0
for i in ${sortimages[@]}
do
  image=$(echo $i | cut -d',' -f2)
  for x in ${dockerfiles[@]}
  do
    docker=$(echo $x | cut -d'/' -f1)
    if [[ $image == $docker ]]; then
      dockerfilesout=("${dockerfilesout[@]}" "${x[@]}")
    fi  
  done
  n=$[$n+1]
  if [[ n -ge $numberofdockerfiles ]]; then
    break
  fi
done
echo ${dockerfilesout[@]}