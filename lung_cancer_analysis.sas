/* IMPORTAR O CSV */
proc import datafile="/home/u64397623/lung_cancer.csv" 
    out=work.meu_cancro       /* Nome que vamos dar ao dataset dentro do SAS */
    dbms=csv 
    replace;
    getnames=yes;             /* Usa a primeira linha como nomes das variáveis */
run;


/* Imprimir as primeiras 10 linhas */
proc print data=work.meu_cancro (obs=10);
run;

/* VERIFICAR O TIPO DE DADOS */
/* Confirmar se o 'status' e 'time' são números e não texto */
proc contents data=work.meu_cancro;
run;
/* ----------------------------------------------------------- */
/* ----------------------------------------------------------- */
proc lifetest data=work.meu_cancro plots=survival;
   time Time * Status(0); 
   strata Sex; 
run;

/* ----------------------------------------------------------- */
/* ----------------------------------------------------------- */
proc phreg data=work.meu_cancro;
   class Sex (ref='1');           /* Comparar contra Homens (1) */
   model Time * Status(0) = Sex/rl;  /* Equação do risco */
run;