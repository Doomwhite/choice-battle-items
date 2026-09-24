# Choice Battle Items

Site estático do **Choice Battle White 5.101** (Warcraft III: The Frozen Throne): banco de
itens navegável, preview da loading screen e os dados em CSV.

Publicado com GitHub Pages a partir da raiz deste repositório.

## Conteúdo

| Arquivo | O que é |
|---|---|
| `index.html` | Página de entrada: grade de itens, preview da loading screen e download do CSV |
| `items_grid.html` | A grade em si — autossuficiente, o CSV vai embutido nela |
| `items_database.csv` | 276 itens × 30 colunas, extraídos das tabelas lni e do `war3map.j` |
| `artifacts/loading-screen-preview.jpg` / `.png` | Preview da loading screen, decodificado da textura que vai dentro do `.w3x` (JPG leve para postar, PNG sem perda) |
| `items_build.json` | Manifesto: SHA-256 e tamanho dos arquivos de `src/` que geraram o CSV |
| `.nojekyll` | Faz o Pages servir os arquivos como estão (sem Jekyll; sem ele o `index.md` do wiki conflitaria com o `index.html`) |

## Publicar

**Settings → Pages → Build and deployment** → Source *Deploy from a branch* → Branch `main`,
folder **`/ (root)`** → Save. O site fica em `https://<user>.github.io/choice-battle-items/`.

## De onde vem e como atualizar

Nada aqui é editado à mão: tudo é gerado no repositório **Choice Battle White**, onde `src/`
é a fonte da verdade.

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
docs/artifacts/loading-screen-preview.jpg
docs/artifacts/loading-screen-preview.png
```

O passo a passo completo (e o motivo de não ser hospedado no Gitea) está em
`docs/publishing.md`, no repositório principal.
