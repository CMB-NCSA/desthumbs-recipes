
# Build container
export IMAGE=desthumbs
export SPTUSER=$USER
#export TAG=`date +"%Y%B%d"`
export DES_CUTTER_VERSION=0.1
export TAG=${DES_CUTTER_VERSION}
docker build -f docker/Dockerfile \
       -t menanteau/$IMAGE:$TAG \
       --build-arg DES_CUTTER_VERSION \
       --build-arg SPTUSER \
       --rm=true .

echo 'Push commands:'
echo "   docker push menanteau/$IMAGE:${TAG}"
