#!/bin/bash

# Sauvegarde du fichier build.gradle
cp build.gradle build.gradle.bak
echo "Le fichier build.gradle a été sauvegardé."

# Suppression de la tâche cucumberTest temporairement
sed -i '/task cucumberTest(type: Test) {/,/}/d' build.gradle
echo "La tâche cucumberTest a été temporairement supprimée."

# Exécution de la commande clean
echo "Exécution de la commande ./gradlew clean..."
./gradlew clean

# Vérification du statut de la commande précédente
if [ $? -eq 0 ]; then
  echo "La commande ./gradlew clean a été exécutée avec succès."
else
  echo "La commande ./gradlew clean a échoué."
fi

# Restauration du fichier build.gradle original
mv build.gradle.bak build.gradle
echo "Le fichier build.gradle original a été restauré."

# Fin du script
echo "Opération terminée."
