#!/usr/bin/env bash

set -e

if ["$#" -eq 0]; then
	echo "Usage : $0 \"message du commit\""
	exit 1
fi

MESSAGE="$*"

echo "Ajout des fichiers...."
git add .

echo "Création du commit...."
git commit -m "$MESSAGE"

echo "Push vers le dépôt...."
git push

echo "Commit / Push OK"

