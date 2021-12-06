#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

#define DEST "../povoar.sql"
#define ADDRESS "address.txt"
#define PHONE "phoneNumbers.txt"
#define NAMES "names.txt"
#define SURNAMES "surnames.txt"
#define BIRTHDAYS "birthdays.txt"
#define MATCH_DATE "matchDate.txt"
#define MATCH_DURATION "durationGame.txt"
#define WEBSITES_LINKS "websiteLinks.txt"
#define WEBSITES_NAMES "websiteNames.txt"
#define WEBSITES_EMAILS "emails.txt"
#define WEBSITES_NICKNAMES "nicknames.txt"
#define SPONSOR_NAMES "sponsors.txt"
#define SPONSOR_PHONE "sponsorPhone.txt"
#define SPONSOR_EMAILS "sponsorEmails.txt"
#define SPONSOR_ADDRESS "sponsorAddress.txt"
#define MAX_PLAYERS 200
#define MAX_WEBSITES 10
#define MAX_TOURNAMENTS 10
#define MAX_MATCHS 200
#define MAX_SPONSORS 500
#define MAX_ACCOUNTS 419
#define M 10000
#define N 100000

void swap(int *a, int *b)
{
    int temp = *a;
    *a = *b;
    *b = temp;
}

void randomize(int arr[], int n)
{
    srand(time(NULL));

    for (int i = n - 1; i > 0; i--)
    {
        int j = rand() % (i + 1);
        swap(&arr[i], &arr[j]);
    }
}

void choose_random_unique_number(int *v)
{
    int in, im;

    im = 0;

    for (in = 0; in < N && im < M; ++in)
    {
        int rn = N - in;
        int rm = M - im;
        if (rand() % rn < rm)
            v[im++] = in;
    }

    if (im != M)
    {
        printf("Occorreu um erro no unique number");
    }
}

char *choose_random_word(const char *filename, const int numRand)
{
    FILE *f;
    size_t lineno = 0;
    size_t selectlen;
    char selected[256];
    char current[256];
    selected[0] = '\0';

    if ((f = fopen(filename, "r")) == NULL)
    {
        printf("Error opening file! :(\n");
        return NULL;
    }

    while (fgets(current, sizeof(current), f))
    {
        if (numRand == lineno)
        {
            strcpy(selected, current);
        }
        lineno++;
    }
    fclose(f);

    selectlen = strlen(selected);
    if (selectlen > 0 && selected[selectlen - 1] == '\n')
    {
        selected[selectlen - 1] = '\0';
    }

    return strdup(selected);
}

