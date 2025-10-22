/* NAME: IBSA MAGARSA LAMESSA 
  ID: UGR/34652/16
  SECTION: 4 
  GROUP: 7
 DATA STRUCTURE AND ALGORITHM INDIVUDUAL ASSIGNMENT*/
#include <iostream>
#include <vector>
#include <limits>
#include <iomanip>
#include <queue>
#include <set>
using namespace std;
const int NUM_CITIES = 14;
const int INF = numeric_limits<int>::max();
void printAdjacencyMatrix(const vector<vector<int>>& matrix, const vector<string>& cityNames) {
    cout << "Adjacency Matrix (Distances in km):" << endl;
    cout << setw(11) << " " ;
    for (const auto& city : cityNames) {
        cout << setw(11) << city;}
    cout << endl;
    for (int i = 0; i < NUM_CITIES; ++i) {
        cout << setw(11) << cityNames[i];
        for (int j = 0; j < NUM_CITIES; ++j) {
            if (matrix[i][j] == INF) {
                cout << setw(11) << "INF";}
            else {
                cout << setw(11) << matrix[i][j];}}
        cout << endl;}}
void dijkstra(const vector<vector<int>>& adjacencyMatrix, int start, const vector<string>& cityNames) {
    vector<int> distances(NUM_CITIES, INF);
    vector<bool> visited(NUM_CITIES, false);
    distances[start] = 0;
    for (int i = 0; i < NUM_CITIES - 1; ++i) {
        int minDistance = INF;
        int minIndex = -1;
        for (int j = 0; j < NUM_CITIES; ++j) {
            if (!visited[j] && distances[j] < minDistance) {
                minDistance = distances[j];
                minIndex = j;}}
        visited[minIndex] = true;
        for (int k = 0; k < NUM_CITIES; ++k) {
            if (!visited[k] && adjacencyMatrix[minIndex][k] != INF &&
                distances[minIndex] + adjacencyMatrix[minIndex][k] < distances[k]) {
                distances[k] = distances[minIndex] + adjacencyMatrix[minIndex][k];}}}
    cout << "Shortest distances from " << cityNames[start] << ":\n";
    for (int i = 0; i < NUM_CITIES; ++i) {
        if (distances[i] == INF) {
            cout << "To " << cityNames[i] << ": INF\n";
        } else {
            cout << "To " << cityNames[i] << ": " << distances[i] << " km\n";}}}
