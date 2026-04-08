import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:link_go/providers/product_provider.dart';
import '../../models/CategoriesModel.dart';
import '../../models/categories_with_subcategories.dart';
import '../../providers/provider.dart';
import '../../utils/app_colors.dart';
import '../../utils/assets_manager.dart';
import '../../utils/progress_bar_manager/utility_app_bar.dart';

class SubcategoryPage extends ConsumerWidget {
  final CategoryModel category;
  final List<CategoryModel> subcategories;

   SubcategoryPage({
    super.key,
    required this.category,
    required this.subcategories,
  });

  late ProductProvider productProvider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    productProvider = ref.watch(RiverpodProvider.productProvider);
    return Scaffold(
      appBar: UtilityAppBar(
        centerTitle: false,
        text: "${category.name}",
        hasActions: false,
      ),
      body: subcategories.isEmpty
          ? Center(child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                Assets.link_goLogo,
                height: 50.h,
                // color: Colors.white,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text("No subcategories found"),
            ],
          ))
          : GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 0.75,
        ),
        itemCount: subcategories.length,
        itemBuilder: (context, index) {
          final sub = subcategories[index];
          return GestureDetector(
            onTap: () async {
              final products = await productProvider
                  .getProductLoading(sub.id ?? '');
              if (products != null) {
                productProvider.pushToAllScreen(
                  sub.name?? '',
                  products,
                );
              }
            },
            child: Column(
              children: [
                Container(
                  height: 64.h,
                  width: 64.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primaryColor.withOpacity(0.1),
                  ),
                  child: Center(
                    child: Text(
                      sub.name.length >= 2
                          ? sub.name.substring(0, 2).toUpperCase()
                          : sub.name.substring(0, 1).toUpperCase(),
                      style: GoogleFonts.roboto(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15.h),
                Text(
                  sub.name,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.roboto(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
