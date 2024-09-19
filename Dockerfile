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