int main() {
    cout<<endl;
    cout<<endl<<"                                                     ADAMA SCINCE AND TECHNOLOGY UNIVERSITY"<<endl<<"                                                   SCHOOL OF ELECTRICAL AND COMPUTING ENGINEERING";
    cout<<endl;
    cout<<"                                                        DATA STRUCTURE AND ALGORITHM"<<endl;
    cout<<"                                         "<<setw(15)<<"NAME"<<setw(15)<<"ID"<<setw(18)<<"SECTION";
    cout<<endl;
    cout<<"                                         "<<setw(20)<<"-IBSA MAGARSA"<<setw(18)<<"UGR/34652/16"<<setw(10)<<"4 G-7";
    cout<<endl;
    cout<<endl;
    cout<<"                                            "<<"-SUBMITTED TO: Mr.ANTENEH TILAYE ";
    cout<<endl;
    cout<<"                                            "<<"-SUBMISSION DATE: DECEMBER 30/2024";
    cout<<endl<<endl;
    vector<vector<int>> adjacencyMatrix(NUM_CITIES, vector<int>(NUM_CITIES, INF));
    vector<string> cityNames = {"Addis Ababa", "Bahir Dar", "Semera", "Mekelle", "Dire Dawa", "Hawassa", "Adama","Asossa","Gambella","Harar","Jijiga","Bonga","Woliata","Hossana"};
    for (int i = 0; i < NUM_CITIES; ++i) {
        adjacencyMatrix[i][i] = 0;}
    adjacencyMatrix[0][1] = 565;  // AA to BD
    adjacencyMatrix[0][2] = 594;  // AA to SM
    adjacencyMatrix[0][3] = 780;  // AA to MK
    adjacencyMatrix[0][4] = 515;  // AA to DD
    adjacencyMatrix[0][5] = 275;  // AA to HW
    adjacencyMatrix[0][6] = 95;   // AA to AD
    adjacencyMatrix[0][7] = 662;  // AA to AS
    adjacencyMatrix[0][8] = 706;  // AA to GA
    adjacencyMatrix[0][9] = 515;  // AA to HA
    adjacencyMatrix[0][10] = 618; // AA to JIG
    adjacencyMatrix[0][11] = 908; // AA to BO
    adjacencyMatrix[0][12] = 312; // AA to WO
    adjacencyMatrix[0][13] = 231; // AA to HO

    adjacencyMatrix[1][0]  = 565; // BD to AA
    adjacencyMatrix[1][2]  = 393; // BD to SE
    adjacencyMatrix[1][3]  = 335; // BD to MK
    adjacencyMatrix[1][4]  = 600; // BD to DD
    adjacencyMatrix[1][5]  = 555; // BD to HW
    adjacencyMatrix[1][6]  = 431; // BD to AD
    adjacencyMatrix[1][7]  = 355; // AA to AS
    adjacencyMatrix[1][8]  = 482; // AA to GA
    adjacencyMatrix[1][9]  = 606; // AA to HA
    adjacencyMatrix[1][10] = 642; // AA to JIG
    adjacencyMatrix[1][11] = 493; // AA to BO
    adjacencyMatrix[1][12] = 525; // AA to WO
    adjacencyMatrix[1][13] = 450; // AA to HO

    adjacencyMatrix[2][0]  = 594;  // SE to AA
    adjacencyMatrix[2][1]  = 393;  // SE to BD
    adjacencyMatrix[2][3]  = 251;  // SE to MK
    adjacencyMatrix[2][4]  = 257;  // SE to DD
    adjacencyMatrix[2][5]  = 592;  // SE to HW
    adjacencyMatrix[2][6]  = 495;  // SE to AD
    adjacencyMatrix[2][7]  = 728;  // SE to AS
    adjacencyMatrix[2][8]  = 1283; // SE to GA
    adjacencyMatrix[2][9]  = 536;  // SE to HA
    adjacencyMatrix[2][10] = 334;  // SE to JIG
    adjacencyMatrix[2][11] = 718;  // SE to BO
    adjacencyMatrix[2][12] = 702;  // SE to WO
    adjacencyMatrix[2][13] = 583;  // SE to HO

    adjacencyMatrix[3][0]  = 780; // MK to AA
    adjacencyMatrix[3][1]  = 600; // MK to BD
    adjacencyMatrix[3][2]  = 251; // MK to SM
    adjacencyMatrix[3][4]  = 512; // MK to DD
    adjacencyMatrix[3][5]  = 763; // MK to HW
    adjacencyMatrix[3][6]  = 606; // MK to AD
    adjacencyMatrix[3][7]  = 659; // MK to AS
    adjacencyMatrix[3][8]  = 791; // MK to GA
    adjacencyMatrix[3][9]  = 547; // MK to HA
    adjacencyMatrix[3][10] = 590; // MK to JIG
    adjacencyMatrix[3][11] = 773; // MK to BO
    adjacencyMatrix[3][12] = 1181; //MK to WO
    adjacencyMatrix[3][13] = 684; // MK to HO


    adjacencyMatrix[4][0]  = 515; // DD to AA
    adjacencyMatrix[4][1]  = 600; // DD to BD
    adjacencyMatrix[4][2]  = 257; // DD to SM
    adjacencyMatrix[4][3]  = 512; // DD to MK
    adjacencyMatrix[4][5]  = 505; // DD to HW
    adjacencyMatrix[4][6]  = 439; // DD to AD
    adjacencyMatrix[4][7]  = 811; // DD to AS
    adjacencyMatrix[4][8]  = 814; // DD to GA
    adjacencyMatrix[4][9]  = 51;  // DD to HA
    adjacencyMatrix[4][10] = 105; // DD to JIG
    adjacencyMatrix[4][11] = 669; // DD to BO
    adjacencyMatrix[4][12] = 549; // DD to WO
    adjacencyMatrix[4][13] = 496; // DD to HO


    adjacencyMatrix[5][0]  = 275; // HW to AA
    adjacencyMatrix[5][1]  = 300; // HW to BD
    adjacencyMatrix[5][2]  = 592; // HW to SE
    adjacencyMatrix[5][3]  = 763; // HW to MK
    adjacencyMatrix[5][4]  = 505; // HW to DD
    adjacencyMatrix[5][6]  = 221; // HW to JM
    adjacencyMatrix[5][7]  = 566; // HW to AS
    adjacencyMatrix[5][8]  =476;  // HW to GA
    adjacencyMatrix[5][9]  = 555; // HW to HA
    adjacencyMatrix[5][10] = 569; // HW to JIG
    adjacencyMatrix[5][11] = 249; // HW to BO
    adjacencyMatrix[5][12] = 82;  // HW to WO
    adjacencyMatrix[5][13] = 87;  // HW to HA


    adjacencyMatrix[6][0]  = 95;  // AD to AA
    adjacencyMatrix[6][1]  = 431; // AD to BD
    adjacencyMatrix[6][2]  = 495; // AD to SM
    adjacencyMatrix[6][3]  = 606; // AD to MK
    adjacencyMatrix[6][4]  = 439; // AD to DD
    adjacencyMatrix[6][5]  = 221; // AD to HW
    adjacencyMatrix[6][7]  = 748; // AD to AS
    adjacencyMatrix[6][8]  = 567; // AD to GA
    adjacencyMatrix[6][9]  = 489; // AD to HA
    adjacencyMatrix[6][10] = 530; // AD to JIG
    adjacencyMatrix[6][11] = 533; // AD to BO
    adjacencyMatrix[6][12] = 326; // AD to WO
    adjacencyMatrix[6][13] = 240; // AD to HA


    adjacencyMatrix[7][0]  = 662; // AS to AA
    adjacencyMatrix[7][1]  = 355; // AS to BD
    adjacencyMatrix[7][2]  = 728; // AS to SM
    adjacencyMatrix[7][3]  = 606; // AS to MK
    adjacencyMatrix[7][4]  = 811; // AS to DD
    adjacencyMatrix[7][5]  = 566; // AS to HW
    adjacencyMatrix[7][6]  = 746; // AS to AD
    adjacencyMatrix[7][8]  = 209; // AS to GA
    adjacencyMatrix[7][9]  = 835; // AS to HA
    adjacencyMatrix[7][10] = 909; // AS to JIG
    adjacencyMatrix[7][11] = 360; // AS to BO
    adjacencyMatrix[7][12] = 502; // AS to WO
    adjacencyMatrix[7][13] = 459; // AS to HO


    adjacencyMatrix[8][0]  = 706;  // GA to AA
    adjacencyMatrix[8][1]  = 482;  // GA to BD
    adjacencyMatrix[8][2]  = 1283; // GA to SM
    adjacencyMatrix[8][3]  = 791;  // GA to MK
    adjacencyMatrix[8][4]  = 814;  // GA to DD
    adjacencyMatrix[8][5]  = 476;  // GA to HW
    adjacencyMatrix[8][6]  = 567;  // GA to AD
    adjacencyMatrix[8][7]  = 209;  // GA to AS
    adjacencyMatrix[8][9]  = 836;  // GA to HA
    adjacencyMatrix[8][10] = 911;  // GA to JIG
    adjacencyMatrix[8][11] = 211;  // GA to BO
    adjacencyMatrix[8][12] = 709;  // GA to WO
    adjacencyMatrix[8][13] = 369;  // GA to HO

    adjacencyMatrix[9][0]  = 515;  // HR to AA
    adjacencyMatrix[9][1]  = 606;  // HR to BD
    adjacencyMatrix[9][2]  = 536;  // HR to SM
    adjacencyMatrix[9][3]  = 547;  // HR to MK
    adjacencyMatrix[9][4]  = 51;   // HR to DD
    adjacencyMatrix[9][5]  = 555;  // HR to HW
    adjacencyMatrix[9][6]  = 489;  // HR to AD
    adjacencyMatrix[9][7]  = 835;  // HR to AS
    adjacencyMatrix[9][8]  = 836;  // HR to GA
    adjacencyMatrix[9][10] = 103;  // HR to JIG
    adjacencyMatrix[9][11] = 689;  // HR to BO
    adjacencyMatrix[9][12] = 552;  // HR to WO
    adjacencyMatrix[9][13] = 522;  // HR to HO

    adjacencyMatrix[10][0]  = 618;  // JIG to AA
    adjacencyMatrix[10][1]  = 642;  // JIG to BD
    adjacencyMatrix[10][2]  = 334;  // JIG to SM
    adjacencyMatrix[10][3]  = 590;  // JIG to MK
    adjacencyMatrix[10][4]  = 105;  // JIG to DD
    adjacencyMatrix[10][5]  = 569;  // JIG to HW
    adjacencyMatrix[10][6]  = 530;  // JIG to AD
    adjacencyMatrix[10][7]  = 909;  // JIG to AS
    adjacencyMatrix[10][8]  = 911;  // JIG to GA
    adjacencyMatrix[10][9]  = 103;  // JIG to HA
    adjacencyMatrix[10][11] = 759;  // JIG to BO
    adjacencyMatrix[10][12] = 620;  // JIG to WO
    adjacencyMatrix[10][13] = 580;  // JIG to HO

    adjacencyMatrix[11][0]  = 908;  // BG to AA
    adjacencyMatrix[11][1]  = 993;  // BG to BD
    adjacencyMatrix[11][2]  = 718;  // BG to SM
    adjacencyMatrix[11][3]  = 773;  // BG to MK
    adjacencyMatrix[11][4]  = 669;  // BG to DD
    adjacencyMatrix[11][5]  = 249;  // BG to HW
    adjacencyMatrix[11][6]  = 533;  // BG to AD
    adjacencyMatrix[11][7]  = 360;  // BG to AS
    adjacencyMatrix[11][8]  = 211;  // BG to GA
    adjacencyMatrix[11][9]  = 686;  // BG to HA
    adjacencyMatrix[11][10] = 759;  // BG to JIG
    adjacencyMatrix[11][12] = 279;  // BG to WO
    adjacencyMatrix[11][13] = 168;  // BG to HO

    adjacencyMatrix[12][0]  = 312;  // WO to AA
    adjacencyMatrix[12][1]  = 525;  // WO to BD
    adjacencyMatrix[12][2]  = 702;  // WO to SM
    adjacencyMatrix[12][3]  = 1181; // WO to MK
    adjacencyMatrix[12][4]  = 549;  // WO to DD
    adjacencyMatrix[12][5]  = 82;   // WO to HW
    adjacencyMatrix[12][6]  = 326;  // WO to AD
    adjacencyMatrix[12][7]  = 502;  // WO to AS
    adjacencyMatrix[12][8]  = 709;  // WO to GA
    adjacencyMatrix[12][9]  = 552;  // WO to HA
    adjacencyMatrix[12][10] = 620;  // WO to JIG
    adjacencyMatrix[12][11] = 279;  // WO to BG
    adjacencyMatrix[12][13] = 70;   // WO to HO


    adjacencyMatrix[13][0]  = 231;  // HO to AA
    adjacencyMatrix[13][1]  = 450;  // HO to BD
    adjacencyMatrix[13][2]  = 583;  // HO to SM
    adjacencyMatrix[13][3]  = 684;  // HO to MK
    adjacencyMatrix[13][4]  = 496;  // HO to DD
    adjacencyMatrix[13][5]  = 87;   // HO to HW
    adjacencyMatrix[13][6]  = 240;  // HO to AD
    adjacencyMatrix[13][7]  = 459;  // HO to AS
    adjacencyMatrix[13][8]  = 369;  // HO to GA
    adjacencyMatrix[13][9]  = 522;  // HO to HA
    adjacencyMatrix[13][10] = 580;  // HO to JIG
    adjacencyMatrix[13][11] = 168;  // HO to BG
    adjacencyMatrix[13][12] = 70;   // HO to WO

  printAdjacencyMatrix(adjacencyMatrix, cityNames);

    set<int> enteredCities;
   int startCity;

    while (true) {
        cout << endl << "Enter the starting city index (0: Addis Ababa, 1: Bahir Dar, 2: Semera, 3: Mekelle, 4: Dire Dawa, 5: Hawassa, 6: Adama, 7: Asossa, 8: Gambella, 9: Harar, 10: Jijiga, 11: Bonga, 12: Woliata, 13: Hossana, -1: exit): ";
        cin >> startCity;

        if (startCity == -1) {
            break;
 }

        if (enteredCities.count(startCity)) {
            cout << "You have already entered this city index. Please enter a different index." << endl;
            continue;
        }

        if (startCity < 0 || startCity >= NUM_CITIES) {
            cout << "Invalid city index. Please try again." << endl;
            continue;
}

        enteredCities.insert(startCity);
       dijkstra(adjacencyMatrix, startCity, cityNames);
    }
return 0;
}


