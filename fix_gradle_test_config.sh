#!/bin/bash

# Nom du fichier build.gradle
BUILD_FILE="./build.gradle"

# Vérifier si la tâche cucumberTest existe déjà
if grep -q "task cucumberTest" "$BUILD_FILE"; then
    echo "La tâche cucumberTest existe déjà dans $BUILD_FILE. Aucun ajout nécessaire."
else
    echo "La tâche cucumberTest n'existe pas. Ajout de la configuration pour cucumberTest."
    
    # Ajouter la configuration pour cucumberTest à la fin du fichier build.gradle
    cat <<EOL >> "$BUILD_FILE"

if (!project.tasks.findByName('cucumberTest')) {
    task cucumberTest(type: Test) {
        useJUnitPlatform()
        testClassesDirs = sourceSets.test.output.classesDirs
        classpath = sourceSets.test.runtimeClasspath
    }
}
EOL

    echo "Configuration de la tâche cucumberTest ajoutée avec succès dans $BUILD_FILE."
fi

echo "Opération terminée."
