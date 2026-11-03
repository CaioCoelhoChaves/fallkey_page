import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class SportsMergeSupportPage extends StatefulWidget {
  final String? initialLang;

  const SportsMergeSupportPage({super.key, this.initialLang});

  @override
  State<SportsMergeSupportPage> createState() => _SportsMergeSupportPageState();
}

class _SportsMergeSupportPageState extends State<SportsMergeSupportPage> {
  late String _lang;

  @override
  void initState() {
    super.initState();
    final langParam = widget.initialLang?.toLowerCase();
    if (langParam != null && (langParam == 'pt' || langParam.startsWith('pt-') || langParam.startsWith('pt_'))) {
      _lang = 'pt';
    } else {
      _lang = 'en';
    }
  }

  void _copyEmail() {
    Clipboard.setData(const ClipboardData(text: 'caiocoelhochaves@gmail.com'));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _lang == 'pt'
              ? 'E-mail de suporte copiado: caiocoelhochaves@gmail.com'
              : 'Support email copied: caiocoelhochaves@gmail.com',
        ),
        backgroundColor: const Color(0xFF1e2430),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isPt = _lang == 'pt';

    return Scaffold(
      appBar: AppBar(
        title: Text(isPt ? 'Suporte do Sports Merge' : 'Sports Merge Support'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: SegmentedButton<String>(
              segments: const [
                ButtonSegment(value: 'en', label: Text('EN')),
                ButtonSegment(value: 'pt', label: Text('PT')),
              ],
              selected: {_lang},
              onSelectionChanged: (newSelection) {
                setState(() {
                  _lang = newSelection.first;
                });
              },
              style: SegmentedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(255, 255, 255, 0.05),
                selectedBackgroundColor: const Color(0xFF4169e1),
                selectedForegroundColor: Colors.white,
                foregroundColor: const Color(0xFFA0A0A0),
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 860),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Hero Banner
                Container(
                  padding: const EdgeInsets.all(28.0),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(255, 255, 255, 0.03),
                    border: Border.all(color: const Color.fromRGBO(255, 255, 255, 0.08)),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.3),
                        blurRadius: 20,
                        offset: Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      const Text(
                        '⚽ 🏀 🎾',
                        style: TextStyle(fontSize: 40),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        isPt ? 'Suporte ao Jogador' : 'Player Support & Help Center',
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        isPt
                            ? 'Assistência oficial, perguntas frequentes e contato direto com a equipe de desenvolvimento para Sports Merge no iOS.'
                            : 'Official assistance, troubleshooting guide, FAQs, and developer contact for Sports Merge on iOS.',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Color(0xFFA0A0A0),
                          height: 1.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // Contact Cards
                LayoutBuilder(
                  builder: (context, constraints) {
                    final isNarrow = constraints.maxWidth < 600;
                    return Flex(
                      direction: isNarrow ? Axis.vertical : Axis.horizontal,
                      children: [
                        Expanded(
                          flex: isNarrow ? 0 : 1,
                          child: _buildActionCard(
                            icon: Icons.email_outlined,
                            title: isPt ? 'E-mail de Suporte' : 'Email Support',
                            subtitle: isPt
                                ? 'Fale diretamente com o desenvolvedor. Resposta em até 48 horas.'
                                : 'Reach out directly to the developer. Replies within 48h.',
                            buttonText: isPt ? 'Copiar E-mail' : 'Copy Email',
                            onTap: _copyEmail,
                          ),
                        ),
                        SizedBox(width: isNarrow ? 0 : 16, height: isNarrow ? 16 : 0),
                        Expanded(
                          flex: isNarrow ? 0 : 1,
                          child: _buildActionCard(
                            icon: Icons.security_outlined,
                            title: isPt ? 'Política de Privacidade' : 'Privacy Policy',
                            subtitle: isPt
                                ? 'Entenda como tratamos dados de gameplay e serviços de anúncios.'
                                : 'Learn how gameplay data and third-party ad services are handled.',
                            buttonText: isPt ? 'Abrir Política' : 'View Policy',
                            onTap: () => context.go('/sports-merge/privacy'),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 40),

                // Section Title: FAQ
                Text(
                  isPt ? 'Perguntas Frequentes (FAQ)' : 'Frequently Asked Questions',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),

                // FAQs
                _buildFaqItem(
                  question: isPt ? 'Como jogar o Sports Merge?' : 'How do I play Sports Merge?',
                  answer: isPt
                      ? 'Arraste o dedo no topo da tela para mirar e solte para deixar as bolas esportivas caírem no recipiente. Quando duas bolas iguais se tocam, elas se fundem na próxima bola maior (ex: Tênis de mesa -> Tênis -> Beisebol -> Vôlei -> Futebol -> Basquete -> Troféu). Combine as bolas sem deixar o recipiente transbordar!'
                      : 'Drag your finger along the top to aim, then release to drop sports balls into the container. When two identical balls collide, they merge into the next larger ball (e.g., Table Tennis -> Tennis -> Baseball -> Volleyball -> Soccer -> Basketball -> Trophy). Manage your space carefully so balls do not overflow past the top line!',
                ),
                _buildFaqItem(
                  question: isPt
                      ? 'O jogo está sem som ou música. O que fazer?'
                      : 'The game has no sound or music. How do I fix this?',
                  answer: isPt
                      ? '1. Verifique a chave física de Silencioso (ou Botão de Ação) na lateral do seu iPhone. Jogos no iOS respeitam essa trava de áudio por padrão.\n2. Verifique o volume de mídia na Central de Controle do iOS.\n3. Abra o menu de Configurações no jogo e certifique-se de que Som e Música estão ligados.\n4. Caso utilize fones Bluetooth, reinicie o app após conectar os fones.'
                      : '1. Check the physical Ring/Silent switch (or Action Button) on the side of your iPhone. iOS games respect hardware mute by default.\n2. Increase media volume via iOS Control Center.\n3. Open in-game Settings to verify that both Music and SFX are toggled on.\n4. If using Bluetooth headphones, restart the application after connecting.',
                ),
                _buildFaqItem(
                  question: isPt
                      ? 'Como restaurar compras ou remover anúncios?'
                      : 'How do I restore in-app purchases or remove ads?',
                  answer: isPt
                      ? 'Se você comprou a remoção de anúncios e reinstalou o app ou trocou de aparelho: acesse o menu de Configurações no jogo e toque em "Restaurar Compras". Certifique-se de estar usando o mesmo ID Apple da compra original.'
                      : 'If you purchased ad removal and reinstalled the game or upgraded devices: open the game Settings and tap "Restore Purchases". Ensure you are logged into the same Apple ID used during the original purchase.',
                ),
                _buildFaqItem(
                  question: isPt
                      ? 'Posso jogar offline? Onde meus recordes são salvos?'
                      : 'Can I play offline? How are my high scores saved?',
                  answer: isPt
                      ? 'Sim! O Sports Merge funciona totalmente offline. Suas partidas e recordes ficam salvos localmente na memória do dispositivo. Ao conectar à internet, suas melhores pontuações são sincronizadas com o Apple Game Center.'
                      : 'Yes! Sports Merge is fully playable offline without an active internet connection. Your scores and session stay saved locally on your device. When online, high scores sync with Apple Game Center.',
                ),
                _buildFaqItem(
                  question: isPt
                      ? 'O app está travando ou fechando. O que fazer?'
                      : 'The app is lagging or crashing. What should I do?',
                  answer: isPt
                      ? '1. Feche o app no seletor de aplicativos do iOS e abra novamente.\n2. Verifique na App Store se há atualizações disponíveis para o Sports Merge.\n3. Reinicie seu iPhone ou iPad para liberar memória RAM.\n4. Caso o problema persista, envie um e-mail para caiocoelhochaves@gmail.com com seu modelo de iPhone e versão do iOS.'
                      : '1. Force close the app from the iOS App Switcher and reopen it.\n2. Check the App Store for the latest Sports Merge update.\n3. Restart your iPhone or iPad to free up RAM memory.\n4. If the issue persists, email caiocoelhochaves@gmail.com with your device model and iOS version.',
                ),
                _buildFaqItem(
                  question: isPt
                      ? 'Como solicitar exclusão de dados ou redefinir progresso?'
                      : 'How do I reset game data or request data deletion?',
                  answer: isPt
                      ? 'O Sports Merge não exige login nem armazena dados de identificação pessoal em servidores externos. Seus dados residem no próprio aparelho. Para zerar tudo, basta desinstalar e reinstalar o aplicativo pela App Store.'
                      : 'Sports Merge does not require an account or collect personal identity data on developer servers. All progress is stored locally on your device. To reset everything, simply delete and reinstall the app from the App Store.',
                ),
                const SizedBox(height: 36),

                // App Info Box
                Container(
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(255, 255, 255, 0.02),
                    border: Border.all(color: const Color.fromRGBO(255, 255, 255, 0.05)),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      _buildInfoRow(isPt ? 'Aplicativo' : 'App', 'Sports Merge'),
                      const Divider(color: Color.fromRGBO(255, 255, 255, 0.05)),
                      _buildInfoRow(isPt ? 'Desenvolvedor' : 'Developer', 'Caio Chaves / FallKey'),
                      const Divider(color: Color.fromRGBO(255, 255, 255, 0.05)),
                      _buildInfoRow(isPt ? 'Compatibilidade' : 'Compatibility', 'iOS & iPadOS 13.0+'),
                      const Divider(color: Color.fromRGBO(255, 255, 255, 0.05)),
                      _buildInfoRow(isPt ? 'E-mail de Suporte' : 'Support Email', 'caiocoelhochaves@gmail.com'),
                    ],
                  ),
                ),
                const SizedBox(height: 40),

                // Footer
                Text(
                  isPt
                      ? '© ${DateTime.now().year} FallKey / Caio Chaves. Todos os direitos reservados.'
                      : '© ${DateTime.now().year} FallKey / Caio Chaves. All rights reserved.',
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF70757D),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required String buttonText,
    required VoidCallback onTap,
  }) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(255, 255, 255, 0.03),
        border: Border.all(color: const Color.fromRGBO(255, 255, 255, 0.06)),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: const Color(0xFF4169e1), size: 28),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFFA0A0A0),
              height: 1.4,
            ),
          ),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: onTap,
            style: FilledButton.styleFrom(
              backgroundColor: const Color(0xFF4169e1),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(buttonText),
          ),
        ],
      ),
    );
  }

  Widget _buildFaqItem({required String question, required String answer}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(255, 255, 255, 0.03),
        border: Border.all(color: const Color.fromRGBO(255, 255, 255, 0.06)),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          iconColor: const Color(0xFF4169e1),
          collapsedIconColor: const Color(0xFFA0A0A0),
          title: Text(
            question,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
              child: Text(
                answer,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFFA0A0A0),
                  height: 1.6,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF70757D),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
