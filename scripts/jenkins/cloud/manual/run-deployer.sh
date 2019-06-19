#!/bin/bash

set -u -x

CLI=${CLI:=docker}
# CLI=podman

basedir=$(readlink --canonicalize $(dirname $0)/../../../../)

ionice -c idle ${CLI} build --tag ci-deployer \
    --build-arg python="${python:=python2.7}" \
    --build-arg git_user_name="${git_user_name:=$(git config --get user.name)}" \
    --build-arg git_user_email="${git_user_email:=$(git config --get user.email)}" \
    .

${CLI} create --interactive --tty \
    --name ci-deployer \
    --volume "${basedir}":/opt/automation \
    ${EXTRA_ARGS:-} \
    ci-deployer
${CLI} start ci-deployer

ANSIBLE_STDOUT_CALLBACK=debug ansible-playbook --inventory ci-deployer, \
    configure-deployer-container.yml

${CLI} attach ci-deployer
