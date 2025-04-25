import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class CustomDropdownButtonFormField extends StatelessWidget {
  final String? value; // Giá trị hiện tại của dropdown
  final List<String> listItems; // Danh sách các mục dropdown
  final ValueChanged<String?> onChanged; // Hàm gọi khi giá trị thay đổi
  final String hintText; // Văn bản gợi ý

  const CustomDropdownButtonFormField({
    super.key,
    required this.value,
    required this.listItems,
    required this.onChanged,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    final getWidth = MediaQuery.of(context).size.width;

    return Container(
      margin: const EdgeInsets.all(6),
      width: 0.95 * getWidth,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 0.9),
        borderRadius: BorderRadius.circular(25),
      ),
      child: DropdownButtonFormField2<String>(
        value: listItems.contains(value) ? value : null, // Giá trị được chọn
        hint: Text(
          hintText, // Văn bản gợi ý
          style: const TextStyle(
              fontSize: 15, color: Colors.grey, fontWeight: FontWeight.w500),
        ),
        iconStyleData: const IconStyleData(
          icon: Icon(
            Icons.arrow_drop_down,
            color: Colors.black,
          ),
        ),
        isExpanded: true,
        items: listItems.map((item) => buildMenuItem(item)).toList(),
        onChanged: (newValue) {
          onChanged(newValue); // Gọi hàm onChanged khi giá trị thay đổi
        },
        decoration: const InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(
            Icons.school,
            color: Color(0xFF245D7C),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 10),
        ),
        dropdownStyleData: DropdownStyleData(
          maxHeight: 200,
          width: getWidth * 0.7,
          padding: const EdgeInsets.all(8),
          scrollPadding: const EdgeInsets.symmetric(vertical: 8),
          elevation: 10,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 3,
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          offset: const Offset(0, 5),
          openInterval: const Interval(0.2, 0.6, curve: Curves.easeInOut),
          useSafeArea: true,
          scrollbarTheme: ScrollbarThemeData(
            thickness: WidgetStateProperty.all(4),
            thumbColor: WidgetStateProperty.all(Colors.grey),
            radius: const Radius.circular(10),
            minThumbLength: 50,
          ),
        ),
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) {
    bool isSelected = item == value;
    return DropdownMenuItem(
      value: item,
      child: Text(
        item,
        style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: isSelected ? const Color(0xff00008b) : Colors.black),
      ),
    );
  }
}
