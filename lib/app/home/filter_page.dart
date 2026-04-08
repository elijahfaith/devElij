import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:link_go/models/CategoriesModel.dart';
import 'package:link_go/providers/product_provider.dart';
import 'package:link_go/providers/provider.dart';
import '../../../utils/app_colors.dart';
import '../../models/categories_with_subcategories.dart';
import '../../utils/app_utils.dart';
import '../../utils/multi_color_pie.dart';
import '../widgets/custom_button.dart';

class FilterPage extends ConsumerStatefulWidget {
  const FilterPage({super.key});

  @override
  ConsumerState<FilterPage> createState() => _CategoryFilterState();
}

class _CategoryFilterState extends ConsumerState<FilterPage> {
  RangeValues _priceRange = const RangeValues(0, 5000000);
  final double _minPrice = 0;
  final double _maxPrice = 5000000;
  int selectedColorIndex = -1;
  int selectedConditionIndex = -1;
  Set<int> selectedCategoryIndex =
      {}; // Declare this in your State class or provider
  //int selectedSizeIndex = -1;
  Set<int> selectedConditionIndexes = {};
  List<String> selectedSizes = [];
  late ProductProvider productProvider;

  final List<Color> colors = [
    Colors.black,
    Colors.white,
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.pink,
    Colors.purple,
  ];

  final List<String> sizes = ['XS', 'S', 'M', 'L', 'XL', 'XXL'];

