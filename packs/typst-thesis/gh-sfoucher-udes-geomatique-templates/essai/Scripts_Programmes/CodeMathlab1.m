% CodeC1.m
% Calcul de la distance orthodromique (formule de Haversine)
% entre deux points donnés par leur latitude et longitude.

clear; clc;

% Déclaration des constantes
RAYON_TERRE_KM = 6371.0; % Rayon moyen de la Terre en km

% Exemple : Sherbrooke -> Montréal
lat1 = 45.4042; lon1 = -71.8929;  % Sherbrooke
lat2 = 45.5017; lon2 = -73.5673;  % Montréal

% Calcul de la distance
distance = haversine(lat1, lon1, lat2, lon2, RAYON_TERRE_KM);

% Affichage du résultat
if distance < 0.0
    fprintf('Erreur : distance invalide.\n');
else
    fprintf('Distance Sherbrooke - Montreal : %.2f km\n', distance);
end

% --- Fonctions locales ---

% Convertit un angle exprimé en degrés vers des radians
function rad = deg2rad_local(degres)
    rad = degres * (pi / 180.0);
end

% Retourne la distance (km) entre deux points géographiques
function dist = haversine(lat1, lon1, lat2, lon2, rayon)
    dlat = deg2rad_local(lat2 - lat1);
    dlon = deg2rad_local(lon2 - lon1);  
    a = sin(dlat / 2)^2 + cos(deg2rad_local(lat1)) * cos(deg2rad_local(lat2)) * sin(dlon / 2)^2;
    c = 2 * atan2(sqrt(a), sqrt(1 - a));   
    dist = rayon * c;
end