import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ContactInfo extends StatelessWidget {
  const ContactInfo({super.key});

  // Function to launch URLs
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
        title: const Text('Contact Information'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Profile picture with border
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.blue, width: 4),
                ),
                child: const CircleAvatar(
                  radius: 80,
                  backgroundImage: NetworkImage(
                    'https://media.licdn.com/dms/image/v2/D4E03AQFEAZNATSFUxw/profile-displayphoto-shrink_800_800/profile-displayphoto-shrink_800_800/0/1726257936707?e=1732147200&v=beta&t=jw2hl5jFrkqhn_vUe0Sz0q7I7AFpQHlcHmITORsswcQ',
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Personal information
              Text(
                'Eduardo Vázquez Huerta',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                '213377',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 8),
              Text(
                '9B',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 16),

              // Links to GitHub and LinkedIn
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const FaIcon(
                      FontAwesomeIcons.github,
                      color: Colors.black,
                      size: 32,
                    ), // GitHub icon
                    onPressed: () =>
                        _launchURL('https://github.com/EduardoVH'),
                    tooltip: 'GitHub',
                  ),
                  const SizedBox(width: 16),
                  IconButton(
                    icon: const FaIcon(
                      FontAwesomeIcons.linkedin,
                      color: Colors.blue,
                      size: 32,
                    ), // LinkedIn icon
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
