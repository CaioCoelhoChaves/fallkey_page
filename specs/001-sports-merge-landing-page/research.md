# Research: Página de Divulgação do Sports Merge

**Feature**: Sports Merge Landing Page  
**Card**: FAL-67  
**Branch**: `feat/FAL-67-sports-merge-landing-page`  
**Status**: Completed  

---

## 1. Roteamento e Deep Linking (GoRouter)

### Decision
Adotar a rota canônica `/sports-merge` no GoRouter do Flutter Web com suporte a query parameter `?lang=pt` ou `?lang=en` e sub-rotas hierárquicas (`/sports-merge/support`, `/sports-merge/privacy`). Nomear as rotas com `@TypedGoRoute` ou constantes fortemente tipadas (`name: 'sports-merge'`).

### Rationale
- O `main.dart` da aplicação já utiliza `GoRouter` (`^17.1.0`) com `usePathUrlStrategy()` para URLs limpas na web.
- A página de suporte já existe em `/sports-merge/support` e consome `state.uri.queryParameters['lang']`.
- Mantém coerência e hierarquia uniforme com as diretrizes do skill `flutter-navigation` (nomes em minúsculas separados por hífen, navegação hierárquica e desacoplada).

### Alternatives Considered
- *Subdomínio dedicado (`sportsmerge.fallkey.com`)*: Rejeitado porque o escopo é unificar o portfólio no domínio institucional `fallkey.com/sports-merge`, facilitando SEO e manutenção de infraestrutura.
- *Rotas separadas por idioma (`/pt/sports-merge` e `/en/sports-merge`)*: Rejeitado em prol de um único endpoint com query param e controle de estado em memória para troca instantânea (< 100ms) sem recarregamento.

---

## 2. Internacionalização e Troca Dinâmica de Idioma (i18n)

### Decision
Utilizar um modelo de conteúdo desacoplado (`SportsMergeContent`) com suporte a `LocaleProfile` (pt-BR e en-US) e alternância reativa na UI via `SegmentedButton` (`PT` / `EN`) no topo da página. Se fornecido `?lang=...`, inicializar com o idioma selecionado; caso contrário, inferir a preferência padrão ou utilizar Português.

### Rationale
- Atende ao Critério de Sucesso **SC-003**: alternância instantânea (< 100ms) entre idiomas sem reload da página e sem rebuilds destrutivos.
- O padrão `SegmentedButton` no AppBar já é utilizado com excelência em `lib/pages/sports_merge_support_page.dart`. Reutilizar esse padrão estabelece consistência visual em todo o portal FallKey.
- A estrutura de dados desacoplada prepara o código para fácil migração futura para `flutter_localizations` / ARB sem quebrar a camada de apresentação.

### Alternatives Considered
- *Recarregamento de página via JavaScript window.location*: Rejeitado por ser lento (> 500ms), perder o scroll do usuário e degradar a experiência no mobile.
- *Tradução estática separada em dois HTMLs independentes*: Rejeitado porque a aplicação inteira é uma Single Page Application (SPA) Flutter Web.

---

## 3. Arquitetura Responsiva e Adaptação Multi-Dispositivo

### Decision
Implementar layout responsivo utilizando `LayoutBuilder`, `MediaQuery` e `ConstrainedBox` com pontos de quebra (breakpoints) canônicos:
- **Mobile (< 600px)**: Coluna única vertical, Hero com vídeo/imagem em proporção adaptada, botões de download com largura cheia (min-height 48px para touch targets WCAG), tipografia compacta.
- **Tablet (600px - 1024px)**: Layout em duas colunas híbridas, espaçamentos médios.
- **Desktop (>= 1024px)**: Layout em duas colunas balanceadas (Hero com chamada e CTAs à esquerda, demonstração de mídia interativa à direita), container com `maxWidth: 1200px` para evitar espalhamento excessivo em monitores ultrawide (2560px+).

