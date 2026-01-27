# ============================================================
# MQ101 — Métodos Quantitativos para Políticas Públicas
# Lista de Exercícios #01 — TEMPLATE DE SCRIPT (R)
# ------------------------------------------------------------
# Preencha os campos abaixo antes de começar.
# Nome: ______________________________________
# Matrícula/RA: ______________________________
# Turma: _____________________________________
# Data: __/__/____
# Descrição: Respostas da Lista #01 (HOPR Partes I–II, caps. 1–8)
# ============================================================

# ======================== ORIENTAÇÕES ========================
# 1) Este script é o MODELO para a sua entrega (.R).
# 2) Execute o script de cima para baixo (Ctrl/Cmd + Shift + Enter no RStudio)
#    ou use o botão "Source".
# 3) Onde estiver escrito TODO ou ENTREGA, substitua pelos seus códigos e respostas.
# 4) Use comentários explicativos: diga o que o código faz e por que isso é útil.
# 5) Use set.seed() quando fizer simulações para garantir reprodutibilidade.
# 6) Gere também um PDF com os resultados e interpretações (via Rmd ou outro).
# 7) Não utilize pacotes além de 'ggplot2' (opcional). Prefira base R.
# ============================================================

# ===================== 0) PREPARAÇÃO =========================
# (Obrigatório, sem pontuação — verificação do ambiente)

# Versão do R
R.version.string

# Se estiver no RStudio, esta chamada retorna informações do RStudio (pode falhar fora do RStudio).
# tryCatch(RStudio.Version()$mode, error = function(e) "RStudio não detectado")

# Reprodutibilidade global para esta lista (você pode mudar, mas mantenha constante)
set.seed(202501)

# Carregamento opcional do ggplot2 (apenas se desejar usar ggplot para gráficos)
if (requireNamespace("ggplot2", quietly = TRUE)) {
  library(ggplot2)
} else {
  message("Pacote 'ggplot2' não encontrado. Usando gráficos base R (hist).")
}

# Dica: escolha uma pasta de trabalho, se necessário (descomente e ajuste):
# setwd(\"~/caminho/para/sua/pasta\")

# ============================================================
# ===================== EXERCÍCIO 1 (10 pts) =================
# R como calculadora — ordem das operações (HOPR cap. 1)
# Objetivo: executar expressões e entender a ordem das operações.
# ENTREGA: cole os resultados no PDF e escreva, em 3–5 linhas, como os parênteses afetam o resultado.

# TODO: Execute as linhas a seguir e observe os resultados.
10 + 2
(10 + 2) * 3
((10 + 2) * 3 - 6) / 3

# ============================================================
# ===================== EXERCÍCIO 2 (10 pts) =================
# Objetos e nomeação (HOPR cap. 1)
# ENTREGA: explique em 2–4 linhas a diferença entre 'Name' e 'name'.

# TODO: Execute e observe os resultados. R diferencia maiúsculas/minúsculas.
x <- 1:6
Name <- 1
name <- 0
Name + 1
name + 1

# ============================================================
# ===================== EXERCÍCIO 3 (10 pts) =================
# Sorteio (sample) e reprodutibilidade (HOPR cap. 1–2)
# ENTREGA: descreva o papel de set.seed() em 3–5 linhas.

# TODO: Compare com e sem set.seed()
set.seed(123)
die <- 1:6
sample(die, size = 2, replace = TRUE)

# (Teste: reexecute as linhas acima e verifique se o resultado se repete)
# (Agora remova ou mude o set.seed e compare)

# ============================================================
# ===================== EXERCÍCIO 4 (10 pts) =================
# Sua primeira função (HOPR cap. 1)
# ENTREGA: explique o que faz cada linha da função em 4–6 linhas.
# BÔNUS: implemente 'soma3()' (sorteia 3 números entre 1 e 6 e retorna a soma).

