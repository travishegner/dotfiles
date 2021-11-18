#!/bin/bash

function garter(){
	basedir="$HOME/.cache/garter"

	cmd=$1
	env=$2

	mkdir -p $basedir || true

	case "$cmd" in

		"list")
			ls $basedir
			;;

		"activate")
			if [ "$env" = "" ]; then
				garter help
				return 1
			fi
			source $basedir/$env/bin/activate
			;;

		"deactivate")
			deactivate
			;;

		"create")
			if [ "$env" = "" ]; then
				garter help
				return 1
			fi
			ls $basedir/$env > /dev/null 2>&1
			if [ $? -eq 0 ]; then
				echo "environment already exists"
				return 1
			fi
			shift
			shift
			virtualenv $@ $basedir/$env
			source $basedir/$env/bin/activate
			;;

		"destroy")
			if [ "$env" = "" ]; then
				garter help
				return 1
			fi
			which deactivate > /dev/null
			if [ $? -eq 0 ]; then
				echo "deactivating"
				deactivate
			fi
			rm -rf $basedir/$env
			;;

		"help")
			echo """
Usage:
garter <command>

Commands:
  list            Lists all available environments

  activate <env>  Activates named environment
  deactivate      Deactivates current environment

  create <env>    Creates named environment
  destroy <env>   Destroys named environment
"""
			;;

		*)
			echo "Invalid Command."
			garter help
			return 1
			;;

	esac

	return 0
}
