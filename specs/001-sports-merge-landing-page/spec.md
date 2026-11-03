# Feature Specification: Página de Divulgação do Sports Merge

**Feature Branch**: `feat/FAL-67-sports-merge-landing-page`

**Created**: 2026-11-03

**Status**: Draft

**Input**: User description: "Eu quero criar uma nova página para divulgar meu jogo Sports Merge, presente no seguinte repositório: C:\Users\caioc\Projects\fk_games\sports_merge. A página deve conter vídeos e textos em português/inglês para eu divulgar meu jogo, deve ser repsonsivo para celulares e computadores. Deve direcionar o usuário ou para Apple Store (link a definir) ou para a Play Store https://play.google.com/store/apps/details?id=com.fallkey.sports_merge"

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Descobrir o jogo e baixar na Google Play Store (Priority: P1)

Como uma pessoa interessada em jogos casuais no celular ou computador, quero acessar a página de divulgação do Sports Merge, assistir a vídeos e ver imagens dinâmicas do jogo com textos explicativos na minha língua, e clicar em um botão direto para baixar o jogo na Google Play Store.

**Why this priority**: É o objetivo de negócio principal (MVP) da divulgação: apresentar o jogo de forma atrativa e converter visitantes em downloads imediatos na loja onde o jogo já está disponível.

**Independent Test**: Pode ser testado acessando a URL da página no navegador (mobile ou desktop), conferindo a exibição do vídeo demonstrativo e clicando no botão da Google Play Store, verificando o redirecionamento para o link oficial da loja.

**Acceptance Scenarios**:

1. **Given** que o visitante acessa a página do Sports Merge em qualquer resolução de tela (smartphone ou desktop), **When** a página termina de carregar, **Then** o visitante visualiza o título, chamada principal, vídeo de demonstração do jogo em ação e o botão de download com o selo oficial da Google Play Store.
2. **Given** que o visitante está visualizando o botão de download da Google Play Store, **When** o visitante clica no botão, **Then** o navegador abre em nova aba o link oficial do Sports Merge na Google Play Store (`https://play.google.com/store/apps/details?id=com.fallkey.sports_merge`).

---

### User Story 2 - Alternar idioma entre Português e Inglês (Priority: P2)

Como um visitante internacional ou brasileiro, quero que o conteúdo (títulos, descrições da jogabilidade, chamadas para ação e legendas) esteja disponível em Português e Inglês, podendo alternar de forma simples e intuitiva a qualquer momento.

**Why this priority**: O Sports Merge possui público global e nacional; permitir alternância clara de idioma expande o alcance e a retenção de visitantes internacionais.

**Independent Test**: Pode ser testado clicando no seletor de idioma na página e verificando se todos os textos e chamadas mudam instantaneamente para o idioma escolhido sem recarregar a navegação nem quebrar o layout.

**Acceptance Scenarios**:

1. **Given** que a página está exibida em Português, **When** o usuário clica no seletor de idioma e escolhe Inglês (EN), **Then** todos os textos promocionais, títulos de seções, características do jogo e textos dos botões são atualizados imediatamente para o idioma inglês.
2. **Given** que um visitante acessa o link direto com preferência de idioma ou parâmetro de idioma (ex: `?lang=en` ou `?lang=pt`), **When** a página é carregada pela primeira vez, **Then** o conteúdo é inicializado automaticamente no idioma correspondente.

---

### User Story 3 - Visualizar a página com experiência adaptada em dispositivos móveis e computadores (Priority: P3)

Como um usuário navegando pelo celular ou por um monitor widescreen, quero que a disposição dos vídeos, capturas de tela e botões se adapte confortavelmente ao tamanho da minha tela, sem barras de rolagem horizontais indesejadas nem elementos sobrepostos.

**Why this priority**: A maioria do tráfego vindo de redes sociais e anúncios virá de celulares, enquanto análises e visitas de parceiros/desktop exigem layout elegante em telas amplas.

**Independent Test**: Pode ser testado redimensionando a janela do navegador entre larguras típicas de smartphones (360px a 430px), tablets (768px a 1024px) e desktops (1280px ou mais), validando legibilidade e proporções.

**Acceptance Scenarios**:

1. **Given** que a página é acessada em um smartphone (largura estreita), **When** o usuário rola verticalmente, **Then** os elementos se empilham em coluna única, o vídeo e mídias mantêm proporção sem cortes e os botões de ação ocupam largura confortável para toque táctil.
2. **Given** que a página é acessada em um computador desktop, **When** a janela está maximizada, **Then** a apresentação aproveita o espaço horizontal com layout em grade ou colunas balanceadas, mantendo margens harmônicas e leitura agradável.

---

### User Story 4 - Visualizar disponibilidade e redirecionamento para Apple App Store (Priority: P4)

Como um usuário de iPhone ou iPad, quero identificar a opção de download para o ecossistema Apple na página e saber o status de disponibilidade do jogo na App Store.

**Why this priority**: O jogo está em fase de publicação para iOS; o usuário precisa ver que o aplicativo terá suporte a iOS e, caso o link ainda não esteja ativo, receber uma mensagem amigável de "Em breve" ou notificação.

**Independent Test**: Pode ser testado interagindo com o botão da Apple App Store na página e verificando o comportamento previsto (redirecionar se link configurado ou exibir aviso informativo de lançamento em breve).

**Acceptance Scenarios**:

