############################################################
# AULA: 10 sequências aleatórias (1000 nt)
# - ver não alinhadas
# - alinhar
# - salvar para usar no MEGA
############################################################

# Instalar (só uma vez, se necessário)
if (!requireNamespace("BiocManager", quietly = TRUE)) install.packages("BiocManager")
if (!requireNamespace("Biostrings", quietly = TRUE)) BiocManager::install("Biostrings")
if (!requireNamespace("msa", quietly = TRUE)) BiocManager::install("msa")

# Carregar pacotes
library(Biostrings)
library(msa)

# 1) Pasta de trabalho para a aula
# onde estou
getwd()

# criar a pasta
dir.create("sequencias_aula", showWarnings = FALSE)

# vamos entrar na pasta criada
setwd("sequencias_aula")      # <— tudo será salvo aqui

# 2) Gerar 10 sequências aleatórias (cada uma com 1000 nt)
set.seed(123)  # reprodutível

# Cria 10 DNAString e empacota em um DNAStringSet (sem função customizada)
lista_raw <- lapply(1:10, function(i) DNAString(paste(sample(c("A","T","G","C"), 1000, TRUE), collapse = "")))
seqs_1000 <- DNAStringSet(lista_raw)

#Explicando a funcao acima - lista_raw
#------------------------------------------------------------
#1:10: repete 10 vezes.
#lapply(..., function(i){...}): faz a mesma coisa 10 vezes e guarda numa lista.
#sample(c("A","T","G","C"), 1000, replace=TRUE): sorteia 1000 letras A/T/G/C.
#paste(..., collapse=""): junta em uma única sequência.
#DNAString(...): transforma em formato “sequência de DNA”.
#DNAStringSet(...): junta as 10 sequências num pacote só.

# Agora sim, dê nomes no DNAStringSet
names(seqs_1000) <- sprintf("seq_%02d", 1:10)

# Comprimentos antes (devem ser todos 1000)
cat("Comprimentos (não alinhadas):\n")
print(width(seqs_1000))

# Ver “não alinhadas” (opcional: trechos)
cat("\n--- NÃO ALINHADAS (trechos) ---\n")
for (i in 1:3) {
  cat(names(seqs_1000)[i], ":\n",
      as.character(subseq(seqs_1000[[i]], 1, 80)), "\n\n")
}

#Explicando a funcao acima com cat:
#------------------------------------------------------------
#cat(...): imprime um título.
#for (i in 1:3): mostra só as 3 primeiras.
#names(seqs_1000)[i]: imprime o nome da sequência (seq_01 etc.).
#subseq(..., 1, 80): pega só os 80 primeiros nucleotídeos.
#as.character(...): converte para texto para conseguir imprimir.
#“Vamos espiar só 80 letras das 3 primeiras para não lotar a tela.”

# Salvar NÃO ALINHADAS
writeXStringSet(seqs_1000, filepath = "random_10_nao_alinhadas.fasta")
cat("Arquivo salvo: random_10_nao_alinhadas.fasta\n")

# Alinhar todas (MUSCLE via 'msa')
aln <- msa(seqs_1000, type = "dna", method = "Muscle")
aln_set <- as(aln, "DNAStringSet")

# Garantir nomes após alinhamento (mesma ordem)
names(aln_set) <- names(seqs_1000)

# Depois do alinhamento: comprimentos iguais e maiores (devido aos gaps)
cat("Comprimentos (alinhadas):\n")
print(width(aln_set))

# Contar gaps por sequência (depois do alinhamento)
cat("Gaps por sequência (alinhadas):\n")
gaps_por_seq <- vapply(as.list(aln_set), function(s) as.integer(letterFrequency(s, "-")), 1L)
print(gaps_por_seq)

# Ver “ALINHADAS” (opcional: trechos)
cat("\n--- ALINHADAS (trechos) ---\n")
for (i in 1:3) {
  cat(names(aln_set)[i], ":\n",
      as.character(subseq(aln_set[[i]], 1, 80)), "\n\n")
}

#Explicando a funcao acima com cat:
#------------------------------------------------------------
#Igual ao anterior, mas agora aparecem - (gaps).
#Os gaps alinham as letras “coluna a coluna”, por isso todas ficam com o mesmo comprimento.

# Salvar ALINHADAS
writeXStringSet(aln_set, filepath = "random_10_alinhadas.fasta")
cat("Arquivo salvo: random_10_alinhadas.fasta\n")

############################################################
# COMO SALVAR O TRABALHO
############################################################

# 1) Salvar este script:
#   No RStudio: vá em File > Save As...
#   Dê um nome como "aula_sequencias.R"
#   Assim você pode abrir e rodar tudo de novo mais tarde.

# 2) Salvar o ambiente de trabalho (objetos criados: seqs_1000, aln_set, etc.)
save.image(file = "aula_sequencias.RData")

# Isso cria um arquivo chamado "aula_sequencias.RData" na pasta atual.
# Para carregar de volta em outra sessão do R:
# load("aula_sequencias.RData")

cat("\nScript e ambiente salvos! Você pode fechar o R e depois reabrir carregando o .RData.\n")
