/*
 * CodeC1.C
 * Calcul de la distance orthodromique (formule de Haversine)
 * entre deux points donnés par leur latitude et longitude.
 */

#include <stdio.h>
#include <math.h>

#define RAYON_TERRE_KM 6371.0   // Rayon moyen de la Terre en km
#define PI 3.14159265358979323846

// Convertit un angle exprimé en degrés vers des radians
double deg2rad(double degres) {
    return degres * (PI / 180.0);
}

// Retourne la distance (km) entre deux points géographiques
double haversine(double lat1, double lon1, double lat2, double lon2) {
    double dlat = deg2rad(lat2 - lat1);
    double dlon = deg2rad(lon2 - lon1);
    double a = sin(dlat / 2) * sin(dlat / 2)
             + cos(deg2rad(lat1)) * cos(deg2rad(lat2))
             * sin(dlon / 2) * sin(dlon / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return RAYON_TERRE_KM * c;
}

int main(void) {
    // Exemple : Sherbrooke -> Montréal
    double lat1 = 45.4042, lon1 = -71.8929;   // Sherbrooke
    double lat2 = 45.5017, lon2 = -73.5673;   // Montréal
    double distance = haversine(lat1, lon1, lat2, lon2);
    if (distance < 0.0) {
        printf("Erreur : distance invalide.\n");
        return 1;
    }
    printf("Distance Sherbrooke - Montreal : %.2f km\n", distance);
    return 0;
}
