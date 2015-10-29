#!/bin/bash

#
# CODENVY CONFIDENTIAL
# __________________
#
#  [2012] - [2015] Codenvy, S.A.
#  All Rights Reserved.
#
# NOTICE:  All information contained herein is, and remains
# the property of Codenvy S.A. and its suppliers,
# if any.  The intellectual and technical concepts contained
# herein are proprietary to Codenvy S.A.
# and its suppliers and may be covered by U.S. and Foreign Patents,
# patents in process, and are protected by trade secret or copyright law.
# Dissemination of this information or reproduction of this material
# is strictly forbidden unless prior written permission is obtained
# from Codenvy S.A..
#
# If you want change functionality you can override functions of this library.
# As example call echo "start parsing options" before parsing parameters:
# Run script with such content
#
##############################################################
#    #!/bin/bash
#
#    source buildLibrary.sh
#    saveFunction parseParameters old_parseParameters
#    parseParameters() {
#        echo "start parsing options"
#        old_parseParameters "$@"
#    }
#    run "$@"
##############################################################
# To add custom parameters for script override parseCustomParameters function.
#

# call this function to run build
run() {
    # set exit on first error code from commands
    set -e
    set -o pipefail

    initVariables

    resetLogFile

    setNotificationTime

    startNotificationsHandling

    COMMAND_LINE="$0 ""$@"

    parseParameters "$@"

    printConfiguration

    build

    deploy

    printSummary

    notifyUser "Built successfully ${COMMAND_LINE}" "low" "terminal"

    stopNotificationsHandling
}

getUserHelp() {
    echo "usage: ./cbuild [-r <projectFrom> <projectTo>] [-r-hosted <projectFrom> <projectTo>] [-r-sdk <projectFrom> <projectTo>] [--r] [--r-hosted] [--r-sdk]"
    echo "                [-l <project1> ... <projectN>] [-p <project>:<param>:...:<param>]"
    echo "                [-e <project1> <project2>] [--r] [--r-sdk] [--r-hosted] [-continue-from project] [-continue-after project]"
    echo "                [--notests|--t] [--o] [--fu] [-maven-additional-params|-build-param|-bparam 'additional maven parameters'] [--prl]"
    echo "                [--no-pull|--pu] [--no-fetch] [-b branchToCheckout] [-bs branchToCheckoutIfExist] [-bh branchToCheckoutOrSkipProject] [--lc] [-lc 3] [--skip-git-operations]"
    echo "                [--deployment-b|-deployment-b <branch>] [--deployment-pu|--deployment-no-pull]"
    echo "                [--v|-v --b:--multi] [-upload <param>...<param>] [--che]"
    echo "                [--nb|--no-build|--nobuild] [--dry] [-h|-help|--help] [--q] [--log] [--skip-sources-validation]"
    echo ""
}

