#!/bin/bash
#
# The core of our action, it will be invoked with the name of the script
# to execute - If the script doesn't exist then that is a fatal error.
#
# The script used to default to `.github/run-tests.sh`, but now the
# name is passed as the first argument.
#

#
# Terminate upon errors
#
set -e


#
# Get the name of the script to run.
#
script=$1


#
# If the argument is empty that is a fatal error.
#
if [ -z "${script}" ]; then
    echo "You must specify the script to execute as an argument."
    exit 1
fi


#
# If the script does not exist that is a fatal-error.
#
if [ ! -e "${script}" ]; then
    echo "The supplied testing-script does not exist: ${script}"
    exit 1
fi


#
# Ensure the script is executable.
#
if [ ! -x "${script}" ]; then
    echo "The supplied testing-script is not executable: ${script}"
    exit 1
fi


# clean up the virtualenv folder before we try and run script
if [ -d /github/home/.local/share/virtualenv ]; then
  rm -r /github/home/.local/share/virtualenv
fi


#
# Run it.
#
${script}


#
# If the script exits with a non-zero status-code
# then it will terminate this script due to the use
# of `set -e`.
#
# So when we reach this point we know:
#
#  1.  We've executed the test-script.
#
#  2.  The test-script passed.
#
# Exit cleanly because we're done.
#
exit 0
