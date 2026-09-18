#!/usr/bin/env bash

set -e

if [ -z "$*" ]; then
	echo "Erreur : message de commit obligatoire"
	exit 1
fi

if ["$#" -eq 0]; then
	echo "Usage : $0 \"message du commit\" [branche]"
	exit 1
fi

MESSAGE="$1"
BRANCHE="$2"

if [ -n "$BRANCHE" ]; then	
	if git show-ref --verify --quiet "refs/heads/$BRANCHE"; then
		read -r -p "Changement de branche vers $BRANCHE ? [y,n]" REPONSE
		if [[ "$REPONSE" =~ ^[YyoO]$ ]]; then
			echo "Bascule vers la branche $BRANCHE...."
			git checkout "$BRANCHE"
		else
			echo "Commit annulé"
			exit 1
		fi
	else
		read -r -p "La branche $BRANCHE est inconnue, la créer ? [y/n]" REPONSE2
		if [[ "$REPONSE2" =~ ^[YyoO]$ ]]; then
			echo "Création et basculent sur la branche : $BRANCHE ...."
			git checkout -b "$BRANCHE"
		else
			echo "commit annulé"
			exit 1
		fi
	fi
fi




echo "Ajout des fichiers...."
git add .

echo "Création du commit...."
git commit -m "$MESSAGE"

echo "Push vers le dépôt...."
git push

echo "Commit / Push OK"

#test6