getOptionsHelp() {
    echo "Options:"
    echo "         -r"
    echo "             Set the range of projects to build. Separated by space. List of all projects will be used."
    echo "             Example:"
    echo "                      -r ide-old cloud-ide"
    echo ""
    echo "         --r"
    echo "             Build all project in the ALL range."
    echo ""
    echo "         -r-sdk"
    echo "             Set the range of projects to build. List of SDK projects will be used."
    echo "             For more information see -r parameter help"
    echo ""
    echo "         --r-sdk"
    echo "             Build all project in the SDK range."
    echo ""
    echo "         -r-hosted"
    echo "             Set the range of projects to build. List of Hosted IDE projects will be used."
    echo "             For more information see -r parameter help"
    echo ""
    echo "         --r-hosted"
    echo "             Build all project in the HOSTED range."
    echo ""
    echo "         -r-onprem"
    echo "             Set the range of projects to build. List of OnPremises IDE projects will be used."
    echo "             For more information see -r parameter help"
    echo ""
    echo "         --r-onprem"
    echo "             Build all project in the OnPremises range."
    echo ""
    echo "         -l"
    echo "             Set the list of projects to build. Separated by space."
    echo "             Per project parameters can be set with this option, e.g. plojectname:parameter:parameter2"
    echo "             See list of parameters in the help for -p parameter."
    echo "             Example:"
    echo "                      -l ide-old"
    echo "                      -l commons:--co cloud-ide"
    echo "                      -l cloud-ide:--co:--gwt"
    echo ""
    echo "         -p"
    echo "             Set additional configuration for certain project. Parameters are separated by colon."
    echo "             First argument is project name."
    echo "             Options:"
    echo "                      --co, --no-checkout"
    echo "                          Do not checkout to any branch, work with current state of directories."
    echo "                      --pu, --no-pull"
    echo "                          Do not make pull."
    echo "                      --gwt"
    echo "                          (For cloud-ide only) Do not build gwt module to speedup build."
    echo "                          Should be used only when IDE client has no changes."
    echo "                      --aio"
    echo "                          (For cloud-ide only) Build all-in-one tomcat and all upstream modules only. Allow speedup build."
    echo "                      --clean-local-repo"
    echo "                          Remove project's artifacts from local repository."
    echo "                      --no-build, --nb, --nobuild"
    echo "                          Do not build project with maven. Checkout, pull and so om will be performed."
    echo "                          To omit all actions with project use exclude option."
    echo "                      --docker"
    echo "                          Build project in docker instead of native build."
    echo "                          Only odyssey and user-dashboard projects support it for now."
    echo "                      --notests, --t"
    echo "                          Skip tests for project."
    echo "             Example:"
    echo "                      -p ide:--co"
    echo "                      -p ide:--co -p cloud-ide:--co:--gwt"
    echo "                      -p ide:--co:--clean-local-repo -p cloud-ide:--co:--aio:--gwt"
    echo ""
    echo "         -e"
    echo "             Set the list of projects to exclude from build. Separated by space."
    echo ""
    echo "         --notests, --t"
    echo "             Do not run tests."
    echo ""
    echo "         --o"
    echo "             Use maven offline option."
    echo ""
    echo "         --fu"
    echo "             Add -U to maven command on build of first project"
    echo ""
    echo "         --no-pull, --pu"
    echo "             Do not make pull."
    echo ""
    echo "         --no-fetch"
    echo "             Do not make fetch of changes from the remote"
    echo ""
    echo "         -b"
    echo "             Set checkout branch. If branch doesn't exist in project build fails."
    echo "             By default cbuild doesn't checkout to a specific branch."
    echo "             Example: -b CLDIDE-1735"
    echo ""
    echo "         -bs"
    echo "             Set checkout branch. If branch doesn't exist in project cbuild doesn't do checkout."
    echo "             Example: -bs CLDIDE-1735"
    echo "         -bh"
    echo "             Set checkout branch. If branch doesn't exist in project cbuild skips project build."
    echo "             Example: -bh CLDIDE-1735"
    echo ""
    echo "         -bf <branch to checkout> <fallback branch to checkout>"
    echo "             Set checkout branch. If branch doesn't exist in project cbuild make checkout to fall back branch."
    echo "             If fallback branch doesn't exist in repo project will be skipped."
    echo "             Example: -bf IDEX-3030 4.0"
    echo ""
    echo "         -lc"
    echo "             Checkout to latest commit N days ago. N is an argument."
    echo ""
    echo "         --lc"
    echo "             Chechout to latest commit 1 day ago."
    echo ""
    echo "         -v"
    echo "             Call vagrant.sh after succesfull build. Accept vagrant options separated by colon. Do not build option is used by default."
    echo "             If one options only is used colon can be ommitted. More about vagrant optins see in vagrant.sh help."
    echo "             Note that if cloud-ide wasn't set by set projects parameters it will be checkouted to master, pulled and built."
    echo "             Example:"
    echo "                      -v --multi:--d"
    echo "                      -v --d"
    echo ""
    echo "         --v"
    echo "             Call vagrant script without additional parameters. Default no build option is still used."
    echo "             Note that if cloud-ide wasn't set by set projects parameters it will be checkouted to master, pulled and built."
    echo ""
    echo "         --dry"
    echo "             Dry run"
    echo ""
    echo "         -maven-additional-params, -build-param, -bparam"
    echo "             REQUIRE: all maven params should be single quoted as one string"
    echo "             Add custom maven params. Should be quoted with a single quote mark."
    echo "             Example:"
    echo "                      -maven-additional-params '--settings /home/user/maven_settings.xml'"
    echo ""
    echo "         -upload"
    echo "             Call upload script after build."
    echo "             Note that if cloud-ide wasn't set by set projects parameters it will be checkouted to master, pulled and built."
    echo "             Example:"
    echo "                      -upload t2 all"
    echo ""
    echo "         -h, -help, --help"
    echo "             Show user help"
    echo ""
    echo "         --clean-local-repo"
    echo "             Remove project's artifacts from local repository."
    echo ""
    echo "         --prl"
    echo "             Execute maven with parallel option -T 1C. Parallel build in maven is experimental feature, so use it on your own risk."
    echo "             Known bugs: mycila license plugin sometimes brakes build."
    echo ""
    echo "         -continue-from"
    echo "             Continue build of projects from a specified one"
    echo ""
    echo "         -continue-after"
    echo "             Continue build of projects from a project that is next after specified one."
    echo ""
    echo "         --nb, --no-build, --nobuild"
    echo "             Do not build projects, but still execute other operations"
    echo ""
    echo "         --che"
    echo "             Run che"
    echo ""
    echo "         -deployment-b"
    echo "             Checkout to specified branch in deployment project"
    echo ""
    echo "         --deployment-b"
    echo "             Checkout to branch configured by -b or -bs options in deployment project"
    echo ""
    echo "         --deployment-pu, --deployment-no-pull"
    echo "             Do not make pull in deployment project"
    echo ""
    echo "         --q"
    echo "             Add quiet option to maven command"
    echo ""
    echo "         --log"
    echo "             Write logs to temp directory"
    echo ""
    echo "         --skip-sources-validation"
    echo "             Skip sources validation on build. For example sortpom, license, findbugs checks."
    echo "             Suitable to speed up build significantly."
    echo ""
    echo "         --no-clean"
    echo "             Skip clean phase of build."
    echo "             Beta! This option is not tested enough. Build of some projects fails if they are not fully support build without clean phase."
    echo "             Suitable to speed up build."
    echo ""
    echo "         --default-disable"
    echo "             Do not add default parameters set in variable CBUILD_USER_DEFAULT_PARAMS."
    echo "             Usefull if some of the default parameters is undesirable."
    echo ""
    echo "         --skip-git-operations"
    echo "             Do not perform git operations. Git operations are performed at the beginning, so it is usefull for build continuation."
    echo "             Does not impact git operations neither in deployment project nor implicit build of cloud-ide project."
    echo ""
    echo "         --gwt-closure-disable"
    echo "             Disable GWT closure compilation. Useful to speed up build for development."
    echo ""
    echo "Examples:"
    echo "         cbuild -r che-core cloud-ide # build all projects from che-core to cloud-ide"
    echo "         cbuild --r-sdk --notests -bs 4.0 --no-pull # build all projects from SDK scope, skip tests, checkout to 4.0 branch if it exists, skip pull"
    echo "         cbuild -l hosted-infrastructure che-core:--pu plugins --v # build hosted-infrastructure che-core plugins (will be auto-sorted), do not pull in che-core, deploy to dev.box"
    echo "         cbuild -r-hosted che-parent cloud-ide:--gwt -e dashboard # build projects from che-parent to cloud-ide in hosted scope except dashboard, do not build module with IDE client"
}

# Process unknown arguments for library
# return - number of arguments to shift
#
# To add new parameter with new action add processing of that parameter to
# overrided function parseCustomParameters. If argument is unknown function must return 0.
# If argument is known process it and return number of arguments to be shifted.
# Example:
# If you add parameter -do_something argument1 argument 2 overrided function must return 3
parseCustomParameters() {
    echo 0
}

getProjectsHelp() {
    echo "-------------------Hosted projects--------------------"
    echo ${IDE_HOSTED_PROJECTS[@]}
    echo "-------------------OnPremises projects----------------"
    echo ${IDE_ONPREM_PROJECTS[@]}
    echo "--------------------SDK projects----------------------"
    echo ${IDE_SDK_PROJECTS[@]}
    echo "--------------------All projects----------------------"
    echo ${ALL_PROJECTS[@]}
}

isOSX() {
    [[ "$OSTYPE" == "darwin"* ]] && echo true || echo false
}

# Send desktop notifications to the user via os dependent notification flow
# Param 1 - Message
# Param 2 - Specifies the urgency level (low, normal, critical). (Linux only)
# Param 3 - Specifies message icon (Linux only)
notifyUser(){
    if [[ $(isOSX) == true ]]; then
        osascript -e "display notification \"$1\" with title \"Cbuild\"" -e " delay ${CBUILD_NOTIFICATION_OK_TIME_MS}/10000"
    else
        type notify-send >/dev/null 2>&1 && notify-send -t ${CBUILD_NOTIFICATION_OK_TIME_MS} --urgency=$2 -i "$3" "$1"
    fi
}

