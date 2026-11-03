# UI & Route Contract: Sports Merge Landing Page

**Feature**: Sports Merge Landing Page  
**Card**: FAL-67  
**Artifact**: Contract Specification  

---

## 1. Web Route Contract

| Rota | Tipo | Parâmetros | Descrição |
|---|---|---|---|
| `/sports-merge` | Primária | `lang` (opcional: `pt` ou `en`) | Página de destino responsiva do jogo |
| `/sports-merge/privacy` | Sub-rota | Nenhum | Página existente de Política de Privacidade |
| `/sports-merge/support` | Sub-rota | `lang` (opcional: `pt` ou `en`) | Página existente de Suporte com formulário/contato |

### Parâmetro `lang` e Resolução de Idioma
1. **Entrada**: Query param `?lang=pt` ou `?lang=en`.
2. **Normalização**: `.toLowerCase()`. Se iniciar com `pt` (`pt-BR`, `pt_BR`, `pt`), define idioma ativo como `pt`. Caso contrário, define como `en`.
3. **Persistência**: A alternância do usuário via `SegmentedButton` atualiza o estado local reativo imediatamente e sincroniza a URL do navegador via `GoRouter.of(context).go('/sports-merge?lang=' + selectedLang)`.

---

## 2. Interactive Action Contracts

### 2.1 Ação: Clique em Download Google Play Store
- **Trigger**: Usuário toca/clica no botão `StoreBadgeButton` da Google Play.
- **Precondição**: Conexão ativa com a internet.
- **Payload / URL**: `https://play.google.com/store/apps/details?id=com.fallkey.sports_merge`
- **Comportamento**: Dispara `launchUrl(uri, mode: LaunchMode.externalApplication)`.
- **Resultado Esperado**: Nova aba no navegador abre diretamente a página oficial na Google Play Store.

### 2.2 Ação: Clique em Download Apple App Store
- **Trigger**: Usuário toca/clica no botão `StoreBadgeButton` da Apple App Store.
- **Caso A (isAvailable == false)**:
  - Exibe feedback amigável imediato (`SnackBar` flutuante com visual escuro estilizado ou dialog contextual).
  - Mensagem PT: *"O jogo Sports Merge estará disponível em breve na App Store para iPhone e iPad!"*
  - Mensagem EN: *"Sports Merge will be available soon on the App Store for iPhone and iPad!"*
- **Caso B (isAvailable == true)**:
  - Abre a URL oficial configurada em nova aba externa.

### 2.3 Ação: Alternância de Idioma (Language Toggle)
- **Trigger**: Usuário seleciona `PT` ou `EN` no `SegmentedButton` do cabeçalho.
- **Comportamento**:
  - `setState` atualiza a referência ativa de `LocalizationProfile`.
  - Re-renderização reativa em < 100ms sem desmontar controllers de vídeo ou estado de scroll.

---

## 3. Responsive Breakpoints & Accessibility Contract

| Breakpoint | Largura (px) | Grid / Disposição | Dimensões do CTA | Espaçamento Lateral |
|---|---|---|---|---|
| **Mobile** | `< 600px` | 1 coluna empilhada | Largura cheia (100%), altura mín 48px | 16px |
| **Tablet** | `600px - 1024px` | 1 a 2 colunas adaptativas | Botões alinhados lado a lado ou 50% | 24px |
| **Desktop** | `>= 1024px` | 2 colunas balanceadas (Hero + Media) | Botões inline agrupados (min-width 180px) | Max-width 1200px centrado |

### Acessibilidade (WCAG 2.1 AA)
- Todos os botões interativos possuem `Semantics` com `button: true` e rótulo explicativo (`Semantics.label`).
- Contraste de cor mínimo de 4.5:1 para textos normais e 3:1 para títulos grandes sobre o fundo escuro (`#0b0c10`).
- Elementos focáveis via teclado (`Tab` e `Enter`) com anéis de foco visíveis.
