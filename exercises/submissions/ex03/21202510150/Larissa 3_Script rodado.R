# ============================================================
# MQ101 — Métodos Quantitativos para Políticas Públicas
# Lista de Exercícios #03 SCRIPT (R)
# ------------------------------------------------------------
# Preencha os campos abaixo antes de começar.
# Nome: Larissa Soares Vila Nova de Barros
# Matrícula/RA: 21202510150
# Turma: Métodos quantitativos 101
# Data: 05/11/2025
# Descrição: Respostas da Lista #03 


Lista 3# Preparacao do ambiente
install.packages(c("tidyverse","readr","ggplot2","scales","viridis","
electionsBR"))
set.seed(101)
library(tidyverse)

# (1) Aquecimento – Tabela vs. Gráfico (dados internos)

data(cars)
head(cars,10)

ggplot(cars, aes(speed, dist)) +
  geom_point(alpha = 0.6) +
  geom_smooth(method = "lm", se = TRUE, linewidth = 0.8) +
  labs(title = "Speed x distance", x = "Speed", y = "Distance") +
  theme_minimal()

#Quanto maior a distância, maior a velocidade 

# (2) Distribuições univariadas e grupos

data(mtcars)
mtcars <- mtcars |>
  mutate(cyl = as.factor(cyl)) #para convertir la variable "cyl" en variable
#categorica (factores)

#histograma densidades de mpg

library(ggplot2)

ggplot(mtcars, aes(x = mpg)) +
  geom_histogram(
    bins = 10,          # número de barras
    fill = "skyblue",   # color do preenchimento
    color = "black"     # color da borda
  ) +
  labs(
    title = "Histograma de consumo de combustivel",
    x = "Millas por galón (mpg)",
    y = "Frequencia"
  ) +
  theme_minimal()

#Isso indica que a maioria dos carros no conjunto de dados tem consumo moderado.

#boxplot de cyl

ggplot(mtcars, aes(x = cyl, y = mpg, fill = cyl)) +
  geom_boxplot(show.legend = TRUE, outlier.alpha = 0.4) +
  labs(
    title = "Consumo de combustivel por número de cilindros",
    x = "Número de cilindros",
    y = "MPG"  ) +
  theme_minimal()

#Quanto menor o número de cilindros, maior o consumo de combustível

# (3)  Série temporal simples
#Data Air Passenger/ crie gráfico(s) de linha/pontos e destaque tendência.

data("AirPassengers")

library(zoo)
library(tibble)

ap <- tibble(
  date = as.Date(time(AirPassengers)),
  n = as.numeric(AirPassengers),
  year = format(date, "%Y"),
  month = format(date, "%m")
  #month_name = format(date, "%b") # abreviatura mes ("Jan","Feb",...)
  #month_name = format(date, "%B") # nombre completo del mes
)

head(ap)

#grafico de lineas
ggplot(ap, aes(date, n)) +
  geom_line() +
  scale_x_date(date_breaks = "1 year", date_labels = "%Y") +
  labs(
    title ="Numero de pasajeros por ano",
    x="Ano",
    y="Frequencia")+
  theme_minimal()

#grafico de puntos
ggplot(ap, aes(date, n)) +
  geom_point(alpha=0.6) +
  labs(
    title ="Numero de pasajeros por ano",
    x="Ano",
    y="Frequencia")+
  scale_x_date(date_breaks = "1 year", date_labels = "%Y") +
  theme_minimal()

#Tendência a aumentar no decorrer do tempo

#4 Exercício

data(mtcars)

#Linha LM

ggplot(mtcars, aes(wt, mpg)) +
  geom_point(color = "steelblue", size = 2, alpha=0.6) +
  geom_smooth(method = "lm", se = TRUE, linewdth = 0.8, color="darkred") +
  labs(title = "Relação entre peso do carro e consumo de combustível",
       x = "Peso do carro (1000 lb)", y = "Milhas por galão (mpg)")+
    theme_minimal()
  
  
#Quanto mais pesado o carro, menos milhas por galão serão utilizadas

#LOESS

ggplot(mtcars, aes(wt, mpg)) +
  geom_point(color = "steelblue", size = 2, alpha=0.6) +
  geom_smooth(method = "loess", se = TRUE, linewdth = 0.8, color="darkred") +
  labs(title = "Relação entre peso do carro e consumo de combustível",
       x = "Peso do carro (1000 lb)", y = "Milhas por galão (mpg)")+
  theme_minimal()

#A linha suavizada se ajusta melhor aos dados 

#5 Exercício -  hp - mpg com fact_wrahp(~ am) e ajuste #lm por painel 

mtcars <- mtcars |>
   mutate(am = factor(am, labels = c("Automtico","Manual")))

ggplot(mtcars, aes(hp,mpg)) + 
  geom_point(color = "steelblue", size=2, alpha=0.5) +
  geom_smooth(method = "lm", se = TRUE, linewdth = 0.8, color="darkred") +
  facet_wrap(~am) + 
  labs(
    title = "Relação entre potência do motor e consumo do motor e consumo de combustível",
    subtitle = "Os carros automáticos tem menor desempenho que os manuais",
    x = "Potência do motor (hp)", y = "Milhas por galão (mpg)")
  )
#Os carros manuais tem melhor desempenho (mpg)
#que os automáticos para noticia semelhante

#6 Exercício 

n <- 1000; rhos <- c(0.2, 0.6, 0.9)

 sim <- purrr::map_dfr(rhos, \(rho) {
   x <- rnorm(n); e <- rnorm(n)
   y <- rho*x + sqrt(1 - rho^2)*e
   tibble(rho = rho, x = x, y = y)
   })
 
 ggplot(sim, aes(x = x, y = y)) +
   geom_point(alpha = 0.6, color = "steelblue") + #Pontos de dispersão
   geom_smooth(method = "lm", se = FALSE, color = "darkred") + #Linha de regressão
   facet_wrap(~ rho, scales = "free") + #Separar por rho
  labs(
    title = "Comparação de Dados simulados com diferentes correlações (rho)",
    x = "Variável X",
    y = "Variável Y" 
  ) + 
    theme_minimal()
 
#Quanto maior o valor de ρ, mais os pontos se alinham com a linha de regressão.
#A dispersão dos pontos diminui conforme a correlação aumenta.
#A previsibilidade de Y a partir de X melhora com correlações mais altas.
 
 

#7 Exercício Simulação II (grupos): duas distribuições com dias/variancias diferentes; 
#histogramas/densidades/boxplot/violin; interprete.
 
 n <- 1000
 df_grupos <- tibble(
   grupo = rep(c("A","B"), each = n),
   valor = c(rnorm(n, 0, 1), rnorm(n, 1, 1.8)))
   
#Histograma 

ggplot(df_grupos, aes(x = valor, fill = grupo)) + 
  geom_histogram(aes(y = after_stat(density)), 
                 binwidth = 0.4, alpha = 0.6, position = "identity") + 
  labs(
    title = "Comparação de Distribuições",
    x = "Valor",
    y = "Densidade",
   fill = "Grupo"  ) +
  theme_minimal()
 
#Densidade
ggplot(df_grupos, aes(x = valor, fill = grupo)) + 
  geom_density(aes(y = after_stat(density)), 
                 binwidth = 0.4, alpha = 0.6, position = "identity") + 
  labs(
    title = "Comparação de Distribuições",
    x = "Valor",
    y = "Densidade",
    fill = "Grupo"  ) +
  theme_minimal()
 
#Boxplot
ggplot(df_grupos, aes(x = grupo, y = valor, fill = grupo)) + 
  geom_boxplot(alpha = 0.7) + 
  labs(
    title = "Comparação de Distribuições",
    x = "Grupo",
    y = "Valor",
    fill = "Grupo"  ) +
  theme_minimal()
 
#Violin

ggplot(df_grupos, aes(x = grupo, y = valor, fill = grupo)) + 
  geom_violin(fill="lightblue",color="steelblue",alpha=1) + 
  #geom_boxplot(width=0.1,alpha = 0.7) +
  labs(
    title = "Comparação de Distribuições",
    x = "Grupo",
    y = "Valor",
    fill = "Grupo"  ) +
  theme_minimal()

# A mediana do grupo B é maior que a do grupo A 


#8 Exercício 

library(readr)
educ <- read.csv(file.choose()) 

#Histograma
ggplot(educ, aes(x = pressao_sistolica, fill = plano_saude)) + 
  geom_histogram(alpha = 0.2, position = "identity", bins = 30) +
  #geom_histogram(stat="count", alpha = 0.2) + 
  labs(
    title = "Comparação de Distribuições",
    x = "Valor",
    y = "Densidade",
    fill = "Grupo"  ) +
  theme_minimal()

#Distribuição da pressão sistólica entre os diferentes grupos de plano de saúde.
#Picos em diferentes faixas de pressão podem sugerir que certos grupos têm maior prevalência de pressão alta ou baixa.

#Barras
#falta escolar e Plano de Saúde

ggplot(educ, aes(x = rede_escolar, fill = plano_saude)) + 
  geom_histogram(stat="count", alpha = 0.2) + 
  labs(
    title = "Comparação de Distribuições",
    x = "Valor",
    y = "Densidade",
    fill = "Grupo"  ) +
  theme_minimal()

#Na distribução vê-se mais pessoas no SUS esturam es escola pública

#Densidade
ggplot(educ, aes(x = pressao_sistolica, fill = rede_escolar)) + 
  geom_density(aes(y = after_stat(density)), 
               binwidth = 0.4, alpha = 0.6, position = "identity") + 
  labs(
    title = "Comparação de Distribuições",
    x = "Valor",
    y = "Densidade",
    fill = "Rede escolar"  ) +
  theme_minimal()


# na Pública o pico da pressão é um pouco maior 

#Boxplot
ggplot(educ, aes(x = pressao_sistolica, fill = rede_escolar)) + 
  geom_boxplot(alpha = 0.7) +
  labs(
    title = "Comparação de Distribuições",
    x = "Grupo",
    y = "Valor",
    fill = "Rede escolar"  ) +
  theme_minimal()

#Com média

ggplot(educ, aes(x = rede_escolar, y = pressao_sistolica, fill = rede_escolar)) + 
  geom_boxplot(alpha = 0.7) +
  stat_summary(fun = mean, geom = "point", shape = 20, size = 3, color = "black") +
  labs(
    title = "Comparação de Distribuições",
    x = "Grupo",
    y = "Valor",
    fill = "Rede escolar"
  ) +
  theme_minimal()

#Pressão um pouco maior na pública, média e mediana quase iguais

#Dispeções
opção 1
ggplot(educ, aes(x = tempo_estudo_h, y = idade)) + 
  geom_point(color = "steelblue", size = 2, alpha = 0.6) + 
  geom_smooth(method = "lm", se = TRUE, linewidth = 0.8, color = "darkred") + 
  labs(
    title = "Tempo de estudo e Idade",
    x = "Tempo de estudo (horas)",
    y = "Idade"
  ) + 
  theme_minimal()
opção 2 

ggplot(educ, aes(x = idade, y = pressao_sistolica)) +
  geom_point( color = "darkgrey", size = 1.5,alpha = 0.5         
  ) +
  geom_smooth(method = "lm",color = "red", se = TRUE, linewidth = 1.2
  ) +
  labs(
    title = "Relação Geral entre Idade e Pressão Sistólica",
    x = "Idade (anos)",
    y = "Pressão Sistólica (mmHg)"
  ) +
  theme_minimal()

#Ao aumentar a idade, a pressão vai aumentando um pouco

#Facetas

ggplot(educ, aes(x = pressao_sistolica, fill = escolaridade)) + 
  geom_histogram(stat="count", alpha = 0.2) + 
  facet_wrap(~escolaridade)
  labs(
    title = "Comparação de Distribuições",
    x = "Valor",
    y = "Densidade",
    fill = "Grupo"  ) +
  theme_minimal()
  
#Facetas dividiram de acordo com o nível escolar
  
#9 Exercício
  
  ggplot(educ, aes(x = idade, y = pressao_sistolica)) +
    geom_point(color = "darkgrey", size = 1.5, alpha = 0.5) +
    geom_smooth(method = "lm", color = "red", se = TRUE, linewidth = 1.2) +
    scale_x_continuous(breaks = seq(0, 100, by = 10)) +
    scale_y_continuous(breaks = seq(80, 200, by = 20)) +
    labs(
      title = "Como a Idade se Relaciona com a Pressão Sistólica",
      subtitle = "Tendência crescente indica que pessoas mais velhas tendem a ter pressão mais alta",
      x = "Idade (anos)",
      y = "Pressão Sistólica (mmHg)",
      caption = "Fonte: educ_saude.csv — Cada ponto representa um indivíduo. Linha vermelha mostra tendência linear com intervalo de confiança."
    ) +
    theme_minimal(base_size = 13)
  
  #O gráfico mostra que há uma tendência positiva entre idade e pressão sistólica: conforme a idade aumenta, a pressão também tende a subir.
  #Isso é visualizado pela linha de regressão vermelha, que indica uma relação linear com intervalo de confiança. 
  #A dispersão dos pontos sugere variabilidade individual, mas o padrão geral é claro.

  