build() {
    # change directory to folder with projects
    cd "${PATH_TO_CBUILD_PROJECTS_FOLDER}"

    setContinueFromProjectIndex

    if [[ ${PERFORM_GIT_OPERATIONS} == true ]]; then
        # prepare repo for each project in the list
        for (( i=${CONTINUE_FROM_PROJECT_INDEX}; i<${#CURRENT_PROJECTS[@]}; i++ )); do
            PROJECT=${CURRENT_PROJECTS[${i}]}
            prepareProjectRepo
        done
        # continue from affect git operations, build projects from first
        CONTINUE_FROM_PROJECT_INDEX=0
    fi
    GIT_OPERATIONS_FINISHED=true

    # call build for each project in the list
    for (( i=${CONTINUE_FROM_PROJECT_INDEX}; i<${#CURRENT_PROJECTS[@]}; i++ )); do
        PROJECT=${CURRENT_PROJECTS[${i}]}
        if [[ $(getIndexInArray ${PROJECT} ${SKIP_BUILD_PROJECTS[@]}) == -1 ]]; then
            buildProject
        else
            loginfo "Skip project build because disable build commmand was used or reqired branch isn't found in repo"
        fi
    done
    unset PROJECT
}

setContinueFromProjectIndex() {
    # default continue from value
    local continueFromIndex=0

    if [[ ! -z ${CONTINUE_FROM_PROJECT} ]]; then
        local continueFromProjectIndexInAllProjects=$(getIndexInArray ${CONTINUE_FROM_PROJECT} ${ALL_PROJECTS[@]})
    elif [[ ! -z ${CONTINUE_AFTER_PROJECT} ]]; then
        local continueFromProjectIndexInAllProjects=$(( $(getIndexInArray ${CONTINUE_AFTER_PROJECT} ${ALL_PROJECTS[@]}) + 1 ))
    else
        CONTINUE_FROM_PROJECT_INDEX="${continueFromIndex}"
        return
    fi

    # check if continue from project is in current projects set
    continueFromIndex=$(getIndexInArray ${ALL_PROJECTS[${continueFromProjectIndexInAllProjects}]} ${CURRENT_PROJECTS[@]})
    if [[ ${continueFromIndex} == -1 ]]; then
        # continue from project is not in current projects set
        # find first project in current projects set after continue from project
        for (( i=${#CURRENT_PROJECTS[@]}-1; i>0; i-- )); do
            local projectFromCurrentProjects=${CURRENT_PROJECTS[${i}]}
            local currentProjectIndexInAllProjects=$(getIndexInArray ${projectFromCurrentProjects} ${ALL_PROJECTS[@]})
            if [[ ${continueFromProjectIndexInAllProjects} -lt ${currentProjectIndexInAllProjects} ]]; then
                continueFromIndex=${i}
            else
                break
            fi
        done
    fi

    if [[ ${continueFromIndex} -eq -1 ]]; then
        if [[ ! -z ${CONTINUE_FROM_PROJECT} ]]; then
            local message="-continue-from ${CONTINUE_FROM_PROJECT} project is out of current projects set"
        else
            local message="-continue-after ${CONTINUE_AFTER_PROJECT} points to project ${ALL_PROJECTS[${continueFromProjectIndexInAllProjects}]} that is out of current projects set"
        fi
        logerrorAndExit "${message}"
    else
        CONTINUE_FROM_PROJECT_INDEX="${continueFromIndex}"
    fi
}

resetLogFile() {
    mkdir -p /tmp/cbuild
    if [[ -f "${LOG_FILE}" ]]; then
        rm -rf "${LOG_FILE}_bk"
        mv "${LOG_FILE}" "${LOG_FILE}_bk"
    fi
}

setNotificationTime() {
    if [[ -z "${CBUILD_NOTIFICATION_OK_TIME_MS}" ]]; then
        # 100 seconds
        CBUILD_NOTIFICATION_OK_TIME_MS=10000
    fi
    if [[ -z "${CBUILD_NOTIFICATION_FAIL_TIME_MS}" ]]; then
        # 100 seconds
        CBUILD_NOTIFICATION_FAIL_TIME_MS=10000
    fi
}

# Convert timestamp argument in date with format hh:mm:ss
getDateFromTimestamp() {
    local cmdLineOption="--date @"
    if [[ $(isOSX) == true ]]; then
        # on MacOS --date is not an option
        cmdLineOption="-r "
    fi

    echo $(date ${cmdLineOption}${1} +%T)
}

printSummary() {
    local endTime=$(date +%s)
    local timeDiff=$(( ${endTime} - ${START_TIME} ))
    local minutesDiff=$(( ${timeDiff} / 60 ))
    local secondsDiff=$(( ${timeDiff} - ( ${minutesDiff} * 60 ) ))
    logplain '================================================'
    logplain '          Projects building is completed'
    logplain '================================================'
    logplain "          Started   : $(getDateFromTimestamp ${START_TIME})"
    logplain "          Ended     : $(getDateFromTimestamp ${endTime})"
    logplain "          Time spend: ${minutesDiff}m:${secondsDiff}s"
    logplain '================================================'
}

initVariables() {
    START_TIME=$(date +%s)

    # project section
    CURRENT_PROJECTS=()
    EXCLUDED_PROJECTS=()
    PROJECTS_ARE_SET=false

    # build section
    CLEAN_LOCAL_REPO_PROJECTS=()
    SKIP_BUILD_PROJECTS=()
    SKIP_TESTS_PROJECTS=()
    USE_DOCKER_FOR=()
    MAVEN_PARAMS=""
    MAVEN_COMMAND=""
    BUILD_GWT_IN_CLOUD_IDE=true
    BUILD_ALL_IN_ONE_ONLY_IN_CLOUD_IDE=false
    USE_MAVEN_UPDATES_SNAPSHOTS_ON_FIRST_PROJECT=false
    DO_NOT_BUILD=false
    MAKE_CLEAN_BUILD=true
    IS_FIRST_PROJECT=true

    # git section
    NO_CHECKOUT_PROJECTS=()
    DO_NOT_MAKE_PULL_PROJECTS=()
    SKIP_PULL=false
    BRANCH=""
    CHECKOUT_AGO=false
    # can be also 'soft-checkout', 'checkout', 'hard-checkout'
    CHECKOUT_STRATEGY="no-checkout"
    SKIP_FETCH=false
    PERFORM_GIT_OPERATIONS=true
    GIT_OPERATIONS_FINISHED=false

    # deployment section
    RUN_VAGRANT=false
    VAGRANT_PARAMS="--nobuild"
    RUN_UPLOAD=false
    RUN_CHE=false
    UPLOAD_PARAMS="--nobuild"
    # can be also 'checkout', 'checkout-to-projects-branch'
    DEPLOYMENT_CHECKOUT_STRATEGY='no-checkout'
    DEPLOYMENT_MAKE_PULL=true
    DEPLOYMENT_BRANCH=""

    # other section
    DRY_RUN=false
    QUIET=false
    LOG=false
    SUPPRESS_LOGS_ON_FAIL_IN_LOG_MODE=false
    LOG_FILE="/tmp/cbuild/cbuild.log"
    USE_DEFAULT_PARAMS=true
    USER_DEFAULT_PARAMS=()
    if [[ ! -z "${CBUILD_USER_DEFAULT_PARAMS}" ]]; then
        USER_DEFAULT_PARAMS=( $(echo ${CBUILD_USER_DEFAULT_PARAMS}) )
    fi
}

printConfiguration() {
    # here and further in this method use additional indentation to align configuration summary
    logplain         '================================================'
    logplain         '==============Configuration====================='
    logplain         "DRY_RUN:..............................."${DRY_RUN}
    logplain         "QUIET:................................."${QUIET}
    logplain         "LOG...................................."${LOG}
    logplain         "USE_DEFAULT_PARAMS....................."${USE_DEFAULT_PARAMS}
    if [[ ${USE_DEFAULT_PARAMS} == true ]]; then
        logplain     "USER_DEFAULT_PARAMS...................."${USER_DEFAULT_PARAMS[@]}
    fi
    if [[ ${LOG} == true ]]; then
        logplain     "LOG_FILE..............................."${LOG_FILE}
    fi

    if [[ ${PERFORM_GIT_OPERATIONS} == true ]]; then
        logplain     "---------------VCS------------------------------"
        logplain     "SKIP_PULL:............................."${SKIP_PULL}
        logplain     "SKIP_FETCH:............................"${SKIP_FETCH}
        logplain     "CHECKOUT_STRATEGY:....................."${CHECKOUT_STRATEGY}
        if [[ ${SKIP_PULL} == false ]]; then
            logplain "DO_NOT_MAKE_PULL_PROJECTS:............."${DO_NOT_MAKE_PULL_PROJECTS[@]}
        fi
        if [[ ${CHECKOUT_STRATEGY} != "no-checkout" ]]; then
            logplain "BRANCH:................................"${BRANCH}
            logplain "CHECKOUT_AGO:.........................."${CHECKOUT_AGO}
            logplain "NO_CHECKOUT_PROJECTS:.................."${NO_CHECKOUT_PROJECTS[@]}
        fi
        if [[ ${CHECKOUT_STRATEGY} != "fallback-checkout" ]]; then
            logplain "FALLBACK_BRANCH:......................."${FALLBACK_BRANCH}
        fi
        logplain     "DEPLOYMENT_CHECKOUT_STRATEGY..........."${DEPLOYMENT_CHECKOUT_STRATEGY}
        logplain     "DEPLOYMENT_MAKE_PULL..................."${DEPLOYMENT_MAKE_PULL}
        if [[ ${DEPLOYMENT_CHECKOUT_STRATEGY} == "checkout" ]]; then
            logplain "DEPLOYMENT_BRANCH......................"${DEPLOYMENT_BRANCH}
        elif [[ ${DEPLOYMENT_CHECKOUT_STRATEGY} == "checkout-to-projects-branch" ]]; then
            logplain "DEPLOYMENT_BRANCH......................"${BRANCH}
        fi
    fi

    logplain         '------------BUILD-------------------------------'
    logplain         "DO_NOT_BUILD:.........................."${DO_NOT_BUILD}
    if [[ ${DO_NOT_BUILD} == false ]]; then
        logplain     "MAKE_CLEAN_BUILD:......................"${MAKE_CLEAN_BUILD}
        logplain     "MAVEN_PARAMS:.........................."${MAVEN_PARAMS}
        logplain     "USE -U WITH_1ST_PROJECT:..............."${USE_MAVEN_UPDATES_SNAPSHOTS_ON_FIRST_PROJECT}
        logplain     "BUILD_GWT_IN_CLODIDE:.................."${BUILD_GWT_IN_CLOUD_IDE}
        logplain     "CLEAN_LOCAL_REPO_PROJECTS:............."${CLEAN_LOCAL_REPO_PROJECTS[@]}
        logplain     "SKIP_BUILD_PROJECTS:..................."${SKIP_BUILD_PROJECTS[@]}
        logplain     "SKIP_TESTS_PROJECTS:..................."${SKIP_TESTS_PROJECTS[@]}
        logplain     "USE_DOCKER_FOR:........................"${USE_DOCKER_FOR[@]}
    fi

    logplain         "------------DEPLOY------------------------------"
    logplain         "RUN_VAGRANT:..........................."${RUN_VAGRANT}
    if [[ ${RUN_VAGRANT} == true ]]; then
        logplain     "VAGRANT_PARAMS:........................"${VAGRANT_PARAMS}
    fi
    logplain         "RUN_UPLOAD:............................"${RUN_UPLOAD}
    if [[ ${RUN_UPLOAD} == true ]]; then
        logplain     "UPLOAD_PARAMS:........................."${UPLOAD_PARAMS}
    fi
    logplain         "RUN_CHE:..............................."${RUN_CHE}

    logplain         "-----------Projects-----------------------------"
    for i in ${CURRENT_PROJECTS[@]}; do
        logplain     ${i}
    done
    logplain         '================================================'
}

deploy() {
    if [[ ${RUN_VAGRANT} == true || ${RUN_UPLOAD} == true ]]; then
        buildCloudIdeBeforeDeployIfNeeded
    fi

    if [[ ${DEPLOYMENT_CHECKOUT_STRATEGY} != 'no-checkout' ]]; then
        checkoutDeployment
    fi

    if [[ ${RUN_VAGRANT} == true ]]; then
        runVagrant
    fi

    if [[ ${RUN_UPLOAD} == true ]]; then
        runUpload
    fi

    if [[ ${RUN_CHE} == true ]]; then
        runChe
    fi
}

parseParameters() {
    if [[ $# == 0 ]]; then
        logerrorAndExit "Parameters list is empty"
    fi

    if [[ $(getIndexInArray "--default-disable" "$@") == -1 ]]; then
        set -- "${USER_DEFAULT_PARAMS[@]}" "$@"
        loginfo "Actual params:$@"
    fi

    source "${PATH_TO_CBUILD_LIBRARY_FOLDER}/projectsList.sh"

    for (( i=1; i<=$#; i++ )); do
        local option=${!i}
        case ${option} in
            --help | -h | -help)
                getUserHelp && getProjectsHelp && getOptionsHelp; exit 0
                ;;
            --notests | --t)
                MAVEN_PARAMS=${MAVEN_PARAMS}" -Dmaven.test.skip=true"
                ;;
            --o)
                MAVEN_PARAMS=${MAVEN_PARAMS}" -o"
                ;;
            --fu)
                USE_MAVEN_UPDATES_SNAPSHOTS_ON_FIRST_PROJECT=true
                ;;
            --no-pull | --pu)
                SKIP_PULL=true
                ;;
            --no-fetch)
                SKIP_FETCH=true
                ;;
            -lc | --lc)
                CHECKOUT_STRATEGY='checkout'
                if [[ ${option} == "--lc" ]]; then
                    CHECKOUT_AGO=1
                else
                    i=$((i + 1))
                    validateNotEmpty "${!i}" "Argument of ${option} option is missing"
                    CHECKOUT_AGO=${!i}
                fi
                ;;
            -b | -bs | -bh | -bf)
                if [[ ${!i} == "-b" ]]; then
                    CHECKOUT_STRATEGY='checkout'
                elif [[ ${!i} == "-bh" ]]; then
                    CHECKOUT_STRATEGY='hard-checkout'
                elif [[ ${!i} == "-bs" ]]; then
                    CHECKOUT_STRATEGY='soft-checkout'
                else
                    CHECKOUT_STRATEGY='fallback-checkout'
                fi
                i=$((i + 1))
                validateNotEmpty "${!i}" "Branch name argument of ${option} option is missing"
                BRANCH=${!i}
                if [[ ${CHECKOUT_STRATEGY} == "fallback-checkout" ]]; then
                    i=$((i + 1))
                    validateNotEmpty "${!i}" "Fallback branch name argument of ${option} option is missing"
                    FALLBACK_BRANCH=${!i}
                fi
                ;;
            -r | --r | -r-sdk | --r-sdk | -r-hosted | --r-hosted | -r-onprem | --r-onprem )
                case ${!i} in
                    -r | --r)
                        local current_projects=(${ALL_PROJECTS[@]})
                        ;;
                    -r-sdk | --r-sdk)
                        local current_projects=(${IDE_SDK_PROJECTS[@]})
                        ;;
                    -r-hosted | --r-hosted)
                        local current_projects=(${IDE_HOSTED_PROJECTS[@]})
                        ;;
                    -r-onprem | --r-onprem)
                        local current_projects=(${IDE_ONPREM_PROJECTS[@]})
                        ;;
                esac
                if [[ ${!i} == --* ]]; then
                    setProjectsRange "all" ${current_projects[@]}
                else
                    local starts=$((i + 1))
                    validateNotEmpty "${!starts}" "First argument of projects range option ${option} is missing"
                    local ends=$((i + 2))
                    validateNotEmpty "${!ends}" "Second argument of projects range option ${option} is missing"
                    setProjectsRange ${!starts} ${!ends} ${current_projects[@]}
                    i=$((i + 2))
                fi
                ;;
            -l)
                if [[ ${PROJECTS_ARE_SET} == true ]]; then
                    logerrorAndExit "Parameters -r -r-sdk -r-hosted -r-onprem -l --r --r-sdk --r-hosted --r-onprem can't be used together"
                fi
                local nextArg=$((i + 1))
                validateNotEmpty "${!nextArg}" "Parameter -l has no appropriate arguments"
                for (( projectCounter=$((i + 1)); projectCounter<=$#; projectCounter++ ))
                do
                    if [[ ${!projectCounter} != -* ]]; then
                        local PROJECT_WITH_CUSTOM_CONFIGURATION=(${!projectCounter//:/ })
                        local projectName=${PROJECT_WITH_CUSTOM_CONFIGURATION[0]}
                        # check that projects list contains this project
                        [[ $(getIndexInArray ${projectName} ${ALL_PROJECTS[@]}) == -1 ]] && logerrorAndExit "${projectName} is not found"
                        # process project configuration
                        processProjectConf ${!projectCounter}
                        # add project to current projects list
                        PROJECTS_TO_SORT+=(${projectName})

                        i=$((i + 1))
                    else
                        break
                    fi
                done
                # sort projects
                for candidate in ${ALL_PROJECTS[@]}
                do
                    local candIndex=$(getIndexInArray ${candidate} ${PROJECTS_TO_SORT[@]})
                    if [[ ${candIndex} != "-1" ]]; then
                        CURRENT_PROJECTS+=(${candidate})
                    fi
                done

                PROJECTS_ARE_SET=true
                ;;
            -p)
                i=$((i + 1))
                processProjectConf ${!i}
                ;;
            -e)
                local nextArg=$((i + 1))
                validateNotEmpty "${!nextArg}" "Parameter -e has no appropriate arguments"
                for (( excludeProjectCounter=$((i + 1)); excludeProjectCounter<=$#; excludeProjectCounter++ ))
                do
                    if [[ ${!excludeProjectCounter} != -* ]]; then
                        EXCLUDED_PROJECTS+=(${!excludeProjectCounter})
                        i=$((i + 1))
                    else
                        break
                    fi
                done
                ;;
            -v | --v)
                if [[ ${!i} == "-v" ]]; then
                    i=$((i + 1))
                    validateNotEmpty "${!i}" "Option -v has no appropriate arguments"
                    VAGRANT_PARAMS+=" "${!i//:/ }
                fi
                RUN_VAGRANT=true
                ;;
            --che)
                RUN_CHE=true
                ;;
            -upload)
                local firstArgument=$((i + 1))
                validateNotEmpty "${!firstArgument}" "Option -upload has no appropriate arguments"
                local secondArgument=$((i + 2))
                validateNotEmpty "${!secondArgument}" "Second argument of -upload option is missing"
                if [[ ${secondArgument} != -* ]]; then
                    UPLOAD_PARAMS=${!firstArgument}" "${!secondArgument}" "${UPLOAD_PARAMS}
                    i=$((i + 2))
                else
                    UPLOAD_PARAMS=${!firstArgument}" "${UPLOAD_PARAMS}
                    i=$((i + 1))
                fi
                RUN_UPLOAD=true
                ;;
            --dry)
                DRY_RUN=true
                ;;
            -maven-additional-params | -bparam | -build-param)
                i=$((i + 1))
                validateNotEmpty "${!i}" "Option ${option} has no appropriate arguments"
                MAVEN_PARAMS=${MAVEN_PARAMS}" ${!i}"
                ;;
            -continue-from | -continue-after)
                if [[ ! -z ${CONTINUE_FROM_PROJECT} || ! -z ${CONTINUE_AFTER_PROJECT} ]]; then
                    logerrorAndExit "-continue-from and -continue-after options can't be used at the same time"
                fi
                i=$((i + 1))
                validateNotEmpty "${!i}" "Option ${option} has no appropriate arguments"
                local continueIndex=$(getIndexInArray ${!i} ${ALL_PROJECTS[@]})
                if [[ ${continueIndex} == -1 ]]; then
                    logerrorAndExit "Unknown project name ${!i} is used as an argument of ${option} option"
                fi
                if [[ ${option} == "-continue-after" ]]; then
                    if [[ ${continueIndex} -eq $(( ${#ALL_PROJECTS[@]} - 1)) ]]; then
                        logerrorAndExit "-continue-after option point to the last project. No more projects after project ${!i} is found"
                    fi
                    CONTINUE_AFTER_PROJECT=${ALL_PROJECTS[${continueIndex}]}
                else
                    CONTINUE_FROM_PROJECT=${ALL_PROJECTS[${continueIndex}]}
                fi
                ;;
            --clean-local-repo)
                MAVEN_COMMAND="mvn build-helper:remove-project-artifact && "${MAVEN_COMMAND}
                ;;
            --prl)
                MAVEN_PARAMS=${MAVEN_PARAMS}" -T 1C"
                ;;
            --no-build | --nb | --nobuild)
                DO_NOT_BUILD=true
                ;;
            --deployment-b)
                DEPLOYMENT_CHECKOUT_STRATEGY="checkout-to-projects-branch"
                ;;
            -deployment-b)
                DEPLOYMENT_CHECKOUT_STRATEGY="checkout"
                i=$((i + 1))
                validateNotEmpty "${!i}" "Option ${option} has no appropriate arguments"
                DEPLOYMENT_BRANCH=${!i}
                ;;
            --deployment-pu | --deployment-no-pull)
                DEPLOYMENT_MAKE_PULL=false
                ;;
            --q)
                QUIET=true
                # quiet mode authomatically enable logging mode
                LOG=true
                ;;
            --log)
                LOG=true
                ;;
            --skip-sources-validation)
                MAVEN_PARAMS=${MAVEN_PARAMS}" -Dskip-validate-sources"
                ;;
            --no-clean)
                MAKE_CLEAN_BUILD=false
                ;;
            --default-disable)
                # Do nothing, this option is processed at the begining of this function
                # Variable set for printing of configuration only
                USE_DEFAULT_PARAMS=false
                ;;
            --skip-git-operations)
                PERFORM_GIT_OPERATIONS=false
                ;;
            --gwt-closure-disable)
                MAVEN_PARAMS=${MAVEN_PARAMS}" -Dgwt.compiler.enableClosureCompiler=false"
                ;;
            *)
                local shiftTo=$(parseCustomParameters ${@})
                if [[ ${shiftTo} == 0 ]]; then
                    logerrorAndExit "Unknown parameter ${!i}"
                else
                    i=$(expr ${i} + ${shiftTo} - 1)
                fi
                ;;
        esac
    done

    for excludeProject in ${EXCLUDED_PROJECTS[@]}
    do
        local removeIndex=$(getIndexInArray ${excludeProject} ${CURRENT_PROJECTS[@]})
        if [[ ${removeIndex} == -1 ]]; then
            removeIndex=$(getIndexInArray ${excludeProject} ${ALL_PROJECTS[@]})
            if [[ ${removeIndex} == -1 ]]; then
                logerrorAndExit "Unknown project ${excludeProject} is used as an argument of -e option"
            else
                logerror "Project ${excludeProject} used as an argument of -e option is out of current scope"
                continue
            fi
        fi
        CURRENT_PROJECTS=(${CURRENT_PROJECTS[@]:0:${removeIndex}} ${CURRENT_PROJECTS[@]:$((${removeIndex} + 1))})
    done
}

