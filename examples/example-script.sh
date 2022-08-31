#! /bin/bash
# ==============================================
# NOTE: make sure that you add execute permissions to your script files before you 
# commit them to the repository for the first time!
#   eg:
#      chmod a+x examples/example-script.sh
# ==============================================

# ==============================================
# help() is displayed when:
#   - the script is run with the `--help` flag or the `-h` flag
#   - the script is run with an unrecognized flag
# ==============================================
function help() {
  # These variables let you format the script output
  local BOLD=$(tput bold)
  local NORMAL=$(tput sgr0)
  echo -e "${BOLD}Usage:${NORMAL} example-script.sh --foo=bar --required-parameter=yes"
  echo
  echo -e "example-script.sh is an example of how to write bash scripts"
  echo
  echo -e "${BOLD}Options:${NORMAL}"
  echo -e "  --foo                  (optional) the value for foo [you should be more spcific here]"
  echo -e "  --required-parameter   the required value for required-parameter [again, be specific]"
}

# ==============================================
# This basically allows you to standardize your log messages. 
# You don't have to format them like this if you don't want to, you could just use `echo`
# I like being able to see what process ID is associated with the script and the time of the message.
# ==============================================
function log() {
  PID=$1
  MESSAGE=$2
  TIME=$(date +%F_%H.%M.%S_%Z)
  echo -e "${TIME}|${PID}|${MESSAGE}"
}

# ==============================================
# This basically allows you to standardize your error messages. 
# You don't have to format them like this if you don't want to, you could just use `echo`
# I like being able to see what process ID is associated with the script and the time of the message.
# ==============================================
function log_error() {
  # Colors:
  TEXT_RESET='\033[0m' 
  TEXT_RED='\033[0;31m'
  TEXT_RED_BOLD='\033[1;31m'

  PID=$1
  MESSAGE=$2
  TIME=$(date +%F_%H.%M.%S_%Z)
  echo -e "${TIME}|${PID}|${TEXT_RED_BOLD}ERROR: ${TEXT_RED}${MESSAGE}${TEXT_RESET}\n"
}

# ==============================================
# Initialize
# ==============================================
PID=$$ # this is a special syntax that gets the process ID for the script
# Colors:
TEXT_RESET='\033[0m' 
TEXT_BLACK_BOLD=$(tput bold)

for i in "$@"
do
case $i in
    --help|-h)
      help
      exit 0
      ;;
    --foo=*)
      FOO="${i#*=}"
      ;;
    --required-parameter=*)
      REQUIRED_PARAMETER="${i#*=}"
      ;;
    *)
      log_error $PID "Invalid argument ${i} in command: $0 $*"
      help
      exit 1
  esac
  shift
done

# Check for required parameters and exit if they're not present
if [ ! $REQUIRED_PARAMETER ]; then
  log_error $PID "--required-parameter is missing!"
  help
  exit 2 # using different exit codes for different exceptions can help you find the problem more easily
fi

# ==============================================
# Now that things are initialized, do it the work
# ==============================================
log $PID "${TEXT_BLACK_BOLD}Running example script...${TEXT_RESET}"
log $PID "Value passed in for --foo: ${FOO}"
log $PID "Value passed in for --required-parameter: ${REQUIRED_PARAMETER}"

log $PID "List /tmp/"
ls -l /tmp/
if [ $? != 0 ]; then
  # $? is the "exit code" for the preceeding command. Good for checking that the command actually succeeded.
  log_error $PID "If you're seeing this, you probably don't have a /tmp directory (which would be unusual)"
  exit 3
fi

log $PID "List /foo/bar/"
ls -l /foo/bar/
if [ $? != 0 ]; then
  # $? is the "exit code" for the preceeding command. Good for checking that the command actually succeeded.
  log_error $PID "You should see this, because it'd be weird if you had a /foo/bar directory. This is to show a failed command."
  exit 3 # I use the same code here, because I consider this the same error for the purpose of this script
fi