1. **Given** que o link da Apple Store ainda não está publicado (link a definir), **When** o usuário passa o mouse ou clica no botão da Apple App Store, **Then** o sistema exibe indicação visual clara de disponibilidade em breve ("Disponível em breve na App Store / Coming soon on App Store") sem gerar erro 404 nem tela quebrada.
2. **Given** que o link da Apple Store estiver definido futuramente, **When** o usuário clica no botão, **Then** o navegador abre o link oficial da App Store em nova aba.

---

### Edge Cases

- **Conexão lenta ou economia de dados móveis**: Se o vídeo demonstrativo demorar para carregar, a página deve exibir imediatamente uma imagem estática de capa (poster) de alta qualidade do jogo, sem deixar um espaço vazio ou preto.
- **Reprodução automática de vídeo com restrição de áudio pelo navegador**: Caso o navegador bloqueie autoplay com som, o vídeo deve iniciar com som desativado (muted) e controles visíveis para o usuário ativar o som quando desejar.
- **Telas ultra-wide (> 1920px)**: O conteúdo central deve manter largura máxima restrita (max-width) para não espalhar o texto excessivamente e prejudicar a leitura.
- **Redimensionamento dinâmico**: Ao girar o smartphone entre modo retrato e paisagem, os elementos devem se reorganizar suavemente sem perda de estado.

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: O sistema DEVE fornecer uma página web pública acessível via rota amigável dedicada ao jogo Sports Merge (ex: `/sports-merge` ou `/games/sports-merge`).
- **FR-002**: O sistema DEVE conter uma seção de destaque (Hero) apresentando o título do jogo, logotipo oficial, slogan e chamada principal para ação.
- **FR-003**: O sistema DEVE apresentar vídeos e mídias visuais demonstrando a jogabilidade (gameplay) do Sports Merge, destacando a mecânica de fusão de bolas esportivas.
- **FR-004**: O sistema DEVE disponibilizar todo o conteúdo textual nos idiomas Português (pt-BR) e Inglês (en-US).
- **FR-005**: O sistema DEVE incluir um controle interativo de fácil acesso no topo da página para alternar entre Português e Inglês a qualquer momento.
- **FR-006**: O sistema DEVE disponibilizar um botão de chamada para ação com o badge da Google Play Store que redireciona o usuário para `https://play.google.com/store/apps/details?id=com.fallkey.sports_merge` abrindo em uma nova aba.
- **FR-007**: O sistema DEVE disponibilizar um botão de chamada para ação para a Apple App Store, com estado preparado para suporte a link configurável ou indicação de "Em breve" enquanto o link oficial não for configurado.
- **FR-008**: O sistema DEVE ser totalmente responsivo, adaptando sua tipografia, espaçamentos, disposições de mídias e controles interativos entre resoluções móveis (smartphones), intermediárias (tablets) e amplas (desktops).
- **FR-009**: O sistema DEVE incluir links para as páginas de suporte e política de privacidade do Sports Merge já existentes no site da FallKey.
- **FR-010**: O sistema DEVE carregar imagens de capa (posters) para os vídeos, garantindo visualização informativa mesmo antes da execução do vídeo.

### Key Entities

- **GamePresentation**: Conjunto de metadados de apresentação do jogo, incluindo título ("Sports Merge"), logotipo, slogan resumido, descrição detalhada dos recursos (gameplay, pontuação, recordes) e mídias de suporte.
- **LocalizationProfile**: Modelo de conteúdo com pares chave-valor para os idiomas suportados (Português e Inglês), englobando cabeçalhos, textos explicativos, rótulos de botões e legendas.
- **StoreDestination**: Representação dos destinos de download do aplicativo, contendo plataforma (Google Play Store, Apple App Store), URL de destino, rótulo visual, badge oficial e estado de disponibilidade (Ativo / Em breve).
- **ShowcaseMedia**: Mídias de demonstração do jogo (vídeos de gameplay, capturas de tela das versões em português e inglês, imagens promocionais).

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: O visitante consegue identificar a proposta do jogo e acessar o link da Google Play Store em menos de 5 segundos após o carregamento da página.
- **SC-002**: A página mantém legibilidade e usabilidade completa em 100% das resoluções testadas entre 360px de largura (mobile) e 2560px (desktop ultrawide), sem estouro de rolagem horizontal.
- **SC-003**: A alternância entre os idiomas Português e Inglês ocorre instantaneamente (< 100ms) sem recarregamento completo da página web.
- **SC-004**: 100% dos cliques no botão da Google Play Store direcionam corretamente para o endereço verificado da aplicação na loja.
- **SC-005**: Em conexões com restrição de autoplay ou carregamento lento, uma imagem ilustrativa da partida é exibida em menos de 1,5 segundos.

## Assumptions

- O jogo já possui publicação ativa e verificada na Google Play Store no endereço `https://play.google.com/store/apps/details?id=com.fallkey.sports_merge`.
- A publicação na Apple App Store está em andamento no projeto do jogo; enquanto a URL oficial da App Store não estiver confirmada, o botão apresentará indicação amigável de "Em breve" (Coming soon).
- O site da FallKey já possui as rotas `/sports-merge/privacy` e `/sports-merge/support`, que poderão ser referenciadas no rodapé da página.
- Os vídeos e capturas de tela do repositório `sports_merge` (localizados em `store-images` e `assets`) servirão de base para a montagem dos recursos visuais da página.
- O idioma padrão inicial pode ser inferido pelo navegador do visitante ou pelo parâmetro de rota, utilizando Português como padrão para visitantes do Brasil e Inglês para os demais.
