#!/bin/bash

# Vérification de la disponibilité du serveur Eureka
EUREKA_URL="http://localhost:8761/eureka/"
CONFIG_FILE="./src/main/resources/config/application.yml"

echo "Vérification de la disponibilité du serveur Eureka à $EUREKA_URL..."

# Utilisation de curl pour vérifier si Eureka est accessible
if curl --output /dev/null --silent --head --fail "$EUREKA_URL"; then
    echo "Eureka est accessible."
else
    echo "Eureka n'est pas accessible. Désactivation de la connexion à Eureka dans la configuration."
    
    # Vérification de la présence de la configuration Eureka dans le fichier application.yml
    if grep -q "eureka" "$CONFIG_FILE"; then
        # Commenter les lignes relatives à Eureka
        echo "Configuration Eureka trouvée dans $CONFIG_FILE. Désactivation..."
        sed -i 's/^\(.*eureka.*\)/#\1/' "$CONFIG_FILE"
        echo "Configuration Eureka désactivée."
    else
        echo "Aucune configuration Eureka trouvée dans le fichier $CONFIG_FILE."
    fi
fi

echo "Opération terminée."
