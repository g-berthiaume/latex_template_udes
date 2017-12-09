% ======================================================================
% Classes pour rapport 
% ======================================================================
% Ce code rassemble les efforts d'étudiants de la faculté de génie  
% de l'université de Sherbrooke afin de faire un template LaTeX moderne
% dédié à l'écriture de rapport universitaire.
% Ce document est libre d'être utilisé et modifié.
% ======================================================================
% Requis: 
%   - LaTeX 
%   - Les packages sont entièrement défini dans cette classe.
%   - Pour pouvoir utiliser le package minted (code), il est nécessaire
%     d'avoir installer un module python. 
% Note:
%   Cette classe à été conçu pour compiler sans problème sur le site
%   www.sharelatex.com ou www.overleaf.com
%
% ======================================================================
% Version: 0.21
% ======================================================================
%
%     (((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
%     (((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
%     (((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
%     (((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
%     (((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
%     ((((((((((((((((*               .(((((((((((((   /(((((((((
%     (((((((((((((              *(,   (((((((((((((   /(((((((((
%     (((((((((((,            (((((,   ,(((((((((((    /(((((((((
%     ((((((((((*           ,((((((,     (((((((((     /(((((((((
%     ((((((((((            (((((((/                   ((((((((((
%     (((((((((/           .((((((((,                 (((((((((((
%     ((((((((((            (((((((((/               ((((((((((((
%     (((((((((((            (((((((((((          .((((((((((((((
%     ((((((((((((             (((((((((((((//(((((((((((((((((((
%     ((((((((((((((,                   ..,*//(((((((((((((((((((
%     (((((((((((((((((((/*,,.                    ,((((((((((((((
%     (((((((((((((((((((/((((((((((((((             ((((((((((((
%     ((((((((((((((.          (((((((((((            (((((((((((
%     ((((((((((((               /(((((((((            ((((((((((
%     (((((((((((                 ,((((((((.           /(((((((((
%     ((((((((((                   ((((((((            ((((((((((
%     (((((((((/     /((((((((     /((((((*           *((((((((((
%     (((((((((/    (((((((((((,   /(((((            ,(((((((((((
%     (((((((((/   (((((((((((((   /(/              (((((((((((((
%     (((((((((/   (((((((((((((.               *((((((((((((((((
%     (((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
%     (((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
%     (((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
%     (((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
%
% ======================================================================


% ----------------------------------------------------
% Initier la classe
% ----------------------------------------------------
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{udes_rapport}[2017/12/09 université de sherbrooke - template]
\LoadClass{article}


% ----------------------------------------------------
% Initier la langue
% ----------------------------------------------------
\RequirePackage{natbib}                                         % Semble important avant Babel
\RequirePackage[french, english]{babel}                         % Support Français et anglais
\RequirePackage[T1]{fontenc}                                    % Support des traits d'unions en FR
\RequirePackage[utf8]{inputenc}                                 % UFT8 - Pour les éèâü Français


% ----------------------------------------------------
% Ajouter des fonctionnalités et modifier
% l'aspect visuel du document
% ----------------------------------------------------

% Faire les marges
\RequirePackage[margin=2.5cm]{geometry}                        % Inclut le package et instaure les marges

% Modifier l'interligne
\linespread{1.5}                                                % Pour un interligne de 1.5

% Faire l'en-tête et le pied de page
\RequirePackage{fancyhdr}                                       % inclut le package
\RequirePackage{lastpage}                                       % Derniere page (pour le pied)
\pagestyle{fancy}                                               % active le package
\fancyhead{}                                                    % Reset l'en tête
\fancyfoot{}                                                    % Reset le pied de page
\fancyfoot[L]{\small APP \@num_app : \@nom_app}                 % Configure le style du pied de page
\fancyfoot[c]{}
\fancyfoot[R]{\small \thepage/\pageref{LastPage}}
\renewcommand{\headrulewidth}{0pt}                              % Reset la ligne de l'en tête
\renewcommand{\footrulewidth}{0pt}                              % Reset la ligne du pied de page
\pagenumbering{arabic}                                          % Met des nombre normal (pas romain)


% Faire des références
\RequirePackage[hidelinks]{hyperref}                            % Pour des référence clickables
\RequirePackage{natbib}                                         % Pour faire des références

% Ajouter/contrôler des figures 
\RequirePackage{graphicx}                                       % Pour importer des images
\RequirePackage{float}                                          % Pour contrôler des éléments flottants

% Pour les maths
\RequirePackage{xfrac}                                          % Pour faire des fractions

% Ajouter des couleurs
\RequirePackage{xcolor}                                         % Pour utiliser de la couleur
\definecolor{LightGray}{gray}{0.95}

% ----------------------------------------------------
% Configurer et construire la classe
% ----------------------------------------------------
\RequirePackage{lipsum}                                         % Pour créer des bloc de texte pour l'exemple
\RequirePackage{xifthen}                                        % Bool logique
\RequirePackage{xparse}                                         % Pour des fonctions latex3
\RequirePackage{pgffor}                                         % Utile pour faire des boucles for
\RequirePackage{minted}                                         % Pour lint du code
\RequirePackage{xcolor}                                         % Pour utiliser de la couleur
\RequirePackage{amsmath}                                        % Toolbox pour l'écriture d'équation
\RequirePackage{amssymb}                                        % Collection de symboles mathématique
\RequirePackage{bm}                                             % Police en gras
\RequirePackage{etoolbox}                                       % Toolbox pour aider la création de classe


% ----------------------------------------------------
% Initier la structure du documents
% ----------------------------------------------------
\graphicspath{{figures/}}                                       % Pour les figures


% ----------------------------------------------------
% Variables globales
% ----------------------------------------------------

% Défini le nom de la faculté
% Usage: \faculte{<Nom de faculté>}
\newcommand*{\faculte}[1]{\def\@faculte{#1}}


% Défini le nom du departement
% Usage: \departement{<Nom du departement>}
\newcommand*{\departement}[1]{\def\@departement{#1}}


% Défini le numéro et le nom de l'APP
% Usage: \app{<Numéro de l'app>}{<Nom de l'APP>}
\newcommand*{\app}[2]{\def\@num_app{#1} \def\@nom_app{#2}}


% Défini le nom du professeur
% Usage: \professeur{<Nom du professeur>}
\newcommand*{\professeur}[1]{\def\@professeur{#1}}

% Défini le nom des etudiants
% Usage: \etudiants{<Nom etudiant 1 - CIP \\ Nom etudiant 2 - CIP >}
\newcommand*{\etudiants}[1]{\def\@etudiants{#1}}


% Défini le date de Remise
% Usage: \dateRemise{<date de remise>}
\newcommand*{\dateRemise}[1]{\def\@dateRemise{#1}}



% ----------------------------------------------------
% Commandes fonctions
% ----------------------------------------------------
% API pour fabrique une page titre. Appellera la sous fonction
% appropriée pour générer la page
% Usage: \fairePageTitre{<style>}
% Args: <style>  peut être 'STD' ou 'LOGO'
% Note: Nécessite l'initialisation de variables globales
\newcommand{\fairePageTitre}[1]{%
        \ifstrempty{#1}{}{}%
        \ifstrequal{#1}{STD}{\pagetitreSTD}{} %
        \ifstrequal{#1}{LOGO}{\pagetitreLOGO}{}%
}


% Créer une page titre sans logo
% Usage: \pagetitreSTD
% Note: Cette fonction ne doit être utiliser que par l'API fairePageTitre
%       Nécessite l'initialisation de variables globales
\newcommand{\pagetitreSTD}{
\begin{titlepage}
\begin{center}
UNIVERSITÉ DE SHERBROOKE \\
Faculté de \MakeLowercase{\@faculte}\\
Département de \@departement\\
[2.5cm]
\textsc{\LARGE \@nom_app} \\
\textsc{APP \@num_app}\\
[3cm] 
Présenté à :\\
\@professeur \\
[2.5cm] 
Présenté par : \\
\@etudiants \\
[4.5cm]
Sherbrooke \\
\@dateRemise \\
\end{center}
\end{titlepage}
}

% Créer une page titre avec armoiries 
% Usage: \pagetitreLOGO
% Note: Cette fonction ne doit être utiliser que par l'API fairePageTitre
%       Nécessite l'initialisation de variables globales
\newcommand{\pagetitreLOGO}{
\begin{titlepage}
\begin{figure}[t]
\includegraphics[width=3cm]{udes_armoiries}
\centering
\end{figure}
\begin{center}
UNIVERSITÉ DE SHERBROOKE \\
Faculté de \MakeLowercase{\@faculte}\\
Département de \@departement\\
[2.5cm]
\textsc{\LARGE \@nom_app} \\
\textsc{APP \@num_app}\\
[2cm] 
Présenté à :\\
\@professeur \\
[2.5cm] 
Présenté par : \\
\@etudiants \\
[3.5cm]
Sherbrooke \\
\@dateRemise \\
\end{center}
\end{titlepage}
}

% Inclut une figure dans le texte
% Usage: \inclureFigure{maFigure}{0.5}{legende}{fig:1}
%        \inclureFigure{wrapfig}{maFigure}{0.5}{legende}{fig:1}
% Note: 
\DeclareDocumentCommand \inclureFigure
    { 
    % Arguments
    O{figure}   % #1 Type de wrapping (2 options: figure ou wrapfig
    m           % #2 Nom de la figure
    m           % #3 Taille de la figure
    m           % #4 Sous titre
    m           % #5 Étiquette
    }
    { 
    \ifthenelse{\equal{#1}{figure}}{
        \begin{figure}[h]
            \centering
            \includegraphics[width=#3\textwidth]{#2}
            \caption{#4}
            \label{#5}
        \end{figure}
    }{}%
    \ifthenelse{\equal{#1}{wrapfig}}{
        \begin{figure}[h]
            \centering
            \includegraphics[width=#3\textwidth]{#2}
            \caption{#4}
            \label{#5}
        \end{wrapfig}
    }{}%
}

% ----------------------------------------------------
% Commandes code linting
% ----------------------------------------------------

% Fabrique une boite de text pour du code cpp
% Usage: \begin{cppcode} <the code> \end{cppcode}
\newminted{cpp}{
frame=lines,
framesep=2mm,
baselinestretch=1.2,
bgcolor=LightGray,
fontsize=\footnotesize,
linenos}

% Fabrique une boite de text pour du code Python 3
% Usage: \begin{pythoncode} <the code> \end{pythoncode}
\newminted{python}{
frame=lines,
framesep=2mm,
baselinestretch=1.2,
bgcolor=LightGray,
fontsize=\footnotesize,
linenos,
python3=true
}