createMavenCommand() {
    local project="${1}"
    local mavenPerProjectParams=""

    if [[ ${IS_FIRST_PROJECT} == true && ${USE_MAVEN_UPDATES_SNAPSHOTS_ON_FIRST_PROJECT} == true ]]; then
        mavenPerProjectParams=${mavenPerProjectParams}' -U'
        IS_FIRST_PROJECT=false
    fi

    local projectConfigurationIndex=$(getIndexInArray ${project} ${SKIP_TESTS_PROJECTS[@]})
    if [[ ${projectConfigurationIndex} != "-1" ]]; then
        mavenPerProjectParams=${mavenPerProjectParams}' -Dmaven.test.skip=true'
    fi

    if [[ "${project}" == cloud-ide* ]]; then
        if [[ ${BUILD_GWT_IN_CLOUD_IDE} == false ]]; then
            mavenPerProjectParams=${mavenPerProjectParams}" -pl \"!cloud-ide-compiling-war-next-ide-codenvy\""
        fi
        if [[ ${BUILD_ALL_IN_ONE_ONLY_IN_CLOUD_IDE} == true ]]; then
            mavenPerProjectParams=${mavenPerProjectParams}" -pl \"cloud-ide-packaging-tomcat-codenvy-allinone\" --also-make"
        fi
    fi

    if [[ ${MAKE_CLEAN_BUILD} == true ]]; then
        local mavenCommand="mvn clean install"
    else
        local mavenCommand="mvn install"
    fi

    mavenCommand+=" "${MAVEN_PARAMS}" "${mavenPerProjectParams}

    projectConfigurationIndex=$(getIndexInArray ${project} ${CLEAN_LOCAL_REPO_PROJECTS[@]})
    if [[ ${projectConfigurationIndex} != "-1" ]]; then
        mavenCommand="mvn build-helper:remove-project-artifact && "${mavenCommand}
    fi

    echo ${mavenCommand} && return 0
}

