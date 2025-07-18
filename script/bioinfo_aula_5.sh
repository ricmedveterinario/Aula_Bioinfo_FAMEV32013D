#!/bin/bash

# Script de transcrição e tradução simplificada de sequência bacteriana
# Atenção: execute este script a partir da pasta onde ele está salvo

# 1. Entrar na pasta com os arquivos de sequência
cd sequencia_dna/

# 2. Verificar onde estamos e listar conteúdo
echo -e "\n📁 Diretório atual:"
pwd
echo -e "\n📄 Conteúdo da pasta:"
ls

# 3. Remover cabeçalhos do arquivo .fna e salvar apenas a sequência (DNA)
grep -v "^>" bacteria.fna > bacteria_dna.txt

# 4. Transcrever DNA para RNA (substituir T por U)
sed 's/T/U/g' bacteria_dna.txt > bacteria_rna.txt

# 5. Traduzir RNA para aminoácidos (código genético simplificado – substituições diretas)
cat bacteria_rna.txt | sed \
  -e 's/AUG/M/g' -e 's/UGG/W/g' \
  -e 's/UUA/L/g' -e 's/UUG/L/g' -e 's/CUU/L/g' -e 's/CUC/L/g' -e 's/CUA/L/g' -e 's/CUG/L/g' \
  -e 's/GUU/V/g' -e 's/GUC/V/g' -e 's/GUA/V/g' -e 's/GUG/V/g' \
  -e 's/UUU/F/g' -e 's/UUC/F/g' \
  -e 's/AUU/I/g' -e 's/AUC/I/g' -e 's/AUA/I/g' \
  -e 's/UAU/Y/g' -e 's/UAC/Y/g' \
  -e 's/UAA/*/g' -e 's/UAG/*/g' -e 's/UGA/*/g' \
  -e 's/GCU/A/g' -e 's/GCC/A/g' -e 's/GCA/A/g' -e 's/GCG/A/g' \
  -e 's/UGU/C/g' -e 's/UGC/C/g' \
  -e 's/GAA/E/g' -e 's/GAG/E/g' \
  -e 's/GAU/D/g' -e 's/GAC/D/g' \
  -e 's/CAA/Q/g' -e 's/CAG/Q/g' \
  -e 's/AAU/N/g' -e 's/AAC/N/g' \
  -e 's/AAA/K/g' -e 's/AAG/K/g' \
  -e 's/CAU/H/g' -e 's/CAC/H/g' \
  -e 's/CGU/R/g' -e 's/CGC/R/g' -e 's/CGA/R/g' -e 's/CGG/R/g' -e 's/AGA/R/g' -e 's/AGG/R/g' \
  -e 's/CCU/P/g' -e 's/CCC/P/g' -e 's/CCA/P/g' -e 's/CCG/P/g' \
  -e 's/UCU/S/g' -e 's/UCC/S/g' -e 's/UCA/S/g' -e 's/UCG/S/g' -e 's/AGU/S/g' -e 's/AGC/S/g' \
  -e 's/ACU/T/g' -e 's/ACC/T/g' -e 's/ACA/T/g' -e 's/ACG/T/g' \
  -e 's/GGU/G/g' -e 's/GGC/G/g' -e 's/GGA/G/g' -e 's/GGG/G/g' \
  > bacteria_aminoacidos.txt

# 6. Mostrar os primeiros resultados
echo -e "\n🧬 DNA (primeiras linhas):"
head -n 3 bacteria_dna.txt

echo -e "\n🧬 RNA (primeiras linhas):"
head -n 3 bacteria_rna.txt

echo -e "\n🧪 Aminoácidos traduzidos (primeiras linhas):"
head -n 3 bacteria_aminoacidos.txt

# 7. Mostrar quantidade de nucleotídeos e aminoácidos gerados
num_ntd=$(wc -m < bacteria_dna.txt)
num_ntr=$(wc -m < bacteria_rna.txt)
num_aa=$(wc -m < bacteria_aminoacidos.txt)

echo -e "\n📊 Relatório:"
echo "Total de nucleotídeos no DNA: $num_ntd"
echo "Total de nucleotídeos no RNA: $num_ntr"
echo "Total estimado de aminoácidos traduzidos: $num_aa"

# 8. Finalização
echo -e "\n✅ Script finalizado com sucesso!"