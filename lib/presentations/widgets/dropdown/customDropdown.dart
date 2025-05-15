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

    return SizedBox(
      width: 0.15 * getWidth,
      child: DropdownButtonFormField2<String>(
        value: listItems.contains(value) ? value : null,
        iconStyleData: const IconStyleData(
          icon: Icon(
            Icons.arrow_drop_down,
            color: Colors.black,
          ),
        ),
        isExpanded: true,
        items: listItems.map((item) => buildMenuItem(item)).toList(),
        onChanged: (newValue) {
          onChanged(newValue);
        },
        decoration: const InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 10),
        ),
        dropdownStyleData: DropdownStyleData(
          // maxHeight: 200,
          width: getWidth * 0.32,
          scrollPadding: const EdgeInsets.symmetric(vertical: 3),
          elevation: 10,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
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
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.w500 : FontWeight.w100,
            color: isSelected ? Colors.black : Colors.grey),
      ),
    );
  }
}
