#!/bin/bash
############################################################
# Help                                                     #
############################################################
Help()
{
   # Display Help
   echo "Perform a 'docker compose up -d' on all or a single stack."
   echo
   echo "Syntax: up [-a|s|h]"
   echo "options:"
   echo "-a       Up all stacks"
   echo "-s name  Up a singe stack (admin, communication, aas, controlcomponents, processcontrol)."
   echo "-h       Print this Help."
   echo
}

All()
{
echo "Up admin"
docker compose -f docker-compose-00-admin.yml -p admin up -d
echo "Up communication"
docker compose -f docker-compose-10-communication.yml -p communication up -d
echo "Up aas"
docker compose -f docker-compose-20-aas.yml -p aas up -d
echo "Up controlcomponents"
docker compose -f docker-compose-30-controlcomponents.yml -p controlcomponents up -d
echo "Up processcontrol"
docker compose -f docker-compose-40-processcontrol.yml -p processcontrol up -d
}

Single()
{
case $1 in
   admin)
      echo "Up admin"
      docker compose -f docker-compose-00-admin.yml -p admin up -d
      ;;
   communication)
      echo "Up communication"
      docker compose -f docker-compose-10-communication.yml -p communication up -d
      ;;
   aas)
      echo "Up aas"
      docker compose -f docker-compose-20-aas.yml -p aas up -d
      ;;
   controlcomponents)
      echo "Up controlcomponents"
      docker compose -f docker-compose-30-controlcomponents.yml -p controlcomponents up -d
      ;;
   processcontrol)
      echo "Up processcontrol"
      docker compose -f docker-compose-40-processcontrol.yml -p processcontrol up -d
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
