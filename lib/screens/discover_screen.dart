import 'package:flutter/material.dart';
import 'job_detail_screen.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F2EF),
      appBar: AppBar(
        title: const Text('Keşfet'),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Color(0xFF666666)),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Color(0xFF666666)),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Recommendations Section
            _buildSectionHeader('Senin için en uygun 3 fırsat', true),
            SizedBox(
              height: 200,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _buildOpportunityCard('Senior UX Designer', 'Spotify', 'Stockholm, SE', 'assets/spotify_logo.png', const Color(0xFF1DB954)),
                  _buildOpportunityCard('Product Manager', 'Airbnb', 'Remote', 'assets/airbnb_logo.png', const Color(0xFFFF5A5F)),
                  _buildOpportunityCard('Backend Engineer', 'Stripe', 'Dublin, IE', 'assets/stripe_logo.png', const Color(0xFF635BFF)),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // All Jobs Section
            _buildSectionHeader('Senin İçin İlanlar', false),
            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _buildJobListItem(context, 'Lead Product Designer', 'Revolut', 'Londra, UK', '2 gün önce', '94% Uyum'),
                _buildJobListItem(context, 'UI Engineer', 'Figma', 'San Francisco, US', '5 gün önce', '88% Uyum'),
                _buildJobListItem(context, 'Senior Content Strategist', 'Netflix', 'Los Angeles, US', '1 hafta önce', '82% Uyum'),
                _buildJobListItem(context, 'Flutter Developer', 'Google', 'Remote', '3 saat önce', '91% Uyum'),
              ],
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, bool showSparkle) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          if (showSparkle) ...[
            const SizedBox(width: 8),
            const Icon(Icons.auto_awesome, color: Color(0xFF003EC7), size: 18),
          ],
        ],
      ),
    );
  }

  Widget _buildOpportunityCard(String title, String company, String location, String logoPath, Color brandColor) {
    return Container(
      width: 260,
      margin: const EdgeInsets.only(right: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFEEEEEE)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: brandColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.business, color: brandColor), // Placeholder for logo
              ),
              const Icon(Icons.bookmark_border, color: Color(0xFFCCCCCC)),
            ],
          ),
          const Spacer(),
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 4),
          Text(
            '$company • $location',
            style: const TextStyle(color: Color(0xFF666666), fontSize: 13),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFF003EC7).withOpacity(0.05),
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Text(
              'AI Analiz: Yüksek Uyum',
              style: TextStyle(color: Color(0xFF003EC7), fontSize: 11, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildJobListItem(BuildContext context, String title, String company, String location, String time, String matchScore) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => JobDetailScreen(
              title: title,
              company: company,
              location: location,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFEEEEEE)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: const Color(0xFFF8F9FA),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.business, color: Color(0xFF666666)),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  Text(
                    company,
                    style: const TextStyle(color: Color(0xFF003EC7), fontSize: 13, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    location,
                    style: const TextStyle(color: Color(0xFF666666), fontSize: 12),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(time, style: const TextStyle(color: Color(0xFF999999), fontSize: 11)),
                      const SizedBox(width: 12),
                      const Icon(Icons.verified, size: 12, color: Colors.green),
                      const SizedBox(width: 4),
                      Text(matchScore, style: const TextStyle(color: Colors.green, fontSize: 11, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
            ),
            const Icon(Icons.bookmark_border, color: Color(0xFFCCCCCC)),
          ],
        ),
      ),
    );
  }
}
