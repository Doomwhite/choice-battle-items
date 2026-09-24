# Choice Battle Items

Site estático do **Choice Battle 5.101** (Warcraft III: The Frozen Throne): banco de itens
navegável e os dados em CSV.

**No ar:** <https://doomwhite.github.io/choice-battle-items/> — GitHub Pages, branch `main`,
folder `/ (root)`.

## Conteúdo

| Arquivo | O que é |
|---|---|
| `index.html` | Página de entrada: grade de itens e download do CSV |
| `items_grid.html` | A grade em si — autossuficiente, o CSV vai embutido nela |
| `items_database.csv` | 276 itens × 30 colunas, extraídos das tabelas lni e do `war3map.j` |
| `items_build.json` | Manifesto: SHA-256 e tamanho dos arquivos de `src/` que geraram o CSV |
| `.nojekyll` | Faz o Pages servir os arquivos como estão (sem Jekyll; sem ele o `index.md` do wiki conflitaria com o `index.html`) |

## Publicar

Já está publicado: **Settings → Pages** → Source *Deploy from a branch* → Branch `main`,
folder **`/ (root)`**. Cada push em `main` dispara um rebuild automático
(<https://doomwhite.github.io/choice-battle-items/>).

## De onde vem e como atualizar

Nada aqui é editado à mão: tudo é gerado no repositório do mapa, onde `src/` é a fonte da
verdade.

```
python dev/items/pipeline.py            # regera CSV + grade + manifesto
python dev/items/pipeline.py --check    # falha se a grade embutir um CSV antigo
```

Depois de rodar lá, copie para a raiz deste repositório:

```
docs/index.html
docs/items_grid.html
docs/items_database.csv
docs/items_build.json
docs/.nojekyll
```

O passo a passo completo (e o motivo de não ser hospedado no Gitea) está em
`docs/publishing.md`, no repositório principal.