  final Set<String> selectedCategories = {'Tops'};

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      // productProvider.fetchCondition();
      // productProvider.getCategoriesByHierarchy();
      // productProvider.setMyProductColor();
    });
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = ref.watch(RiverpodProvider.productProvider);
    final sizes = productProvider.filterSizes;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Filters',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.black)),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                )
              ],
            ),
            Divider(),
            Text("Price Range", style: GoogleFonts.roboto(color: Colors.black)),
            SizedBox(height: 5.h),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildPriceBox("₦ ${_priceRange.start.toInt()}"),
                _buildPriceBox("₦ ${_priceRange.end.toInt()}"),
              ],
            ),

            SizedBox(height: 5.h),
            RangeSlider(
              values: _priceRange,
              min: _minPrice,
              max: _maxPrice,
              divisions: 100,
              activeColor: AppColors.primaryColor,
              inactiveColor: Colors.grey.shade300,
              onChanged: (RangeValues values) {
                setState(() {
                  _priceRange = values;
                });
              },
            ),

            SizedBox(height: 5.h),
            Text(
              'Size',
              style: GoogleFonts.roboto(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.lightTextBlack),
            ),
            SizedBox(height: 10.h),
            // Wrap(
            //   spacing: 10,
            //   runSpacing: 10,
            //   children: List.generate(sizes.length, (index) {
            //     final size = sizes[index];
            //     final isSelected = selectedSizes.contains(size);
            //
            //     return GestureDetector(
            //       onTap: () {
            //         setState(() {
            //           if (isSelected) {
            //             selectedSizes.remove(size);
            //           } else {
            //             selectedSizes.add(size);
            //           }
            //         });
            //       },
            //       child: Container(
            //         padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            //         decoration: BoxDecoration(
            //           color: isSelected ? AppColors.primaryColor : Colors.transparent,
            //           borderRadius: BorderRadius.circular(30),
            //           border: Border.all(color: Colors.teal),
            //         ),
            //         child: Text(
            //           size,
            //           style: TextStyle(
            //             color: isSelected ? Colors.white : Colors.black,
            //             fontWeight: FontWeight.w500,
            //           ),
            //         ),
            //       ),
            //     );
            //   }),
            // ),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: List.generate(sizes.length, (index) {
                final size = sizes[index];
                final isSelected = selectedSizes.contains(size);
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      if (isSelected) {
                        selectedSizes.remove(size);
                      } else {
                        selectedSizes.add(size);
                      }
                    });
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primaryColor
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.teal, width: 1.8.w),
                    ),
                    child: Text(
                      size,
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: isSelected ? Colors.white : Colors.black,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                );
              }),
            ),
            SizedBox(height: 10.h),
            Text(
              'Color',
              style: GoogleFonts.roboto(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.lightTextBlack),
            ),
            SizedBox(height: 10),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 6,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemCount: productProvider.productColor.length,
              itemBuilder: (context, index) {
                final colorModel = productProvider.productColor[index];
                final colorHex = colorModel.colorHex;
                final isSelected =
                    productProvider.filteredColors.contains(colorModel);
                Widget colorWidget;
                if (colorHex.toLowerCase() == "multi") {
                  colorWidget = const ClipOval(
                    child: SizedBox.expand(
                      child: MultiColorCircle(),
                    ),
                  );
                } else {
                  // Normal color
                  final color = hexToColor(colorHex);
                  colorWidget = Container(
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                      border: color == Colors.white
                          ? Border.all(color: Colors.grey)
                          : null,
                    ),
                  );
                }
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      if (isSelected) {
                        productProvider.filteredColors.remove(colorModel);
                      } else {
                        productProvider.filteredColors.add(colorModel);
                      }
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: isSelected
                          ? Border.all(color: Colors.black, width: 2)
                          : null,
                    ),
                    child: colorWidget,
                  ),
                );
              },
            ),

            SizedBox(height: 10),
            Text(
              'Condition',
              style: GoogleFonts.roboto(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.lightTextBlack),
            ),
            SizedBox(
              height: 15.h,
            ),

            productProvider.productCondition.isEmpty
                ? const Center(child: CircularProgressIndicator(color: AppColors.primaryColor,))
                : GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    mainAxisSpacing: 11,
                    crossAxisSpacing: 8,
                    childAspectRatio: 3.5,
                    children: List.generate(
                        productProvider.productCondition.length, (index) {
                      final condition = productProvider.productCondition[index];
                      final bool isSelected =
                          selectedConditionIndexes.contains(index);

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            if (isSelected) {
                              selectedConditionIndexes.remove(index);
                              productProvider.filteredConditions
                                  .remove(condition);
                            } else {
                              selectedConditionIndexes.add(index);
                              productProvider.filteredConditions.add(condition);
                            }
                            // productProvider.filteredConditions = productProvider.filteredConditions;
                            // print(productProvider.filteredConditions.map((c) => c.name).toList());
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 2),
                          decoration: BoxDecoration(
                            color: isSelected ? Colors.green[35] : Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              width: 1.8,
                              color: isSelected
                                  ? AppColors.primaryColor
                                  : AppColors.greyLight,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              condition.name,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              'Categories',
              style: GoogleFonts.roboto(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.lightTextBlack,
              ),
            ),
            SizedBox(height: 15.h),
            FutureBuilder<List<CategoryModel>>(
              future: productProvider.categoWithSub,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Container(
                    height: 150.h,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Center(
                      child: CircularProgressIndicator(
                          color: AppColors.primaryColor),
                    ),
                  );
                } else if (snapshot.data!.isNotEmpty) {
                  return SizedBox(
                    height: 120.h,
                    child: GridView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: snapshot.data!.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        childAspectRatio: 0.5,
                      ),
                      itemBuilder: (context, index) {
                        final category = snapshot.data![index];
                        final bool isSelected =
                            selectedCategoryIndex.contains(index);
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              if (isSelected) {
                                selectedCategoryIndex.remove(index);
                                productProvider.selectedFilterCategory
                                    ?.remove(category);
                              } else {
                                selectedCategoryIndex.add(index);
                                productProvider.selectedFilterCategory
                                    ?.add(category);
                              }
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 2),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                width: 1.8.w,
                                color: isSelected
                                    ? AppColors.primaryColor
                                    : AppColors.greyLight,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                category.name,
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.w500,
                                  color: AppColors.lightTextBlack,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 100),
                        Text(
                          'Network error',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text('Network error'),
                        SizedBox(height: 100),
                      ],
                    ),
                  );
                } else {
                  return const Center(
                    child: Column(
                      children: [
                        SizedBox(height: 50),
                        Text(
                          "There is no Categories available",
                          style:
                              TextStyle(fontSize: 14, color: AppColors.black),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 30),
                      ],
                    ),
                  );
                }
              },
            ),
            SizedBox(height: 15.h),
            Row(
              spacing: 7.w,
              children: [
                Expanded(
                  child: CustomButton(
                    onPressed: () {
                      // // Handle Reset
                      // setState(() {
                      //   selectedColorIndex = 0;
                      //   selectedSizeIndex = 2;
                      //   _priceRange = const RangeValues(0, 50000);
                      //   selectedCategories.clear();
                      // });
                      setState(() {
                        selectedColorIndex = -1;
                        // selectedSizes = null; //-1;
                        selectedConditionIndex = -1;
                        _priceRange = const RangeValues(0, 500000);
                        selectedCategories.clear();
                        productProvider.filteredColors = [];
                        selectedSizes = [];
                        productProvider.filteredConditions = [];
                        productProvider.selectedFilterCategory = [];
                        selectedCategoryIndex = {};
                      });
                    },
                    label: 'Reset',
                    borderColor: AppColors.primaryColor,
                    fillColor: AppColors.white,
                    buttonTextColor: AppColors.primaryColor,
                  ),
                ),
                Expanded(
                  child: CustomButton(
                    onPressed: () {
                      productProvider.setMyFilteredProduct(
                        categories: productProvider.selectedFilterCategory
                            ?.map((c) => c.id)
                            .toList(),
                        color: productProvider.filteredColors
                            .map((c) => c.colorName)
                            .toList(),
                        sizes: selectedSizes.isNotEmpty ? selectedSizes : [],
                        condition: productProvider.filteredConditions
                            .map((c) => c.id)
                            .toList(),
                        priceMin: _priceRange.start.toInt(),
                        priceMax: _priceRange.end.toInt(),
                      );
                      productProvider.markFilterAsApplied();
                      Navigator.pop(context);
                    },
                    label: 'Apply Filter',
                    fillColor: AppColors.primaryColor,
                    buttonTextColor: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceBox(String text) {
    return Text(
      text,
      style: GoogleFonts.roboto(
        fontWeight: FontWeight.w500,
        color: AppColors.black,
      ),
    );
  }
}
