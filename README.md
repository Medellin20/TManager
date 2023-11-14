# Time Manger

Time Manager est une application web et mobile développée par la Mairie de Gotham pour permettre aux employés de consigner et de suivre leur temps de travail de manière précise et efficace. Cette plateforme vise à assurer de bonnes conditions de travail dans la dangereuse ville de Gotham.

Grâce à Time Manager, les employés peuvent enregistrer leurs heures de début et de fin de travail, ainsi que les pauses effectuées, de manière transparente et facilement accessible. Cette application offre une interface conviviale et intuitive, ce qui le rend facile à utiliser pour tous les employés de la mairie de Gotham, quel que soit leur niveau de compétence technique. Il est disponible à la fois sur le web et sur les appareils mobiles, ce qui permet aux employés de saisir et de consulter leurs informations de temps de travail à tout moment et en tout lieu.

Consultez les détails de ce projet en allant voir le [cahier des charges](Project%20Study/Cahier%20des%20charges.md).

Les technologies utilisées sont [Vue.js](https://vuejs.org/) pour le frontend, [phoenix](https://www.phoenixframework.org/) pour le backend et [PostgreSQL](https://www.postgresql.org/) comme système de gestion de base de données relationnelle.

Pour démarrer le projet procédez de la façon suivante :

- Démarrer le frontend
    - Exécuter la commande `npm install` pour installer les dépendances
    - Exécutez la commande `npm run dev` pour démarre le projet

- Démarrer la base de données
    - Exécutez les commandes suivantes pour démarrer la base de données :
        - `sudo -i -u postgres` pour accéder à l’utilisateur de postgres
        - `psql` pour démarrer postgres

- Démarrer le backend
    - Exécutez les commandes suivantes pour démarrer le projet phoenix :
        - `mix setup` pour installer les dépendances, créer la base de données et faire les migrations
        - `mix phx server` pour démarrer le backend en local