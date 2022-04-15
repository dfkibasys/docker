#!/bin/bash
############################################################
# Help                                                     #
############################################################
Help()
{
   # Display Help
   echo "Perform a 'docker compose down' on all or a single stack."
   echo
   echo "Syntax: down [-a|s|h]"
   echo "options:"
   echo "-a       Down all stacks"
   echo "-s name  Down a singe stack (admin, communication, aas, controlcomponents, processcontrol)."
   echo "-h       Print this Help."
   echo
}

All()
{
echo "Down processcontrol"
docker compose -f docker-compose-40-processcontrol.yml -p processcontrol down
echo "Down controlcomponents"
docker compose -f docker-compose-30-controlcomponents.yml -p controlcomponents down
echo "Down aas"
docker compose -f docker-compose-20-aas.yml -p aas down
echo "Down communication"
docker compose -f docker-compose-10-communication.yml -p communication down
echo "Down admin"
docker compose -f docker-compose-00-admin.yml -p admin down
}

Single()
{
case $1 in
   admin)
      echo "Down admin"
      docker compose -f docker-compose-00-admin.yml -p admin down
      ;;
   communication)
      echo "Down communication"
      docker compose -f docker-compose-10-communication.yml -p communication down
      ;;
   aas)
      echo "Down aas"
      docker compose -f docker-compose-20-aas.yml -p aas down
      ;;
   controlcomponents)
      echo "Down controlcomponents"
      docker compose -f docker-compose-30-controlcomponents.yml -p controlcomponents down
      ;;
   processcontrol)
      echo "Down processcontrol"
      docker compose -f docker-compose-40-processcontrol.yml -p processcontrol down
      ;;
   *)
      echo "Error: Unknown Stack $1"
      Help
      ;;
esac
}
############################################################
############################################################
# Main program                                             #
############################################################
############################################################

# Set variables
#Stack=""

############################################################
# Process the input options. Add options as needed.        #
############################################################
# Get the options
while getopts ":has:" option; do
   case $option in
      h) # display Help
         Help
         exit;;
      a) # Enter a stackname
         All
         exit;;
      s) # Enter a stackname
         Single $OPTARG
         exit;;
     \?) # Invalid option
         echo "Error: Invalid option"
         Help
         exit;;
   esac
done

Help
