# Cours d'introduction au Machine Learning [FRENCH]:

Par Léo Beaucourt
(Merci de citer si partagé)


--------------------------------

Introduction à l'apprentissage supervisé et non-supervisé à travers l'exploration des principaux algorithmes.

- explication "théoriques" du fonctionnement des algos
- Mise en pratique à l'aide de Python et de bibliothèque de machine learning (scikit-learn, tensorflow)

--------------

### Pour lancer les notebooks, utiliser le Dockerfile fourni:

> docker build -t jupyter .

> docker run -m <X>GB -it --rm -p 8888:8888  -v <path/to/notebooks/directory/>:/lab  jupyter

Attention: certains algos sont très gourmand, il est nécessaire de bien spécifier une valeur de CPU inférieure à celle disponible.

--------------

### Pour compiler les diapositives avec LaTeX

For linux users, if you install texlive, you should update your PATH

> export PATH=/usr/local/texlive/2017/bin/x86_64-linux:$PATH

You need xelatex to compile tex file to pdf

> xelatex templateBeamerAgaetis.tex
