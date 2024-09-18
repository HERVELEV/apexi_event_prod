#!/bin/bash
# Script pour supprimer temporairement cucumberTest et lancer l'application

# Sauvegarder le fichier build.gradle original
cp build.gradle build.gradle.bak

# Supprimer temporairement la tâche cucumberTest
sed -i '/task cucumberTest(type: Test)/,/}/d' build.gradle

echo "Tâche cucumberTest supprimée temporairement."

# Lancer l'application
./gradlew bootRun

# Restaurer le fichier build.gradle original après l'exécution
mv build.gradle.bak build.gradle

echo "Fichier build.gradle restauré."