validateNotEmpty() {
    if [[ -z ${1} ]]; then
        logerror "${2}"
        SUPPRESS_LOGS_ON_FAIL_IN_LOG_MODE=true
        exit 1
    fi
}

prepareProjectRepo() {
    if [[ ! -d ${PROJECT} ]]; then
        if [[ ${DRY_RUN} == true ]]; then
            logerrorAndExit "${PROJECT} directory not found! Skip cloning because of dry run mode"
        fi

        logerror "${PROJECT} directory not found! Try to clone it ..."
        clone ${PROJECT}
    fi

    cdTo "$(pwd)/${PROJECT}"

    local projectConfigurationIndex=$(getIndexInArray ${PROJECT} ${DO_NOT_MAKE_PULL_PROJECTS[@]})
    if [[ ${SKIP_PULL} == true || ${projectConfigurationIndex} != "-1" ]]; then
        local skipPull=true
    else
        local skipPull=false
    fi

    # Fetch changes in the remote to prefent push that will fail
    # also usefull when -b is used and specified branch wasn't fetched in the repo yet.
    # prune remove links to removed upstreams
    if [[ ${SKIP_FETCH} == false && ${CHECKOUT_STRATEGY} != "no-checkout" ]]; then
        cbuildEval "git fetch --prune"
    fi

    local projectConfigurationIndex=$(getIndexInArray ${PROJECT} ${NO_CHECKOUT_PROJECTS[@]})
    if [[ ${CHECKOUT_STRATEGY} != "no-checkout" && ${projectConfigurationIndex} == "-1" ]]; then
        if [[ ${CHECKOUT_STRATEGY} == "hard-checkout" && $(git show-ref --quiet ${BRANCH} && echo "0" || echo "-1") == -1 ]]; then
            loginfo "Project ${PROJECT} build will be skipped because branch ${BRANCH} is missing"
            SKIP_BUILD_PROJECTS+=(${PROJECT})
            # make project processing finalization step
            cd "$(dirname $(pwd))"
            unset PROJECT

            return;
        else
            gitCheckOut
        fi
    else
        loginfo "Do not checkout. Current branch $(git rev-parse --abbrev-ref HEAD)"
    fi

    if [[ ${skipPull} == false ]]; then
        local pullCommand="git pull"
        if [[ ${SKIP_FETCH} == true || ${CHECKOUT_STRATEGY} == "no-checkout" ]]; then
            pullCommand+=" --prune"
        fi
        cbuildEval ${pullCommand}
    fi

    cd "$(dirname $(pwd))"
}

