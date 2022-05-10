#!/bin/bash

# TODO: Check for existing stack name.

SCRIPT_NAME=$(basename $0)
DEFAULT_STACK_NAME=$(basename $PWD)
STACK_NAME=${2:-$DEFAULT_STACK_NAME}


sub_help(){
    echo "Usage: $SCRIPT_NAME <subcommand> [options]"
    echo "Subcommands:"
    echo "    up"
    echo "    down"
    echo "    ps"
    echo "    services"
    echo "    full_reload"
}

sub_up() {
    docker stack deploy -c <(STACK_NAME=$STACK_NAME docker-compose config) $STACK_NAME
}

sub_down() {
    docker stack rm $STACK_NAME
}

sub_services() {
    docker stack ps $STACK_NAME
}

sub_ps() {
    docker stack services $STACK_NAME
}

sub_full_reload() {
    sub_down $@
    sub_up $@
}


subcommand=$1
case $subcommand in
    "" | "-h" | "--help")
        sub_help
        ;;
    *)
        shift
        sub_${subcommand} $@
        if [ $? = 127 ]; then
            echo "Error: '$subcommand' is not a known subcommand." >&2
            echo "       Run '$SCRIPT_NAME --help' for a list of known subcommands." >&2
            exit 1
        fi
        ;;
esac

