#!/bin/bash

# Fichier à modifier
BUILD_GRADLE_FILE="build.gradle"

# Vérifier si le fichier build.gradle existe
if [ ! -f "$BUILD_GRADLE_FILE" ]; then
  echo "Le fichier $BUILD_GRADLE_FILE n'existe pas."
  exit 1
fi

# Compter le nombre d'occurrences de la tâche cucumberTest
cucumberTest_count=$(grep -c "task cucumberTest" "$BUILD_GRADLE_FILE")

if [ "$cucumberTest_count" -gt 1 ]; then
  echo "Il y a $cucumberTest_count occurrences de la tâche cucumberTest. Suppression des doublons..."

  # Supprimer toutes les occurrences de la tâche cucumberTest sauf la première
  awk '
    BEGIN { found = 0 }
    /task cucumberTest/ {
      found++
      if (found == 1) {
        print
        next
      }
    }
    !/task cucumberTest/ { print }
  ' "$BUILD_GRADLE_FILE" > "$BUILD_GRADLE_FILE.tmp" && mv "$BUILD_GRADLE_FILE.tmp" "$BUILD_GRADLE_FILE"

  echo "Doublons supprimés. Une seule définition de cucumberTest est maintenant présente."
else
  echo "Aucun doublon trouvé. Il y a $cucumberTest_count occurrence(s) de cucumberTest."
fi