buildProject() {
    cdTo "$(pwd)/${PROJECT}"

    if [[ ${DO_NOT_BUILD} == false ]]; then
        local buildCommand=$(createMavenCommand ${PROJECT})

        # Check if project should be built in the docker
        projectConfigurationIndex=$(getIndexInArray ${PROJECT} ${USE_DOCKER_FOR[@]})
        if [[ ${projectConfigurationIndex} != "-1" ]]; then
            local buildCommand="docker run -i -t -e USRID=$(id -u) -e USRGR=$(id -g) -v $(pwd):/home/user/app -v ${HOME}/.m2:/home/user/.m2 vkuznyetsov/odyssey-java8-docker-build bash -c \"sudo chown user:user -R /home/user/app /home/user/.m2 && ${buildCommand} || BUILD_FAILED=true; sudo chown \\\$USRID:\\\$USRGR -R /home/user/app /home/user/.m2; [[ \\\${BUILD_FAILED} != true ]]\""
        fi

        cbuildEval "${buildCommand}"
    else
        loginfo "Skip project build because disable build commmand was used"
    fi

    cd "$(dirname $(pwd))"
}

runVagrant() {
    cdTo "$(pwd)/cloud-ide"

    loginfo "./vagrant.sh ${VAGRANT_PARAMS}"
    if [[ ${DRY_RUN} == false ]]; then
        ./vagrant.sh ${VAGRANT_PARAMS}
    fi

    cd "$(dirname $(pwd))"
}

