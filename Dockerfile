# Image de base avec Python 3.7
FROM python:3.10

# Création d'un utilisateur non-root pour la sécurité
RUN useradd flask

# Répertoire de travail dans le conteneur
WORKDIR /home/flask

# Ajouter tout le contexte (sauf ce qui est dans .dockerignore)
ADD . .

# Installation des dépendances
RUN pip install -r requirements.txt

# Rendre les fichiers exécutables et attribuer les droits
RUN chmod a+x app.py test.py && \
    chown -R flask:flask ./

# Config de l'application
ENV FLASK_APP app.py

# Port exposé
EXPOSE 5000

# Utiliser l'utilisateur flask (non-root)
USER flask

# Commande par défaut : démarrer l'app
# Lancer l'application
CMD ["python", "app.py"]
