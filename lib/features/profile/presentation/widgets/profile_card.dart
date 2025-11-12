import 'package:flutter/material.dart';
import 'package:non_stop/features/profile/data/models/profile_response.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    super.key,
    this.isEditProfile = false,
    this.profile,
    this.onEditPressed,
    this.isLoading = false,
    this.customImage,
  });

  final bool isEditProfile;
  final ProfileData? profile;
  final VoidCallback? onEditPressed;
  final bool isLoading;
  final ImageProvider? customImage;

  @override
  Widget build(BuildContext context) {
    final imageProvider = customImage ??
        (profile?.image != null && profile!.image!.isNotEmpty
            ? NetworkImage(profile!.image!)
            : const AssetImage('assets/pngs/image2.png') as ImageProvider);

    final name = profile?.name ?? '—';
    final email = profile?.email ?? '—';
    final completed =
        profile?.finishedBookingsCount?.toString() ?? '0';
    final active = profile?.activeBookingsCount?.toString() ?? '0';

    final totalSessions = (profile?.activeBookingsCount ?? 0) +
        (profile?.finishedBookingsCount ?? 0);
    final progress = totalSessions == 0
        ? 0.0
        : (profile?.finishedBookingsCount ?? 0) / totalSessions;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xff02040B),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 35,
            backgroundImage: imageProvider,
          ),
          const SizedBox(height: 8),
          Text(
            name,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            email,
            style: const TextStyle(color: Colors.grey, fontSize: 13),
          ),
          const SizedBox(height: 12),
          if (isEditProfile) ...[
            ElevatedButton(
              onPressed: isLoading ? null : onEditPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff9F5A5B),
                minimumSize: const Size(double.infinity, 50),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
              ),
              child: isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.edit, color: Colors.white),
                        SizedBox(width: 8),
                        Text(
                          "تعديل الملف الشخصي",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
            ),
            const SizedBox(height: 12),
          ],
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$completed :الحصص المكتملة',
                style: const TextStyle(color: Colors.grey),
              ),
              const SizedBox(width: 16),
              Text(
                '$active :الحصص المتبقية',
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: progress.isFinite ? progress : 0,
              color: const Color(0xff9F5A5B),
              backgroundColor: Colors.grey,
              minHeight: 6,
            ),
          ),
        ],
      ),
    );
  }
}