# TODO: Defina a função e teste:
roll2 <- function(bones = 1:6) {
  # Sorteia dois valores do vetor 'bones' com reposição e soma.
  # 'bones' por padrão é 1:6 (um dado comum).
  dice <- sample(bones, size = 2, replace = TRUE)
  sum(dice)
}

# Testes sugeridos:
roll2()
roll2(1:20)

# TODO (BÔNUS): implementar soma3()
# soma3 <- function() {
#   # sua implementação aqui
# }

# ============================================================
# ===================== EXERCÍCIO 5 (10 pts) =================
# Ajuda e exemplos (HOPR cap. 2)
# ENTREGA: resuma argumentos de sample() e como consultar ajuda (4–6 linhas).

# TODO: Consulte a ajuda e rode exemplos
# ?sample
# example(sample)

# Dica: leia os argumentos 'x', 'size', 'replace', 'prob', etc.

# ============================================================
# ===================== EXERCÍCIO 6 (15 pts) =================
# Simulação e histograma (HOPR cap. 1–2)
# ENTREGA: histograma, média, desvio-padrão; interpretação (4–6 linhas).
# Dica: você pode salvar o gráfico com png()... dev.off()

set.seed(42)
somas <- replicate(10000, roll2())
length(somas)
hist(somas, main = \"Soma de dois dados (10.000 lançamentos)\", xlab = \"Soma\")

mean(somas); sd(somas)

# (Opcional) Salvar figura:
# png(\"ex6_hist_somas.png\", width = 900, height = 600)
# hist(somas, main = \"Soma de dois dados (10.000 lançamentos)\", xlab = \"Soma\")
# dev.off()

# Extensão (opcional, sem pontos extras): dado viciado favorecendo o 6
prob_vies <- c(rep(1/8, 5), 3/8)
somas_vies <- replicate(10000, sum(sample(1:6, size = 2, replace = TRUE, prob = prob_vies)))
# hist(somas_vies, main = \"Dado viciado (6 favorecido)\", xlab = \"Soma\")

# ============================================================
# ===================== EXERCÍCIO 7 (10 pts) =================
# Tipos básicos (HOPR cap. 3)
# ENTREGA: explique o que 'str()' revela sobre cada tipo e cite um uso prático.

dbl <- c(1.5, 2.0)            # numéricos (double)
int <- c(1L, 2L)              # inteiros
chr <- c(\"saude\", \"educacao\") # texto
lgl <- c(TRUE, FALSE)         # lógico

str(list(dbl = dbl, int = int, chr = chr, lgl = lgl))

# ============================================================
# ===================== EXERCÍCIO 8 (10 pts) =================
# Data.frame (baralho) e mini-base municipal (HOPR cap. 3)
# ENTREGA: nº de linhas/colunas e breve interpretação do summary().

# Baralho
faces <- c(\"ace\",\"two\",\"three\",\"four\",\"five\",\"six\",\"seven\",
           \"eight\",\"nine\",\"ten\",\"jack\",\"queen\",\"king\")
suits <- c(\"spades\",\"hearts\",\"diamonds\",\"clubs\")
deck  <- data.frame(
  face  = rep(faces, times = 4),
  suit  = rep(suits, each = 13),
  value = rep(1:13, times = 4)
)
nrow(deck); ncol(deck)
head(deck, 10)

# Mini-base municipal (dados simulados)
set.seed(2025)
municipios <- paste0(\"Mun_\", sprintf(\"%02d\", 1:10))
dados_munic <- data.frame(
  municipio        = municipios,
  gasto_saude_pc   = round(runif(10, 200, 1200), 2),
  taxa_evasao      = round(runif(10, 0.00, 0.20), 3),
  taxa_desemprego  = round(rnorm(10, 0.12, 0.03), 3)
)
head(dados_munic); summary(dados_munic)

# ============================================================
# ===================== EXERCÍCIO 9 (10 pts) =================
# Seleção e filtros (HOPR cap. 4)
# ENTREGA: descreva os retornos e quantos municípios têm taxa_evasao > 0.10.

deck[1, ]
deck[c(1,3,5), c(\"face\",\"suit\")]
deck[-(1:48), ]

subset_hearts <- deck[ deck$suit == \"hearts\", ]
nrow(subset_hearts)

evaz_alta <- dados_munic[ dados_munic$taxa_evasao > 0.10, ]
evaz_alta
nrow(evaz_alta)

# ============================================================
# ===================== EXERCÍCIO 10 (10 pts) ================
# Modificando valores e NA (HOPR cap. 5)
# ENTREGA: explique o efeito de na.rm = TRUE e quando usá-lo.

# Modificando valores (ases = 14)
deck2 <- deck
deck2$value[c(13, 26, 39, 52)] <- 14
head(deck2, 13)

# Valores ausentes
vals <- c(NA, 1:5)
mean(vals)                 # retorna NA
mean(vals, na.rm = TRUE)   # ignora NA

dados_m2 <- dados_munic
dados_m2$taxa_evasao[3] <- NA
dados_m2$gasto_saude_pc[7] <- NA

mean(dados_m2$taxa_evasao)             # NA
mean(dados_m2$taxa_evasao, na.rm=TRUE) # média sem NA

# ============================================================
# ========== EXERCÍCIO 11 (OPCIONAL, até 10 pts) ============
# Funções que \"guardam estado\" (HOPR cap. 6)
# ENTREGA: explique o conceito e dê exemplo análogo em PP/CS.

setup <- function(deck_init) {
  DECK <- deck_init  # cópia interna (estado)

  DEAL <- function() {
    # Devolve a primeira carta e atualiza o baralho interno removendo-a.
    card <- DECK[1, , drop = FALSE]
    DECK <<- DECK[-1, , drop = FALSE]
    return(card)
  }

  SHUFFLE <- function() {
    # Reembaralha o baralho interno
    idx <- sample(seq_len(nrow(deck_init)), size = nrow(deck_init))
    DECK <<- deck_init[idx, , drop = FALSE]
    invisible(NULL)
  }

  list(deal = DEAL, shuffle = SHUFFLE)
}

cards <- setup(deck)
cards$deal(); cards$deal(); cards$shuffle(); cards$deal()

# ============================================================
# ================= EXERCÍCIO 12 (15 pts) ====================
# Mini-projeto integrador: Saúde
# ENTREGA: 2 histogramas, diferença de médias e interpretação (6–8 linhas).

set.seed(123)
pressao_saude <- function() {
  demanda <- sample(1:6, 1, TRUE)
  equipe  <- sample(1:6, 1, TRUE)
  insumos <- sample(1:6, 1, TRUE)
  demanda + equipe + insumos
}
prs <- replicate(10000, pressao_saude())
hist(prs, main = \"Pressão no sistema de saúde (simulada)\", xlab = \"Índice\")
mean(prs); sd(prs)

# Viés em demanda (favorece 6)
prob_demanda <- c(rep(1/8, 5), 3/8)
pressao_vies <- function() {
  demanda <- sample(1:6, 1, TRUE, prob = prob_demanda)
  equipe  <- sample(1:6, 1, TRUE)
  insumos <- sample(1:6, 1, TRUE)
  demanda + equipe + insumos
}
prs_bias <- replicate(10000, pressao_vies())
hist(prs_bias, main = \"Pressão no sistema de saúde (com viés)\", xlab = \"Índice\")
mean(prs_bias) - mean(prs)

# (Opcional) Salvar figuras:
# png(\"ex12_hist_semvies.png\", width = 900, height = 600); hist(prs); dev.off()
# png(\"ex12_hist_comvies.png\", width = 900, height = 600); hist(prs_bias); dev.off()

# ============================================================
# ================== ENCERRAMENTO / CHECKLIST ================
# - O script roda do início ao fim sem erros?
# - Há comentários explicando seus passos e interpretações no PDF?
# - Você usou set.seed() nas simulações?
# - Nomeou os arquivos conforme instruções do professor?

# Informações da sessão (útil para reprodutibilidade)
sessionInfo()
# ====================== FIM DO SCRIPT =======================
