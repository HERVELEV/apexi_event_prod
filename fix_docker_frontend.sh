#!/bin/bash

# Variables
CONTAINER_NAME="apexi_event_prod-frontend-1"
APP_DIR="/app"

# Vérifie si le conteneur est arrêté
if [ "$(docker ps -q -f name=$CONTAINER_NAME)" ]; then
    echo "Le conteneur est en cours d'exécution."
else
    echo "Le conteneur est arrêté. Tentative de démarrage..."
    docker start $CONTAINER_NAME
    
    # Attendre quelques secondes pour que le conteneur démarre
    sleep 5
fi

# Vérifie si le conteneur est en cours d'exécution maintenant
if [ "$(docker ps -q -f name=$CONTAINER_NAME)" ]; then
    echo "Démarrage d'un shell dans le conteneur pour diagnostiquer..."
    docker exec -it $CONTAINER_NAME /bin/bash -c "
        echo 'Accès au répertoire $APP_DIR...'
        cd $APP_DIR
        
        echo 'Vérification de la structure du projet...'
        ls -la

        echo 'Vérification de la présence du module ng...'
        if [ ! -d 'ng' ]; then
            echo 'Module ng introuvable. Tentative d\'installation des dépendances...'
            npm install
        else
            echo 'Module ng trouvé.'
        fi
        
        echo 'Vérification des dépendances installées...'
        npm list
    "
else
    echo "Le conteneur ne démarre pas. Vérifiez les logs pour plus d'informations."
    docker logs $CONTAINER_NAME
fi

# Vérifie la présence d'un Dockerfile avant de reconstruire l'image
if [ -f "Dockerfile" ]; then
    echo "Reconstruire l'image Docker..."
    docker build -t $DOCKER_IMAGE .
else
    echo "Dockerfile introuvable, impossible de reconstruire l'image."
fi

echo "Script terminé."

