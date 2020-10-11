%option noyywrap
%{
#include<stdio.h>
#include<string.h>

char pets[500], sports[500], food[500], fruits[500], vegetables[500];
char verbs[500];

char pets_db[][500] = {"dog", "cat", "pitbull", "terrier", "dalmatian", "tabby", "kitten", "puppy"};

char sports_db[][500] = {"cricket", "hockey", "tennis", "lacrosse", "rugby", "football", "badminton"};

char verbs_db[][500] = {"play","do","jump","eat","like","love","talk","go",
			"plays", "does", "jumps", "eats","likes","loves","talks","goes",
			"played","did","jumped","ate","liked","loved","talked","gone"
			"playing","doing","jumping","eating","liking","loving","talking","going"};

char fruits_db[][500] = {"mango","apple","kiwifruit","jackfruit","banana","watermelon","lychee","cherry","papaya","grapes","pear"};

char vegetables_db[][500] = {"cucumber","tomato","potato","pumpkin","lettuce","beetroot","carrot","yam","cabbage"};

char users[][500] = {};

int i, flag, user_count;
int temp_counter;

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

void AllocateToUser(char *str)
{
	i = 0;
	temp_counter = 1;

	printf("For %s: ",users[temp_counter]);

	while(str[i] != '\0')
	{
		if(str[i] == '-')
		{
			temp_counter++;
			printf("\nFor %s: ",users[temp_counter]);
			i++;
		}
		else if(str[i] == '$')
		{
			printf(" ");
			i++;
		}
		else
		{
			printf("%c",str[i]);
			i++;
		}
	}

	printf("\n");
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
			strcpy(users[user_count], yytext);
		}
		
	   }

[\n] {
	strcat(pets,"-$");
	strcat(sports,"-$");
	strcat(verbs,"-$");
	strcat(fruits,"-$");
	strcat(vegetables,"-$");

	user_count++;
     }

[\t ] ;

. ;

-1 return 0;
%%

int main()
{
FILE *ptr=fopen("input.txt","r");
yyin=ptr;

user_count = 1;

yylex();

printf("\nPets Registered: %s\n",pets);
printf("Sports Registered: %s\n",sports);
printf("Fruits Registered: %s\n",fruits);
printf("Vegetables Registered: %s\n",vegetables);
printf("Actions Registered: %s\n",verbs);

printf("\nNumber of Users: %d\n",user_count);

printf("\nPets allocated to Users: \n");
AllocateToUser(pets);
printf("\nSports allocated to Users: \n");
AllocateToUser(sports);
printf("\nFruits allocated to Users: \n");
AllocateToUser(fruits);
printf("\nVegetables allocated to Users: \n");
AllocateToUser(vegetables);
printf("\nActions allocated to Users: \n");
AllocateToUser(verbs);

return 0;

}
