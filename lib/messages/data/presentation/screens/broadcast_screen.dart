import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/message_providers.dart';

class BroadcastScreen extends ConsumerStatefulWidget {
  const BroadcastScreen({super.key});

  @override
  ConsumerState<BroadcastScreen> createState() => _BroadcastScreenState();
}

class _BroadcastScreenState extends ConsumerState<BroadcastScreen> {
  final _messageCtrl = TextEditingController();
  final _chatIdCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isSending = false;
  String? _errorMessage;

  @override
  void dispose() {
    _messageCtrl.dispose();
    _chatIdCtrl.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isSending = true;
      _errorMessage = null;
    });

    try {
      await ref.read(broadcastMessageUseCaseProvider)(
        message: _messageCtrl.text,
        chatId: _chatIdCtrl.text.trim().isEmpty
            ? null
            : _chatIdCtrl.text.trim(),
      );

      if (!mounted) return;

      _messageCtrl.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Mensaje enviado correctamente ✅'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      setState(() => _errorMessage = e.toString());
    } finally {
      if (mounted) setState(() => _isSending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Difundir mensaje al grupo',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text(
                'El mensaje se enviará al grupo configurado por defecto.',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 24),

              TextFormField(
                controller: _messageCtrl,
                maxLines: 8,
                maxLength: 4096,
                decoration: const InputDecoration(
                  labelText: 'Mensaje',
                  hintText: '¡Nuevo episodio disponible! 🎬',
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(),
                ),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) {
                    return 'El mensaje no puede estar vacío';
                  }
                  if (v.length > 4096) {
                    return 'El mensaje es demasiado largo (máx 4096)';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _chatIdCtrl,
                decoration: const InputDecoration(
                  labelText: 'Chat ID (opcional)',
                  hintText: 'Ej: -1001234567890',
                  helperText: 'Dejar vacío para usar el grupo por defecto',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),

              if (_errorMessage != null) ...[
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.error_outline, color: Colors.red),
                      const SizedBox(width: 8),
                      Expanded(child: Text(_errorMessage!)),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ],

              FilledButton.icon(
                icon: _isSending
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(Icons.send),
                label: Text(_isSending ? 'Enviando...' : 'Enviar mensaje'),
                onPressed: _isSending ? null : _send,
              ),
              const SizedBox(height: 8),
              TextButton.icon(
                icon: const Icon(Icons.preview),
                label: const Text('Vista previa'),
                onPressed: _showPreview,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showPreview() {
    final text = _messageCtrl.text.trim();
    if (text.isEmpty) return;

    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (_) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Vista previa',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(text),
            ),
          ],
        ),
      ),
    );
  }
}