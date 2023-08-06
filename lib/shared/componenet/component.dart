
import 'package:flutter/material.dart';
import 'package:udemy_flutter/modules/users_screen.dart';

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  required String label,
  bool? secureText,
  bool? isEnabled = true,
  IconData? prefixIcon,
  IconData? suffixIcon,
  String? validatorErrorMessage,
  void Function(String?)? onSubmit,
  void Function(String?)? onChange,
  void Function()? onTap,
  void Function()? onSuffixPressed,
}) {
  return TextFormField(
    controller: controller,
    keyboardType: type,
    enabled: isEnabled,
    onFieldSubmitted: onSubmit,
    onChanged: onChange,
    onTap: onTap,
    obscureText: secureText ?? false,
    decoration: InputDecoration(
      labelText: label,
      prefixIcon: prefixIcon != null ? Icon(prefixIcon,) : null,
      suffixIcon: suffixIcon != null ? IconButton(
          icon: Icon(
            suffixIcon,
          ), onPressed: onSuffixPressed,
      ) : null,
      border: const OutlineInputBorder(),
    ),
    validator: (value) {
      if (value?.isEmpty == true) {
        return validatorErrorMessage;
      }
      return null;
    },
  );
}


Widget buildUserItem(UserModel users) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25,
              child: Text(
                '${users.id}',
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  users.name,
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  users.phone,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      );

      Widget buildTaksItem(Map tasks) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25,
              child: Text(
                '${tasks['id']}',
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${tasks['title']}',
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${tasks['date']}',
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      );