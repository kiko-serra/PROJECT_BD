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
#define MAX_PLAYERS 200
#define MAX_WEBSITES 10
#define MAX_TOURNAMENTS 10
#define MAX_MATCHS 200
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
    FILE *dest, *address, *phoneNumber, *names, *links, *emails, *nicknames;
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

    dest = fopen(DEST, "w");

    if (dest == NULL)
    {
        printf("Error!");
        return 1;
    }

    choose_random_unique_number(uniqueId);
    randomize(uniqueId, M);

    char buff[256], buff2[256], title[50];
    int aux, players[MAX_PLAYERS], winners[MAX_MATCHS];

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
            strcpy(title, "Grandmaster (GM)");
        }
        else if (aux > 2300)
        {
            strcpy(title, "International Master (IM)");
        }
        else if (aux > 2200)
        {
            strcpy(title, "FIDE Master (FM)");
        }
        else if (aux > 2000)
        {
            strcpy(title, "Candidate Master (CM)");
        }
        else
        {
            strcpy(title, "NULL");
        }
        fprintf(dest, "INSERT INTO Account VALUES (%d,\"%s\",\"%s\",\"%s\",%d,%s);\n",
                uniqueId[i + MAX_PLAYERS + MAX_WEBSITES], buff, buff2, title, aux, "NULL");
    }

    // TABELA TOURNAMENT
    fprintf(dest, "\n\n\n------------------------------------------------------TABLE TOURNAMENT-------------------------------------------------------\n\n");
    for (int i = 0; i < MAX_TOURNAMENTS; i++)
    {
        char *dateAux = choose_random_word(MATCH_DATE, rand() % 1000);
        fprintf(dest, "INSERT INTO Tournament VALUES (%d,'%s','%s',\"%s\",%s,%s);\n",
                uniqueId[i + MAX_PLAYERS + MAX_WEBSITES + MAX_ACCOUNTS], dateAux, dateAux,
                strcat(choose_random_word(NAMES, rand() % 1000), " Tournament"), "NULL", "NULL");
    }

    // TABELA MATCH
    fprintf(dest, "\n\n\n------------------------------------------------------TABLE MATCH-------------------------------------------------------\n\n");
    for (int i = 0; i < MAX_MATCHS; i++)
    {
        aux = rand() % 200;
        fprintf(dest, "INSERT INTO Match VALUES (%d,%d,\"%s\",'%s','%s','%s',%d,%d,%s,%s);\n",
                uniqueId[i + MAX_PLAYERS], players[aux], choose_random_word(SURNAMES, rand() % 1000), choose_random_word(MATCH_DATE, rand() % 1000), choose_random_word(MATCH_DURATION, rand() % 12), choose_random_word(MATCH_DURATION, rand() % 12),
                rand() % 30, rand() % 120 + 10, "NULL", "NULL");
        winners[i] = aux;
    }

    fprintf(dest, "\nCOMMIT TRANSACTION;\nPRAGMA foreign_keys = on;");
    fclose(address);
    fclose(phoneNumber);
    fclose(dest);

    return 0;
}