runUpload() {
    cdTo "$(pwd)/cloud-ide"

    loginfo "./upload.sh ${UPLOAD_PARAMS}"
    if [[ ${DRY_RUN} == false ]]; then
        ./upload.sh ${UPLOAD_PARAMS}
    fi

    cd "$(dirname $(pwd))"
}

runChe() {
    cdTo "$(pwd)/che"

    loginfo "./che.sh jpda run"
    if [[ ${DRY_RUN} == false ]]; then
        ./che.sh jpda run
    fi

    cd "$(dirname $(pwd))"
}

checkoutDeployment() {
    cdTo "$(pwd)/deployment"

    cbuildEval "git remote update --prune"

    if [[ ${DEPLOYMENT_CHECKOUT_STRATEGY} == "checkout-to-projects-branch" ]]; then
        local branch=${BRANCH}
    else
        local branch=${DEPLOYMENT_BRANCH}
    fi

    cbuildEval "git checkout ${branch}"

    if [[ ${DEPLOYMENT_MAKE_PULL} == true ]]; then
        cbuildEval "git pull"
    fi

    cd "$(dirname $(pwd))"
}

# Build cloud-ide project if it is not in the list of projects to build.
# It is allowed to use it before calling deploy functions only.
# This function does not checkout to master, do pull and do build with base maven parameters.
buildCloudIdeBeforeDeployIfNeeded() {
    local cloudideIndex=$(getIndexInArray cloud-ide ${CURRENT_PROJECTS[@]})
    # if cloud-ide wasn't set explicitly and list of projects is not empty
    # "cbuild --v" - projects list is empty. Can be used to deploy without any build
    if [[ ${cloudideIndex} == "-1" && ${#CURRENT_PROJECTS[@]} -ne 0 ]]; then
        loginfo "cloud-ide is not in the projects set and should be built implicitly to use deployment scripts"
        cdTo "$(pwd)/cloud-ide"
        cbuildEval "git pull -p"

        if [[ ${MAKE_CLEAN_BUILD} == true ]]; then
            local buildCmd="mvn clean install"
        else
            local buildCmd="mvn install"
        fi

        cbuildEval "${buildCmd}"
        cd "$(dirname $(pwd))"
    fi
}

setProjectsRange() {
    if [[ ${PROJECTS_ARE_SET} == true ]]; then
        logerrorAndExit "Parameters -r -r-sdk -r-hosted -r-onprem -l --r --r-sdk --r-hosted --r-onprem can't be used together"
    fi
    local buildFrom=${1}
    shift
    if [[ ${buildFrom} == "all" ]]; then
        local buildFromIndex=0
        local projectsList=( $( echo $@ ) )
        local buildUntilIndex=$(expr ${#projectsList[@]} - 1)
    else
        local buildUntil=${1}
        shift
        local projectsList=( $( echo $@ ) )
        local buildFromIndex=$(getIndexInArray ${buildFrom} ${projectsList[@]})
        [[ ${buildFromIndex} == -1 ]] && logerrorAndExit "Project ${buildFrom} is not found for that projects set"
        local buildUntilIndex=$(getIndexInArray ${buildUntil} ${projectsList[@]})
        [[ ${buildUntilIndex} == -1 ]] && logerrorAndExit "Project ${buildUntil} is not found for that projects set"
    fi

    CURRENT_PROJECTS=( ${projectsList[@]:${buildFromIndex}:$(expr ${buildUntilIndex} - ${buildFromIndex} + 1)} )
    PROJECTS_ARE_SET=true
}

processProjectConf() {
    local projectCustomConfiguration=(${1//:/ })
    local projectName=${projectCustomConfiguration[0]}
    for confEntry in ${projectCustomConfiguration[@]:1}
    do
        case ${confEntry} in
            --co | --no-checkout)
                NO_CHECKOUT_PROJECTS+=(${projectName})
                ;;
            --clean-local-repo)
                CLEAN_LOCAL_REPO_PROJECTS+=(${projectName})
                ;;
            --pu | --no-pull)
                DO_NOT_MAKE_PULL_PROJECTS+=(${projectName})
                ;;
            --aio | --gwt)
                if [[ ${projectName} != cloud-ide* ]]; then
                    logerrorAndExit "${confEntry} option can be used with cloud-ide project only"
                fi

                local mvn_version=`mvn -v | grep "Apache Maven" | sed 's/Apache Maven //g' | sed 's/ .*//g'`
                if [[ "${mvn_version}" < "3.2.1" ]]; then
                    logerrorAndExit "'--gwt' is supported for maven 3.2.1 or later"
                else
                    if [[ ${confEntry} == "--aio" ]]; then
                        BUILD_ALL_IN_ONE_ONLY_IN_CLOUD_IDE=true
                    else
                        BUILD_GWT_IN_CLOUD_IDE=false
                    fi
                fi
                ;;
            --no-build | --nb | --nobuild)
                SKIP_BUILD_PROJECTS+=(${projectName})
                ;;
            --notests | --t)
                SKIP_TESTS_PROJECTS+=(${projectName})
                ;;
            --docker)
                if [[ ${projectName} != "odyssey" && ${projectName} != "user-dashboard" ]]; then
                    logerrorAndExit "Docker build is supported for odyssey and user-dashboard projects only"
                fi
                USE_DOCKER_FOR+=(${projectName})
                ;;
            *)
                logerrorAndExit "Unknown parameter ${confEntry} of project configuration is used"
                ;;
        esac
    done
}

