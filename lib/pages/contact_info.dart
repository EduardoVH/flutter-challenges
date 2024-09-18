import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactInfo extends StatelessWidget {
  const ContactInfo({super.key});

  // Función para abrir enlaces
  void _launchURL(String url) async {
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication, // Use external browser
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Información de Contacto'),
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Imagen de perfil
              const CircleAvatar(
                radius: 80,
                backgroundImage: NetworkImage(
                  'https://media.licdn.com/dms/image/v2/D4E03AQFEAZNATSFUxw/profile-displayphoto-shrink_800_800/profile-displayphoto-shrink_800_800/0/1726257936707?e=1732147200&v=beta&t=jw2hl5jFrkqhn_vUe0Sz0q7I7AFpQHlcHmITORsswcQ',
                ),
              ),
              const SizedBox(height: 16),

              // Información personal
              const Text(
                'Nombre: Eduardo Vázquez Huerta',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Matrícula: 213377',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 8),
              const Text(
                'Grupo: 9b',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 16),

              // Enlaces a GitHub y LinkedIn
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.link),
                    onPressed: () =>
                        _launchURL('https://github.com/EduardoVH'),
                    tooltip: 'GitHub',
                  ),
                  const SizedBox(width: 16),
                  IconButton(
                    icon: const Icon(Icons.business),
                    onPressed: () =>
                        _launchURL('https://www.linkedin.com/in/eduardovazquezh/'),
                    tooltip: 'LinkedIn',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
