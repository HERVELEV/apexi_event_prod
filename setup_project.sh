#!/bin/bash

# Fonction pour vérifier l'existence d'un répertoire
check_directory() {
    if [ ! -d "$1" ]; then
        echo "Répertoire '$1' introuvable. Création en cours..."
        mkdir -p "$1"
        echo "Répertoire '$1' créé."
    else
        echo "Répertoire '$1' déjà présent."
    fi
}

# Vérification et création des répertoires nécessaires
check_directory "app"
check_directory "config"

# Vérifier l'existence du Dockerfile
if [ ! -f "Dockerfile" ]; then
    echo "Dockerfile introuvable. Création en cours..."
    cat <<EOF > Dockerfile
# Utiliser une image de base
FROM node:18

# Créer le répertoire de l'application
WORKDIR /app

# Copier le package.json et package-lock.json
COPY package*.json ./

# Installer les dépendances
RUN npm install

# Copier le reste des fichiers de l'application
COPY . .

# Exposer le port que l'application utilisera
EXPOSE 3000

# Commande pour démarrer l'application
CMD ["node", "ng"]
EOF
    echo "Dockerfile créé."
else
    echo "Dockerfile déjà présent."
fi

# Vérifier l'existence d'un fichier de configuration
CONFIG_FILE="config/config.json"
if [ ! -f "$CONFIG_FILE" ]; then
    echo "Fichier de configuration introuvable. Création en cours..."
    echo '{"key": "value"}' > "$CONFIG_FILE"
    echo "Fichier de configuration créé."
else
    echo "Fichier de configuration déjà présent."
fi

# Vérifier que le répertoire 'app' contient le fichier package.json
PACKAGE_FILE="app/package.json"
if [ ! -f "$PACKAGE_FILE" ]; then
    echo "Le fichier package.json est introuvable dans le répertoire 'app'."
    echo "Création d'un package.json par défaut..."
    cat <<EOF > "$PACKAGE_FILE"
{
  "name": "mon_app",
  "version": "1.0.0",
  "description": "Une application Node.js",
  "main": "index.js",
  "scripts": {
    "start": "node ng"
  },
  "dependencies": {
    "express": "^4.17.1"
  }
}
EOF
    echo "Fichier package.json créé. Veuillez le remplir si nécessaire."
fi

# Construire l'image Docker
echo "Construction de l'image Docker..."
docker build -t mon_image .

# Démarrer le conteneur
echo "Démarrage du conteneur..."
docker run -d --name mon_conteneur mon_image

# Vérifier si le conteneur est en cours d'exécution
if [ "$(docker ps -q -f name=mon_conteneur)" ]; then
    echo "Conteneur démarré avec succès."
else
    echo "Erreur lors du démarrage du conteneur. Vérification des logs..."
    docker logs mon_conteneur
    exit 1
fi

# Exécuter des tests (ajuster selon vos besoins)
echo "Exécution des tests..."
# Ajoutez ici vos commandes de test, par exemple :
# npm test

# Si tout est bon, re-exécuter le script
echo "Script exécuté avec succès. Relancer le script pour valider le tout ? (y/n)"
read RESTART
if [ "$RESTART" == "y" ]; then
    exec "$0"
else
    echo "Fin du script."
fi