gitCheckOut() {
    if [[ ${CHECKOUT_AGO} != false ]]; then
        local commit=$(git log -1 --until="${CHECKOUT_AGO} day ago" --oneline | sed 's/ .*//g')
        loginfo "Checkout to last yestarday's commit"
        cbuildEval "git checkout ${commit}"
    else
        # do checkout if branch exists or checkout strategy is not soft
        if [[ $(git show-ref --quiet ${BRANCH} && echo "0" || echo "-1") == 0 ]] || [[ ${CHECKOUT_STRATEGY} != "soft-checkout" && ${CHECKOUT_STRATEGY} != "fallback-checkout" ]]; then
            cbuildEval "git checkout ${BRANCH}"
        else
            # if checkout strategy is fallback do checkout to fallback branch
            if [[ ${CHECKOUT_STRATEGY} == "fallback-checkout" ]]; then
                cbuildEval "git checkout ${FALLBACK_BRANCH}"
                return
            fi

            loginfo "Branch ${BRANCH} is not found. Do not checkout. Current branch $(git rev-parse --abbrev-ref HEAD)"
        fi
    fi
}

clone() {
    local project_https_url=$(curl  --silent 'https://api.github.com/orgs/codenvy/repos?type=public&per_page=100' -q | grep "\"clone_url\"" | awk -F': "' '{print $2}' | sed -e 's/",//g' | grep "/${1}\.git")
    if [[ -z ${project_https_url} ]]; then
        local clone_command="git clone git@github.com:codenvy/${1}.git"
    else
        local clone_command="git clone ${project_https_url}"
    fi
    cbuildEval "${clone_command}"
}

# query value...value
getIndexInArray() {
    local str=$1; shift
    local array=( $( echo $@ ) )
    for (( i=0; i<${#array[*]}; i++ )); do
        [ ${array[$i]} == ${str} ] && echo ${i} && return 0
    done
    echo "-1" && return 0
}

startNotificationsHandling() {
   # catch stopping over exit command
   trap 'onAbort' EXIT
}

# send notification if build fails
onAbort() {
    if (($? != 0)); then
        echo $(makeRed "${ERROR_MESSAGE}")
        if [[ ${LOG} == true ]]; then
            echo "${ERROR_MESSAGE}" >> "${LOG_FILE}"
        fi

        notifyUser "Build failed ${COMMAND_LINE} \n ${ERROR_MESSAGE}" "normal" "error"

        printLastLogsLines 50
        printContinueHint
        exit 1
    fi
    exit 0
}

printLastLogsLines() {
    if [[ ${QUIET} == true && ${SUPPRESS_LOGS_ON_FAIL_IN_LOG_MODE} == false ]]; then
        echo $(makeRed "Last ${1} lines of log file:")
        tail -n ${1} ${LOG_FILE}
        echo $(makeGreen "Full log: ${LOG_FILE}")
        echo $(makeGreen "To read exec: cat ${LOG_FILE} | less")
    fi
}

printContinueHint() {
    if [[ ! -z ${PROJECT} ]]; then
        loginfo "After correcting the problems, you can resume the build with:"
        if [[ "${COMMAND_LINE}" == /usr/bin/cbuild* ]]; then
            local cmd_line="${COMMAND_LINE:9}"
        else
            local cmd_line="${COMMAND_LINE}"
        fi

        # remove old continue options
        cmd_line=$(echo "${cmd_line}" | sed "s/ -continue-from [^ ]\+//g" | sed "s/ -continue-after [^ ]\+//g")

        if [[ ${PERFORM_GIT_OPERATIONS} == true && ${GIT_OPERATIONS_FINISHED} == true ]]; then
            cmd_line="${cmd_line}"" --skip-git-operations"
        fi

        if [[ ${PROJECT} != ${CURRENT_PROJECTS[${#CURRENT_PROJECTS[@]}-1]} ]]; then
            loginfo "${cmd_line}"" -continue-after ${PROJECT}"
        fi
        loginfo "${cmd_line}"" -continue-from ${PROJECT}"
    fi
}

stopNotificationsHandling() {
    # unset catch stopping over exit command
    trap : EXIT
}

saveFunction() {
    local ORIG_FUNC=$(declare -f $1)
    local NEWNAME_FUNC="$2${ORIG_FUNC#$1}"
    eval "$NEWNAME_FUNC"
}

logerror() {
    ERROR_MESSAGE="cbuild:${BASH_LINENO[0]} $@"
}

logerrorAndExit() {
    logerror "$@"
    exit 1
}

loginfo() {
    echo $(makeGreen "$@")
    if [[ ${LOG} == true ]]; then
        echo "$@" >> "${LOG_FILE}"
    fi
}

logplain() {
    echo "$@"
    if [[ ${LOG} == true ]]; then
        echo "$@" >> "${LOG_FILE}"
    fi
}

makeGreen() {
    echo $(tput setaf 2)"$@"$(tput sgr 0)
}

makeRed() {
    echo $(tput setaf 1)"$@"$(tput sgr 0)
}

cbuildEval() {
    loginfo "$@"
    if [[ ${DRY_RUN} == false ]]; then
        if [[ ${LOG} == true ]]; then
            if [[ ${QUIET} == true ]]; then
                eval "$@" 2>&1 | tee -a "${LOG_FILE}" > /dev/null 2>&1
            else
                eval "$@" 2>&1 | tee -a "${LOG_FILE}"
            fi
        else
            eval "$@"
        fi
    fi
}

cdTo() {
    loginfo "cd ${1}"
    cd "${1}"
}