int main()
{
    FILE *dest, *address, *phoneNumber, *names, *links, *emails, *nicknames, *sponsors, *sponsorsEmails, *sponsorsAddress, *sponsorsPhone;
    int uniqueId[M];

    srand(time(0));

    if ((address = fopen(ADDRESS, "r")) == NULL)
    {
        printf("Error opening file! :(\n");
        return 1;
    }

    if ((phoneNumber = fopen(PHONE, "r")) == NULL)
    {
        printf("Error opening file! :(\n");
        return 1;
    }

    if ((names = fopen(WEBSITES_NAMES, "r")) == NULL)
    {
        printf("Error opening file! :(\n");
        return 1;
    }

    if ((links = fopen(WEBSITES_LINKS, "r")) == NULL)
    {
        printf("Error opening file! :(\n");
        return 1;
    }

    if ((nicknames = fopen(WEBSITES_NICKNAMES, "r")) == NULL)
    {
        printf("Error opening file! :(\n");
        return 1;
    }

    if ((emails = fopen(WEBSITES_EMAILS, "r")) == NULL)
    {
        printf("Error opening file! :(\n");
        return 1;
    }

    if ((sponsors = fopen(SPONSOR_NAMES, "r")) == NULL)
    {
        printf("Error opening file! :(\n");
        return 1;
    }

    if ((sponsorsEmails = fopen(SPONSOR_EMAILS, "r")) == NULL)
    {
        printf("Error opening file! :(\n");
        return 1;
    }

    if ((sponsorsAddress = fopen(SPONSOR_ADDRESS, "r")) == NULL)
    {
        printf("Error opening file! :(\n");
        return 1;
    }

    if ((sponsorsPhone = fopen(SPONSOR_PHONE, "r")) == NULL)
    {
        printf("Error opening file! :(\n");
        return 1;
    }

    dest = fopen(DEST, "w");

    if (dest == NULL)
    {
        printf("Error!");
        return 1;
    }

    choose_random_unique_number(uniqueId);
    randomize(uniqueId, M);

    char buff[256], buff2[256], buff3[256], buff4[256];
    int aux, aux2 = 0, aux3 = 0, players[MAX_PLAYERS], winners[MAX_MATCHS], tournaments[MAX_TOURNAMENTS], websites[MAX_WEBSITES],
             accounts[MAX_ACCOUNTS], matches[MAX_MATCHS], sponsor[MAX_SPONSORS];

    // TABELA PLAYER
    fprintf(dest, "PRAGMA foreign_keys = on;\nBEGIN TRANSACTION;\n\n------------------------------------------------------TABLE PLAYER-------------------------------------------------------\n\n");
    for (int i = 0; i < MAX_PLAYERS; i++)
    {
        fgets(buff, 255, (FILE *)address);
        buff[strlen(buff) - 1] = '\0';
        fgets(buff2, 16, (FILE *)phoneNumber);
        buff2[strlen(buff2) - 1] = '\0';
        fprintf(dest, "INSERT INTO Player VALUES (%d,\"%s\",\"%s\",\"%s\",\"%s\",'%s');\n",
                uniqueId[i], choose_random_word(NAMES, rand() % 1000), choose_random_word(SURNAMES, rand() % 1000), buff, buff2,
                choose_random_word(BIRTHDAYS, rand() % 1000));
        players[i] = uniqueId[i];
    }

    // TABELA FIDE_RANKING
    fprintf(dest, "\n\n\n------------------------------------------------------TABLE FIDE_RANKING-------------------------------------------------------\n\n");
    for (int i = 0; i < MAX_PLAYERS; i++)
    {
        aux2 = rand() % 4;
        switch (aux2)
        {
        case 0:
            strcpy(buff, "MEN");
            break;
        case 1:
            strcpy(buff, "WOMEN");
            break;
        case 2:
            strcpy(buff, "JUNIORS");
            break;
        case 3:
            strcpy(buff, "GIRLS");
            break;
        }

        aux = rand() % 3000;
        if (aux > 2400)
        {
            fprintf(dest, "INSERT INTO FideRanking VALUES (%d,\"%s\",\"%s\",%d);\n",
                    players[i], buff, "Grandmaster (GM)", aux);
        }
        else if (aux > 2300)
        {
            fprintf(dest, "INSERT INTO FideRanking VALUES (%d,\"%s\",\"%s\",%d);\n",
                    players[i], buff, "International Master (IM)", aux);
        }
        else if (aux > 2200)
        {
            fprintf(dest, "INSERT INTO FideRanking VALUES (%d,\"%s\",\"%s\",%d);\n",
                    players[i], buff, "FIDE Master (FM)", aux);
        }
        else if (aux > 2000)
        {
            fprintf(dest, "INSERT INTO FideRanking VALUES (%d,\"%s\",\"%s\",%d);\n",
                    players[i], buff, "Candidate Master (CM)", aux);
        }
        else
        {
            fprintf(dest, "INSERT INTO FideRanking VALUES (%d,\"%s\",%s,%d);\n",
                    players[i], buff, "NULL", aux);
        }
    }

    // TABELA WEBSITE
    fprintf(dest, "\n\n\n------------------------------------------------------TABLE WEBSITE-------------------------------------------------------\n\n");
    for (int i = 0; i < MAX_WEBSITES; i++)
    {
        fgets(buff, 255, (FILE *)links);
        buff[strlen(buff) - 1] = '\0';
        fgets(buff2, 50, (FILE *)names);
        buff2[strlen(buff2) - 1] = '\0';
        fprintf(dest, "INSERT INTO Website VALUES (%d,\"%s\",\"%s\");\n",
                uniqueId[i + MAX_PLAYERS], buff, buff2);
        websites[i] = uniqueId[i + MAX_PLAYERS];
    }

    // TABELA ACCOUNT
    fprintf(dest, "\n\n\n------------------------------------------------------TABLE ACCOUNT-------------------------------------------------------\n\n");
    for (int i = 0; i < MAX_ACCOUNTS; i++)
    {
        fgets(buff, 30, (FILE *)nicknames);
        buff[strlen(buff) - 1] = '\0';
        fgets(buff2, 255, (FILE *)emails);
        buff2[strlen(buff2) - 1] = '\0';
        aux = rand() % 3000;
        if (aux > 2400)
        {
            fprintf(dest, "INSERT INTO Account VALUES (%d,\"%s\",\"%s\",\"%s\",%d,%d);\n",
                    uniqueId[i + MAX_PLAYERS + MAX_WEBSITES], buff, buff2, "Grandmaster (GM)", aux, websites[rand() % MAX_WEBSITES]);
        }
        else if (aux > 2300)
        {
            fprintf(dest, "INSERT INTO Account VALUES (%d,\"%s\",\"%s\",\"%s\",%d,%d);\n",
                    uniqueId[i + MAX_PLAYERS + MAX_WEBSITES], buff, buff2, "International Master (IM)", aux, websites[rand() % MAX_WEBSITES]);
        }
        else if (aux > 2200)
        {
            fprintf(dest, "INSERT INTO Account VALUES (%d,\"%s\",\"%s\",\"%s\",%d,%d);\n",
                    uniqueId[i + MAX_PLAYERS + MAX_WEBSITES], buff, buff2, "FIDE Master (FM)", aux, websites[rand() % MAX_WEBSITES]);
        }
        else if (aux > 2000)
        {
            fprintf(dest, "INSERT INTO Account VALUES (%d,\"%s\",\"%s\",\"%s\",%d,%d);\n",
                    uniqueId[i + MAX_PLAYERS + MAX_WEBSITES], buff, buff2, "Candidate Master (CM)", aux, websites[rand() % MAX_WEBSITES]);
        }
        else
        {
            fprintf(dest, "INSERT INTO Account VALUES (%d,\"%s\",\"%s\",%s,%d,%d);\n",
                    uniqueId[i + MAX_PLAYERS + MAX_WEBSITES], buff, buff2, "NULL", aux, websites[rand() % MAX_WEBSITES]);
        }

        accounts[i] = uniqueId[i + MAX_PLAYERS + MAX_WEBSITES];
    }

    // TABELA TOURNAMENT
    fprintf(dest, "\n\n\n------------------------------------------------------TABLE TOURNAMENT-------------------------------------------------------\n\n");
    for (int i = 0; i < MAX_TOURNAMENTS; i++)
    {
        char *dateAux = choose_random_word(MATCH_DATE, rand() % 1000);
        if (i == MAX_TOURNAMENTS - 1)
        {
            fprintf(dest, "INSERT INTO Tournament VALUES (%d,'%s','%s',\"%s\",%s,%d);\n",
                    uniqueId[i + MAX_PLAYERS + MAX_WEBSITES + MAX_ACCOUNTS], dateAux, dateAux,
                    strcat(choose_random_word(NAMES, rand() % 1000), " Tournament"), "NULL", websites[MAX_WEBSITES - 1]);
        }
        else
        {
            fprintf(dest, "INSERT INTO Tournament VALUES (%d,'%s','%s',\"%s\",%s,%s);\n",
                    uniqueId[i + MAX_PLAYERS + MAX_WEBSITES + MAX_ACCOUNTS], dateAux, dateAux,
                    strcat(choose_random_word(NAMES, rand() % 1000), " Tournament"), "NULL", "NULL");
        }
        tournaments[i] = uniqueId[i + MAX_PLAYERS + MAX_WEBSITES + MAX_ACCOUNTS];
    }

    // TABELA MATCH
    fprintf(dest, "\n\n\n------------------------------------------------------TABLE MATCH-------------------------------------------------------\n\n");
    for (int i = 0; i < MAX_MATCHS; i++)
    {
        aux = rand() % 200;
        if (aux2 < MAX_TOURNAMENTS - 1)
        {
            fprintf(dest, "INSERT INTO Match VALUES (%d,%d,\"%s\",'%s','%s','%s',%d,%d,%d,%s);\n",
                    uniqueId[i + MAX_PLAYERS + MAX_WEBSITES + MAX_ACCOUNTS + MAX_TOURNAMENTS], players[aux], choose_random_word(SURNAMES, rand() % 1000), choose_random_word(MATCH_DATE, rand() % 1000), choose_random_word(MATCH_DURATION, rand() % 12), choose_random_word(MATCH_DURATION, rand() % 12),
                    rand() % 30, rand() % 120 + 10, tournaments[aux2], "NULL");
            aux2++;
        }
        else if (aux3 < MAX_WEBSITES - 1)
        {
            fprintf(dest, "INSERT INTO Match VALUES (%d,%d,\"%s\",'%s','%s','%s',%d,%d,%s,%d);\n",
                    uniqueId[i + MAX_PLAYERS + MAX_WEBSITES + MAX_ACCOUNTS + MAX_TOURNAMENTS], players[aux], choose_random_word(SURNAMES, rand() % 1000), choose_random_word(MATCH_DATE, rand() % 1000), choose_random_word(MATCH_DURATION, rand() % 12), choose_random_word(MATCH_DURATION, rand() % 12),
                    rand() % 30, rand() % 120 + 10, "NULL", websites[aux3]);
            aux3++;
        }
        else if (aux2 == MAX_TOURNAMENTS - 1 && aux3 == MAX_WEBSITES - 1)
        {
            fprintf(dest, "INSERT INTO Match VALUES (%d,%d,\"%s\",'%s','%s','%s',%d,%d,%d,%d);\n",
                    uniqueId[i + MAX_PLAYERS + MAX_WEBSITES + MAX_ACCOUNTS + MAX_TOURNAMENTS], players[aux], choose_random_word(SURNAMES, rand() % 1000), choose_random_word(MATCH_DATE, rand() % 1000), choose_random_word(MATCH_DURATION, rand() % 12), choose_random_word(MATCH_DURATION, rand() % 12),
                    rand() % 30, rand() % 120 + 10, tournaments[aux2], websites[aux3]);
            aux3++;
            aux2++;
        }
        else
        {
            fprintf(dest, "INSERT INTO Match VALUES (%d,%d,\"%s\",'%s','%s','%s',%d,%d,%s,%s);\n",
                    uniqueId[i + MAX_PLAYERS + MAX_WEBSITES + MAX_ACCOUNTS + MAX_TOURNAMENTS], players[aux], choose_random_word(SURNAMES, rand() % 1000), choose_random_word(MATCH_DATE, rand() % 1000), choose_random_word(MATCH_DURATION, rand() % 12), choose_random_word(MATCH_DURATION, rand() % 12),
                    rand() % 30, rand() % 120 + 10, "NULL", "NULL");
        }

        matches[i] = uniqueId[i + MAX_PLAYERS + MAX_WEBSITES + MAX_ACCOUNTS + MAX_TOURNAMENTS];
        winners[i] = aux;
    }

    // TABELA SPONSOR
    fprintf(dest, "\n\n\n------------------------------------------------------TABLE SPONSOR-------------------------------------------------------\n\n");
    for (int i = 0; i < MAX_SPONSORS; i++)
    {
        fgets(buff, 255, (FILE *)sponsors);
        buff[strlen(buff) - 1] = '\0';
        fgets(buff2, 16, (FILE *)sponsorsPhone);
        buff2[strlen(buff2) - 1] = '\0';
        fgets(buff3, 255, (FILE *)sponsorsEmails);
        buff3[strlen(buff3) - 1] = '\0';
        fgets(buff4, 255, (FILE *)sponsorsAddress);
        buff4[strlen(buff4) - 1] = '\0';
        fprintf(dest, "INSERT INTO Sponsor VALUES (%d,\"%s\",\"%s\",\"%s\",\"%s\");\n",
                uniqueId[i + MAX_PLAYERS + MAX_WEBSITES + MAX_ACCOUNTS + MAX_TOURNAMENTS + MAX_MATCHS],
                buff, buff2, buff3, buff4);
        sponsor[i] = uniqueId[i + MAX_PLAYERS + MAX_WEBSITES + MAX_ACCOUNTS + MAX_TOURNAMENTS + MAX_MATCHS];
    }

    // TABELA PLAYER_SPONSOR
    fprintf(dest, "\n\n\n------------------------------------------------------TABLE PLAYER_SPONSOR-------------------------------------------------------\n\n");
    aux2 = 0;
    aux3 = 0;
    for (int i = 0; i < MAX_SPONSORS; i++)
    {
        aux = rand() % 3;
        switch (aux)
        {
        case 0:
            fprintf(dest, "INSERT INTO PlayerSponsor VALUES (%d,%d);\n",
                    players[aux2], sponsor[i]);
            break;
        case 1:
            fprintf(dest, "INSERT INTO PlayerSponsor VALUES (%d,%d);\n",
                    players[aux2], sponsor[i]);
            aux2++;
            if (aux2 >= MAX_PLAYERS)
            {
                aux3 = 1;
                break;
            }
            fprintf(dest, "INSERT INTO PlayerSponsor VALUES (%d,%d);\n",
                    players[aux2], sponsor[i]);
            break;
        case 2:
            fprintf(dest, "INSERT INTO PlayerSponsor VALUES (%d,%d);\n",
                    players[aux2], sponsor[i]);
            aux2++;
            if (aux2 >= MAX_PLAYERS)
            {
                aux3 = 1;
                break;
            }
            fprintf(dest, "INSERT INTO PlayerSponsor VALUES (%d,%d);\n",
                    players[aux2], sponsor[i]);
            aux2++;
            if (aux2 >= MAX_PLAYERS)
            {
                aux3 = 1;
                break;
            }
            fprintf(dest, "INSERT INTO PlayerSponsor VALUES (%d,%d);\n",
                    players[aux2], sponsor[i]);
            break;
        }
        if (aux3 == 1)
        {
            break;
        }
    }

    // TABELA PLAYER_ACCOUNT
    fprintf(dest, "\n\n\n------------------------------------------------------TABLE PLAYER_ACCOUNT-------------------------------------------------------\n\n");
    aux2 = 0;
    for (int i = 0; i < MAX_PLAYERS; i++)
    {
        aux = rand() % 3;
        switch (aux)
        {
        case 0:
            fprintf(dest, "INSERT INTO PlayerAccount VALUES (%d,%d);\n",
                    players[i], accounts[aux2]);
            break;
        case 1:
            fprintf(dest, "INSERT INTO PlayerAccount VALUES (%d,%d);\n",
                    players[i], accounts[aux2]);
            aux2++;
            fprintf(dest, "INSERT INTO PlayerAccount VALUES (%d,%d);\n",
                    players[i], accounts[aux2]);
            break;
        case 2:
            fprintf(dest, "INSERT INTO PlayerAccount VALUES (%d,%d);\n",
                    players[i], accounts[aux2]);
            aux2++;
            fprintf(dest, "INSERT INTO PlayerAccount VALUES (%d,%d);\n",
                    players[i], accounts[aux2]);
            aux2++;
            fprintf(dest, "INSERT INTO PlayerAccount VALUES (%d,%d);\n",
                    players[i], accounts[aux2]);
            break;
        }
    }

    // TABELA PLAYER_TOURNAMENT
    fprintf(dest, "\n\n\n------------------------------------------------------TABLE PLAYER_TOURNAMENT-------------------------------------------------------\n\n");
    aux2 = 0;
    int counter = 0;
    for (int i = 0; i < MAX_PLAYERS && aux2 < MAX_TOURNAMENTS; i++)
    {
        aux = rand() % 3;
        switch (aux)
        {
        case 0:
            fprintf(dest, "INSERT INTO PlayerTournament VALUES (%d,%d);\n",
                    players[i], tournaments[aux2]);
            counter++;
            break;
        case 1:
            break;
        case 2:
            break;
        }
        if (counter == 8)
        {
            counter = 0;
            aux2++;
        }
    }

    // TABELA PLAYER_MATCH
    fprintf(dest, "\n\n\n------------------------------------------------------TABLE PLAYER_MATCH-------------------------------------------------------\n\n");
    for (int i = 0; i < MAX_MATCHS; i++)
    {
        do
        {
            aux = rand() % MAX_PLAYERS;
            aux2 = rand() % MAX_PLAYERS;
        } while (aux == aux2);

        fprintf(dest, "INSERT INTO PlayerMatch VALUES (%d,%d);\n",
                players[aux], matches[i]);
        fprintf(dest, "INSERT INTO PlayerMatch VALUES (%d,%d);\n",
                players[aux2], matches[i]);
    }

    fprintf(dest, "COMMIT TRANSACTION;\nPRAGMA foreign_keys = on;");

    fclose(names);
    fclose(links);
    fclose(nicknames);
    fclose(emails);
    fclose(address);
    fclose(phoneNumber);
    fclose(dest);

    return 0;
}