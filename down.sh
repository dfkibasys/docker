#!/bin/bash

############################################################
# Config Variables                                         #
############################################################

# Docker Compose Command
COMMAND="down"
IM_STACKS="00 10 20 22 30 40 50 60"
ES_STACKS="00 10 21 22 30 40 50 60"
if [[ ! -v ENV ]]; then
   ENV='dev'
fi
echo "Setting up '$ENV' environment"

############################################################
# Help                                                     #
############################################################
Help()
{
   # Display Help
   echo "Perform a 'docker compose $COMMAND' on selected stacks."
   echo
   echo "Syntax: pull -[s|h]"
   echo "options:"
   echo "-a [im|es]             - $COMMAND all stacks"
   echo "                         im = AAS stack with InMemory back-end (default)"
   echo "                         es = AAS stack with ElasticSearch back-end"
   echo "-s stack1 [stack2 ...] - $COMMAND a singe stack."
   echo "-h                     - print this help."
   echo
   echo "The stacks must adhere to the following naming convention:"
   echo "docker-compose-NUMBER-NAME.yml"
   echo
   echo "Then the stacks can either be referenced by number (e.g. 00) or by name (e.g. admin)."
   echo "The following commands are synonym:"
   echo
   echo "$COMMAND -s 20"
   echo "$COMMAND -s aas"
   echo
   echo "or (pay attention to the quotes)"
   echo
   if [[ $COMMAND == down ]] ; then
      echo "$COMMAND -s '10 00'"
      echo "$COMMAND -s 'communication 00'"
      echo "$COMMAND -s '10 admin'"
      echo "$COMMAND -s 'communication admin'"
   else
      echo "$COMMAND -s '00 10'"
      echo "$COMMAND -s '00 communication'"
      echo "$COMMAND -s 'admin 10'"
      echo "$COMMAND -s 'admin communication'"
   fi

}

function Reverse
{
   #echo $#
   #echo $@
   local reverse=""
   for value in "$@"
      do
	     reverse=$value" "$reverse	  
	     #echo $reverse	  
      done
   echo "$reverse"
}

Find()
{
   PATTERN="docker-compose*[-.]$1[-.]*yml"
   #echo "Pattern:" $PATTERN
   #$(find . -type f -name $PATTERN)
   find . -type f -name $PATTERN
}

ExtractName()
{
   #echo "to extract" $1
   echo $1 | grep -oP '\./docker-compose-[0-9]+-\K[a-z_0-9]+(?=.\yml)'
}

Single()
{
for value in "$@"
   do
      #echo "Process" $value
      STACK=$(Find $value)
      echo "Stack found:" $STACK
      NAME=$(ExtractName $STACK)
      echo "Stack name:" $NAME
	  if [[ $COMMAND == pull ]] ; then
        docker compose -f $STACK --env-file .env.$ENV $COMMAND 		
      elif [[ $COMMAND == up ]] ; then
	    docker compose -f $STACK -p $NAME --env-file .env.$ENV $COMMAND -d  --wait
	  elif [[ $COMMAND == down ]] ; then 
	    docker compose -f $STACK -p $NAME --env-file .env.$ENV $COMMAND
	  else
	    echo "unknown COMMAND" $COMMAND
	  fi
   done
exit
}

All()
{
STACKS=$IM_STACKS
case $1 in
 es)
	echo "All (elasic)"
	STACKS=$ES_STACKS
	#Single $ESTACKS
	;;
 im)
	echo "All (inmemory)"
	#Single $IM_STACKS
	;;
 *)
	echo "All (default = inmemory)"
	#Single $IM_STACKS
	;;
esac

if [[ $COMMAND == down ]] ; then 
   echo "reverse"
   STACKS=$(Reverse $STACKS)
fi	
Single $STACKS
}

############################################################
############################################################
# Main program                                             #
############################################################
############################################################


############################################################
# Process the input options. Add options as needed.        #
############################################################
# Get the options
while getopts "hs:a" option; do
   case $option in
      h) # display Help
         Help
         exit;;
      s) # Enter a stackname
         Single $OPTARG
         exit;;
      a) # https://stackoverflow.com/questions/11517139/optional-option-argument-with-getopts
         # Check next positional parameter
         eval nextopt=\${$OPTIND}
         # existing or starting with dash?
         if [[ -n $nextopt && $nextopt != -* ]] ; then
           OPTIND=$((OPTIND + 1))
           All $nextopt
         else
           All
         fi		 
         exit;;
     \?) # Invalid option
         echo "Error: Invalid option"
         Help
         exit;;
   esac
done

Help
