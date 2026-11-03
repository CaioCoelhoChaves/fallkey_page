# Quickstart & Validation Guide: Sports Merge Landing Page

**Feature**: Sports Merge Landing Page  
**Card**: FAL-67  
**Artifact**: Quickstart Guide  

Este guia detalha o passo a passo para inicializar a aplicação localmente e validar todos os cenários da página de divulgação do **Sports Merge**.

---

## 1. Pré-Requisitos

- Flutter SDK 3.11+ instalado e configurado no PATH (`flutter doctor`).
- Google Chrome ou Edge instalado para execução do ambiente Web.
- Dependências instaladas no repositório `fallkey_page`.

---

## 2. Preparação do Ambiente

No diretório raiz do repositório `fallkey_page`:

```bash
# Obter dependências do Flutter
flutter pub get

# Executar a suíte de testes automatizados
flutter test
```

---

## 3. Execução Local

Inicie o servidor de desenvolvimento web na porta 8080:

```bash
flutter run -d chrome --web-port=8080
```

---

## 4. Roteiro de Validação Manual

### Cenário 1: Descoberta e Visualização Inicial (P1 / SC-001)
1. Acesse `http://localhost:8080/sports-merge` no navegador.
2. Verifique se o logotipo oficial, o slogan e o botão com o selo da Google Play Store são renderizados imediatamente.
3. Verifique se o poster estático ou o player de mídia de demonstração do jogo é exibido sem atraso (< 1.5s).

### Cenário 2: Redirecionamento Google Play Store (P1 / SC-004)
1. Localize a seção de download e clique no botão com badge da Google Play Store.
2. Certifique-se de que uma nova aba é aberta navegando para:
   `https://play.google.com/store/apps/details?id=com.fallkey.sports_merge`

### Cenário 3: Alternância de Idioma Instantânea (P2 / SC-003)
1. No cabeçalho da página, clique no seletor de idioma alternando entre `PT` e `EN`.
2. Verifique se todos os textos promocionais, títulos e botões alteram instantaneamente (< 100ms) sem recarregar a aba do navegador.
3. Teste o deep link direto com parâmetro de rota:
   - `http://localhost:8080/sports-merge?lang=en` (inicia em inglês)
   - `http://localhost:8080/sports-merge?lang=pt` (inicia em português)

### Cenário 4: Responsividade Multi-Dispositivo (P3 / SC-002)
1. Abra as Ferramentas do Desenvolvedor no Chrome (`F12` / `Ctrl+Shift+I`) e ative o modo de emulação de dispositivos móveis.
2. Teste em **360px** (Galaxy S8 / mobile estreito):
   - Os elementos devem se organizar em uma coluna vertical limpa.
   - Não deve haver barra de rolagem horizontal.
   - Os botões de download devem ocupar largura confortável para toque táctil.
3. Teste em **768px** (Tablet / iPad):
   - O layout deve reorganizar as seções mantendo espaçamento harmônico.
4. Teste em **1440px+** (Desktop widescreen):
   - O conteúdo deve manter-se centralizado com `maxWidth: 1200px`.

### Cenário 5: Status da Apple App Store (P4)
1. Clique no botão da Apple App Store.
2. Como a URL oficial da App Store está em processo de publicação, confirme se um feedback amigável é exibido (ex: *"O jogo Sports Merge estará disponível em breve na App Store para iPhone e iPad!"*) sem redirecionar para links quebrados nem erro 404.

---

## 5. Validação de Testes Automatizados

Execute os testes unitários e de widget específicos da feature:

```bash
flutter test test/pages/sports_merge/
```
