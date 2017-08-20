# Retrieve the artifacts from previous job/stages, if can't find one, rebuild the artifacts

share_folder=$HOME/share/$TRAVIS_REPO_SLUG/$TRAVIS_BUILD_NUMBER
if [ ! -d $share_folder ]; then
    echo "The storage share is missing, rebuild the wheel locally." 
    . $(cd $(dirname $0); pwd)/build.sh
    share_folder=$(cd $(dirname $0); cd ../../artifacts; pwd)
fi