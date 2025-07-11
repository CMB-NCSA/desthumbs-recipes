
# Build container
export IMAGE=des_cutter
export SPTUSER=$USER
#export TAG=`date +"%Y%B%d"`
export DES_CUTTER_VERSION=1.0.0
export TAG=${DES_CUTTER_VERSION}

# Check for optional --no-cache argument
NO_CACHE=""
if [[ "$1" == "--no-cache" ]]; then
    NO_CACHE="--no-cache"
    echo "Building without cache..."
fi

docker build -f docker/Dockerfile \
       -t menanteau/$IMAGE:$TAG \
       --build-arg DES_CUTTER_VERSION \
       --build-arg SPTUSER \
       --rm=true \
       $NO_CACHE .

echo 'Push commands:'
echo "   docker push menanteau/$IMAGE:${TAG}"
