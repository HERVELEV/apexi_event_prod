#!/bin/bash

CONTAINER_NAME="apexi_event_prod-frontend-1"

# Redémarrer le conteneur
echo "Redémarrage du conteneur $CONTAINER_NAME..."
docker start $CONTAINER_NAME

# Attendre quelques secondes pour que le conteneur démarre
sleep 5

# Vérifier les logs du conteneur
echo "Logs du conteneur $CONTAINER_NAME :"
docker logs $CONTAINER_NAME