### Rationale
- Cumpre rigorosamente o Requisito **FR-008** e o Critério de Sucesso **SC-002** (responsividade de 360px a 2560px sem transbordamento ou rolagem horizontal).
- Atende aos requisitos de acessibilidade do skill `flutter-accessibility` para touch targets confortáveis em dispositivos móveis.

### Alternatives Considered
- *Páginas móveis e desktop separadas*: Rejeitado por gerar duplicação massiva de código e complexidade de manutenção.
- *Layout fixo com zoom viewport*: Rejeitado por prejudicar a usabilidade e violar critérios de acessibilidade.

---

## 4. Apresentação de Mídia (Vídeo de Gameplay & Galeria de Telas)

### Decision
Implementar um componente `SportsMergeMediaShowcase` com estratégia de carregamento em camadas:
1. **Camada 1 (Poster estático imediato)**: Exibição instantânea (< 1.5s, SC-005) de imagem ilustrativa da partida em alta definição a partir dos assets locais.
2. **Camada 2 (Player de vídeo com controles e autoplay sem áudio)**: Suporte a vídeo de gameplay em loop com som desativado por padrão (muted) e controles visíveis, prevenindo bloqueios de autoplay dos navegadores modernos.
3. **Camada 3 (Carrossel interativo de capturas de tela)**: Galeria com as telas oficiais do jogo (extraídas de `sports_merge/store-images` em pt-BR e en-US), com indicadores de página e gestos de arrasto/toque.

### Rationale
- Garante conformidade com o Edge Case de conexões móveis lentas e restrições de autoplay de navegadores (Chrome, Safari, Firefox).
- Fornece material visual rico e de alta conversão para o usuário antes do clique para download.

### Alternatives Considered
- *Vídeo forçado em autoplay com áudio*: Rejeitado categoricamente; os navegadores bloqueiam e geram experiência hostil ao visitante.
- *Apenas vídeo sem fallback estático*: Rejeitado por falhar no Critério SC-005 quando em conexões móveis instáveis.

---

## 5. Integração com Lojas de Aplicativos (Google Play & Apple App Store)

### Decision
1. **Google Play Store**: Utilizar dependência `url_launcher: ^6.3.0` para abrir `https://play.google.com/store/apps/details?id=com.fallkey.sports_merge` em nova aba externa (`LaunchMode.externalApplication` ou `webOnlyWindowName: '_blank'`). Badge oficial com visual padronizado.
2. **Apple App Store**: Apresentar botão com o badge oficial da App Store. Enquanto a URL final estiver indefinida, o botão exibirá um estado informativo claro ("Em breve na App Store / Coming soon on the App Store") com tooltip ou modal informativo elegante sem gerar erro 404.

### Rationale
- Atende aos Requisitos **FR-006**, **FR-007** e aos Critérios **SC-001** e **SC-004**.
- `url_launcher` é o padrão oficial do ecossistema Flutter para abertura segura de links externos e deep links no mobile e na web.

### Alternatives Considered
- *Ocultar o botão da Apple Store até o lançamento*: Rejeitado pelo usuário; a especificação exige exibir a presença do ecossistema Apple com o status "Em breve".
- *Link fictício `href="#"`*: Rejeitado por gerar sensação de funcionalidade quebrada e confundir o usuário.

---

## 6. Origem e Otimização dos Assets

### Decision
Importar e sincronizar os assets visuais do repositório `fk_games/sports_merge` para `fallkey_page/assets/sports_merge/`:
- Ícone do jogo: `assets/sports_merge/logo.png`
- Badges das lojas: `assets/sports_merge/badges/google_play.png` e `apple_store.png`
- Screenshots pt-BR: `assets/sports_merge/screenshots/pt/`
- Screenshots en-US: `assets/sports_merge/screenshots/en/`
- Imagem poster de destaque: `assets/sports_merge/poster.jpeg`

### Rationale
- Garante que a aplicação web FallKey seja auto-contida, sem depender de caminhos locais externos durante o build de produção e deploy no GitHub Pages.
