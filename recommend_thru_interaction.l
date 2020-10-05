%option noyywrap
%{
#include<stdio.h>
#include<string.h>

char pets[500], sports[500], food[500], fruits[500], vegetables[500], misc[500];
char verbs[500];

char pets_db[][500] = {"dog", "dogs","cats","parrot","birds","crow","cat", "pitbull", "terrier", "dalmatian", "tabby", "kitten", "puppy"};

char sports_db[][500] = {"cricket", "hockey", "tennis", "lacrosse", "rugby", "football", "badminton","skipping"};

char verbs_db[][500] = {"play","do","jump","eat","like","love","talk","go",
                        "plays", "does", "jumps", "eats","likes","loves","talks","goes",
                        "played","did","jumped","ate","liked","loved","talked","gone"
                        "playing","doing","jumping","eating","liking","loving","talking","going"};

char fruits_db[][500] = {"mango","apple","kiwifruit","jackfruit","banana","watermelon","lychee","cherry","jackfruit","strawberry","papaya","grapes","pear"};

char vegetables_db[][500] = {"cucumber","tomato","potato","pumpkin","lettuce","beetroot","carrot","yam","cabbage","garlic","ginger","onion","peas","spinach"};

int i, flag;

void CompareAndAdd(char *str, char strarr[][500], int size)
{
        for(i = 0; i<size; i++)
        {
                if(strcasecmp(yytext, strarr[i]) == 0)
                {
                        strcat(str, yytext);
                        str[strlen(str)] = '$';
                        flag = 1;
                }
        }
}

%}

%%

"this"|"is"|"a"|"an"|"the"|"it"|"that"|"and"|"or"|"not"|"he"|"she"|"with"|"also"|"for"|"while"|"I"|"He"|"over"|"to" ;
[:.;,''""] ;

[a-zA-Z]+ {
                flag = 0;
				
                CompareAndAdd(pets, pets_db, sizeof(pets_db)/sizeof(pets_db[0]));
                CompareAndAdd(sports, sports_db, sizeof(sports_db)/sizeof(sports_db[0]));
                CompareAndAdd(verbs, verbs_db, sizeof(verbs_db)/sizeof(verbs_db[0]));
                CompareAndAdd(fruits, fruits_db, sizeof(fruits_db)/sizeof(fruits_db[0]));
                CompareAndAdd(vegetables, vegetables_db, sizeof(vegetables_db)/sizeof(vegetables_db[0]));

                if(flag == 0)
                {
                        strcat(misc, yytext);
                        misc[strlen(misc)] = '$';
                }

           }

[\n\t ] ;
. ;

-1 return 0;
%%

int main()
{
FILE *ptr=fopen("input.txt","r");
yyin=ptr;

yylex();

printf("\nPets Registered: %s\n",pets);
printf("Sports Registered: %s\n",sports);
printf("Fruits Registered: %s\n",fruits);
printf("Vegetables Registered: %s\n",vegetables);
printf("Actions Registered: %s\n",verbs);
printf("Miscellaneous(names and such): %s\n",misc);

return 0;
}